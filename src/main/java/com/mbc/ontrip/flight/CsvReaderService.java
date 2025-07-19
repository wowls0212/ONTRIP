package com.mbc.ontrip.flight;

import java.io.*;
import java.nio.charset.StandardCharsets;
import java.util.*;

import org.springframework.stereotype.Service;

@Service
public class CsvReaderService {

    public List<FlightInfo> readAll(String path) {
        List<FlightInfo> list = new ArrayList<>();
        try (BufferedReader br = new BufferedReader(
                new InputStreamReader(new FileInputStream(path), StandardCharsets.UTF_8))) {
            String line;
            boolean first = true;
            while ((line = br.readLine()) != null) {
                if (first) { first = false; continue; }

                String[] c = line.split(",", -1);
                if (c.length < 11) continue;

                FlightInfo f = new FlightInfo();
                f.set출발일(c[10]);
                try { f.set가격(Integer.parseInt(c[0].trim())); } catch (Exception e) { f.set가격(0); }
                f.set항공사(c[1]); f.set경유정보(c[2]); f.set출발시간(c[3]); f.set출발공항(c[4]);
                f.set도착시간(c[5]); f.set도착공항(c[6]); f.set총비행시간(c[7]);
                f.set경유지(c[8]); f.set경유시간(c[9]);

                list.add(f);
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return list;
    }

    public int getFilteredCount(String path, String from, String to, String date) {
        int count = 0;
        for (FlightInfo f : readAll(path)) {
        	if ((from.isEmpty() || f.get항공사().contains(from) || f.get출발공항().contains(from)) &&
                    (to.isEmpty() || f.get도착공항().contains(to)) &&
                    (date.isEmpty() || f.get출발일().equals(date))) {
                    count++;
                }

        }
        return count;
    }

    public List<FlightInfo> getPagedAndFiltered(String path, String from, String to, String date, FlightPageDTO dto) {
        List<FlightInfo> filtered = new ArrayList<>();
        for (FlightInfo f : readAll(path)) {
        	if ((from.isEmpty() || f.get항공사().contains(from) || f.get출발공항().contains(from)) &&
                    (to.isEmpty() || f.get도착공항().contains(to)) &&
                    (date.isEmpty() || f.get출발일().equals(date))) {
                    filtered.add(f);
                }

        }
        int start = dto.getStart();
        int end = Math.min(start + dto.getCntPerPage(), filtered.size());

        return filtered.subList(start, end);
    }

}

