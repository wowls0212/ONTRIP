package com.mbc.ontrip.hotel;

import java.io.*;
import java.nio.charset.StandardCharsets;
import java.util.*;
import org.springframework.stereotype.Service;

@Service
public class CsvHotelService {

    public List<HotelInfo> readAll(String path) {
        List<HotelInfo> list = new ArrayList<>();
        try (BufferedReader br = new BufferedReader(
                new InputStreamReader(new FileInputStream(path), StandardCharsets.UTF_8))) {

            String line;
            boolean first = true;
            while ((line = br.readLine()) != null) {
                if (first) { first = false; continue; }

                String[] c = splitCSVLine(line);
                if (c.length < 7) continue;

                HotelInfo h = new HotelInfo();
                h.set도시(c[0]);
                h.set체크인(c[1]);
                h.set체크아웃(c[2]);
                h.set호텔명(c[3]);
                h.set이미지(c[4]);

                String rawPrice = c[5].replaceAll("[^0-9]", "");
                h.set가격(rawPrice);

                h.set링크(c[6]);
                list.add(h);
            }

        } catch (IOException e) {
            e.printStackTrace();
        }
        return list;
    }

    private String[] splitCSVLine(String line) {
        List<String> tokens = new ArrayList<>();
        StringBuilder sb = new StringBuilder();
        boolean inQuotes = false;

        for (int i = 0; i < line.length(); i++) {
            char c = line.charAt(i);
            if (c == '\"') {
                inQuotes = !inQuotes;
            } else if (c == ',' && !inQuotes) {
                tokens.add(sb.toString().trim());
                sb.setLength(0);
            } else {
                sb.append(c);
            }
        }
        tokens.add(sb.toString().trim());
        return tokens.toArray(new String[0]);
    }

    public int getFilteredCount(String path, String keyword, String date) {
        int count = 0;
        for (HotelInfo h : readAll(path)) {
            if ((h.get호텔명() != null && h.get호텔명().contains(keyword)) ||
                (h.get도시() != null && h.get도시().contains(keyword))) {
                if (date.isEmpty() || (h.get체크인() != null && h.get체크인().equals(date))) {
                    count++;
                }
            }
        }
        return count;
    }

    public List<HotelInfo> getPagedAndFiltered(String path, String keyword, String date, HotelPageDTO dto) {
        List<HotelInfo> filtered = new ArrayList<>();
        for (HotelInfo h : readAll(path)) {
            if ((h.get호텔명() != null && h.get호텔명().contains(keyword)) ||
                (h.get도시() != null && h.get도시().contains(keyword))) {
                if (date.isEmpty() || (h.get체크인() != null && h.get체크인().equals(date))) {
                    filtered.add(h);
                }
            }
        }
        int start = dto.getStart();
        int end = Math.min(start + dto.getCntPerPage(), filtered.size());

        return filtered.subList(start, end);
    }
}