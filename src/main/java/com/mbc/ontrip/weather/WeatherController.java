package com.mbc.ontrip.weather;

import java.net.URLEncoder;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;



@Controller
public class WeatherController {

    @RequestMapping("/weather")
    public String getWeather(@RequestParam(value = "city", required = false) String city,
                             Model model) {

        if (city == null || city.trim().isEmpty()) {
            return "weather";
        }

        try {
            RestTemplate restTemplate = new RestTemplate();;

            String geoUrl = "https://geocoding-api.open-meteo.com/v1/search?name=" + URLEncoder.encode(city, "UTF-8") + "&count=1";
            String geoJson = restTemplate.getForObject(geoUrl, String.class);

            ObjectMapper mapper = new ObjectMapper();
            JsonNode geoRoot = mapper.readTree(geoJson);
            JsonNode results = geoRoot.path("results");
            	
            if (results.isMissingNode() || results.size() == 0) {
                model.addAttribute("error", "도시를 찾을 수 없습니다.");
                return "weather";
            }

            double lat = results.get(0).path("latitude").asDouble();
            double lon = results.get(0).path("longitude").asDouble();

            String weatherUrl = "https://api.open-meteo.com/v1/forecast?latitude=" + lat
                    + "&longitude=" + lon
                    + "&current_weather=true";
            String weatherJson = restTemplate.getForObject(weatherUrl, String.class);
            JsonNode weatherRoot = mapper.readTree(weatherJson);
            JsonNode current = weatherRoot.path("current_weather");
            JsonNode result = results.get(0);
            String country = result.path("country").asText();
            String rawTime = current.path("time").asText();
            LocalDateTime ldt = LocalDateTime.parse(rawTime);
            LocalDateTime adjusted = ldt.plusHours(9);
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy년 M월 d일 H시m분");
            String formattedTime = adjusted.format(formatter);


            model.addAttribute("city", city);
            model.addAttribute("temperature", current.path("temperature").asDouble());
            model.addAttribute("windspeed", current.path("windspeed").asDouble());
            model.addAttribute("timeFormatted", formattedTime);
            model.addAttribute("weatherCodeNow", current.path("weathercode").asInt());
            model.addAttribute("country", country);

            String forecastUrl = "https://api.open-meteo.com/v1/forecast?latitude=" + lat
                    + "&longitude=" + lon
                    + "&daily=temperature_2m_max,temperature_2m_min,weathercode"
                    + "&timezone=Asia/Seoul";
            String forecastJson = restTemplate.getForObject(forecastUrl, String.class);
            JsonNode forecastRoot = mapper.readTree(forecastJson);
            JsonNode daily = forecastRoot.path("daily");
            
            if (daily.isMissingNode() || daily.get("time") == null) {
                model.addAttribute("error", "예보 데이터를 불러올 수 없습니다.");
                return "weather";
            }


            List<String> dates = new ArrayList<>();
            List<Double> minTemps = new ArrayList<>();
            List<Double> maxTemps = new ArrayList<>();
            List<Integer> weatherCodes = new ArrayList<>();


            for (int i = 0; i < daily.get("time").size(); i++) {
                dates.add(daily.get("time").get(i).asText());
                minTemps.add(daily.get("temperature_2m_min").get(i).asDouble());
                maxTemps.add(daily.get("temperature_2m_max").get(i).asDouble());
                weatherCodes.add(daily.get("weathercode").get(i).asInt());

            }

            model.addAttribute("dates", dates);
            model.addAttribute("minTemps", minTemps);
            model.addAttribute("maxTemps", maxTemps);
            model.addAttribute("weatherCodes", weatherCodes);


        } catch (Exception e) {
            model.addAttribute("error", "날씨 정보를 불러오는 데 실패했습니다.");
            e.printStackTrace();
        }
        return "weather";
    }
}