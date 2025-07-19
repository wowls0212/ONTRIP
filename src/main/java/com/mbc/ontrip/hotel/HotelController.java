package com.mbc.ontrip.hotel;

import java.util.List;
import java.util.Optional;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class HotelController {

    @Autowired
    CsvHotelService service;

    @RequestMapping(value = "/hotel", method = RequestMethod.GET)
    public String showHotels(Model model, HttpServletRequest request) {
        String path = "C:/MBC12AI/spring/hotels/hotel_list.csv";

        String keyword = Optional.ofNullable(request.getParameter("keyword")).orElse("").trim();
        String date = Optional.ofNullable(request.getParameter("date")).orElse("").trim();
        int nowPage = Integer.parseInt(Optional.ofNullable(request.getParameter("nowPage")).orElse("1"));
        int cntPerPage = Integer.parseInt(Optional.ofNullable(request.getParameter("cntPerPage")).orElse("10"));

        int total = service.getFilteredCount(path, keyword, date);
        HotelPageDTO dto = new HotelPageDTO(nowPage, total, cntPerPage);
        List<HotelInfo> hotels = service.getPagedAndFiltered(path, keyword, date, dto);

        model.addAttribute("hotels", hotels);
        model.addAttribute("paging", dto);
        model.addAttribute("keyword", keyword);
        model.addAttribute("date", date);

        return "hotels";
    }
}