package com.mbc.ontrip.flight;
import java.util.*;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;


@Controller
public class FlightController {

    @Autowired
    private CsvReaderService service;

    @RequestMapping(value = "/flight", method = RequestMethod.GET)
    public String showFlights(Model model, HttpServletRequest request) {
        String path = "C:/MBC12AI/spring/flight/flight.csv";

        String from = Optional.ofNullable(request.getParameter("from")).orElse("").trim();
        String to = Optional.ofNullable(request.getParameter("to")).orElse("").trim();
        String date = Optional.ofNullable(request.getParameter("date")).orElse("").trim();
        String np = request.getParameter("nowPage");
        String cpp = request.getParameter("cntPerPage");
        int nowPage = np == null ? 1 : Integer.parseInt(np);
        int cntPerPage = cpp == null ? 10 : Integer.parseInt(cpp);

        int total = service.getFilteredCount(path, from,to, date);
        FlightPageDTO dto = new FlightPageDTO(nowPage, total, cntPerPage);
        List<FlightInfo> list = service.getPagedAndFiltered(path, from,to, date, dto);

        model.addAttribute("flights", list);
        model.addAttribute("paging", dto);
        model.addAttribute("from", from);
        model.addAttribute("to", to);
        model.addAttribute("date", date);

        return "flights";
    }
}
    
