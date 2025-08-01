package com.mbc.ontrip;

import java.text.DateFormat;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Date;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.ui.Model;

import com.mbc.ontrip.country.CountryDTO;
import com.mbc.ontrip.country.CountryPageDTO;
import com.mbc.ontrip.country.CountryService;
import com.mbc.ontrip.pack.PackDTO;
import com.mbc.ontrip.pack.PackPageDTO;
import com.mbc.ontrip.pack.PackService;
import com.mbc.ontrip.user.UserDTO;
import com.mbc.ontrip.user.UserService;
import com.mbc.ontrip.wifi.WIfiDTO;
import com.mbc.ontrip.wifi.WifiService;
import com.mbc.ontrip.wifi.WifiPageDTO;


@Controller
public class HomeController {
	
	@Autowired
	SqlSession sqlsession;

	@RequestMapping(value = "/")
	public String home(HttpServletRequest request,Model model) {
		HttpSession hs = request.getSession();
		hs.setAttribute("loginstate", false);
		LocalDate today = LocalDate.now();
		CountryService cs = sqlsession.getMapper(CountryService.class);
		int month = today.getMonthValue();
		ArrayList<CountryDTO> mon = cs.month(month);
		model.addAttribute("mon", mon);
		return "main";
	}
	

	@RequestMapping(value = "/logoutmain")
	public String logoutMain(HttpServletRequest request, Model model) {
		HttpSession hs = request.getSession();
		hs.setAttribute("loginstate", false);
		LocalDate today = LocalDate.now();
		CountryService cs = sqlsession.getMapper(CountryService.class);
		int month = today.getMonthValue();
		ArrayList<CountryDTO> mon = cs.month(month);
		model.addAttribute("mon", mon);
	    return "main"; 
	}

	
	
	@RequestMapping(value = "main")
	public String main(HttpServletRequest request, Model model) {
		HttpSession hs = request.getSession();
		hs.setAttribute("loginstate", true);
		LocalDate today = LocalDate.now();
		CountryService cs = sqlsession.getMapper(CountryService.class);
		int month = today.getMonthValue();
		ArrayList<CountryDTO> mon = cs.month(month);
		model.addAttribute("mon", mon);
		String userid = (String) hs.getAttribute("id");
		UserService us = sqlsession.getMapper(UserService.class);
		UserDTO user = us.tripstyle(userid);
		String tripstyle = user.getTripstyle();
		model.addAttribute("tripstyle", tripstyle);
		ArrayList<CountryDTO> constyle = cs.constyle(tripstyle);
		model.addAttribute("constyle", constyle);
		return "main";
	}
	
	@RequestMapping(value = "mainsearch")
	public String mainsearch(HttpServletRequest request, Model model) {
		String mainsearch = request.getParameter("mainsearch");
		CountryService cs = sqlsession.getMapper(CountryService.class);
		PackService ps = sqlsession.getMapper(PackService.class);
		WifiService ws = sqlsession.getMapper(WifiService.class);
		ArrayList<CountryDTO> list = cs.mainsearch(mainsearch);
		ArrayList<PackDTO> list2 = ps.mainsearch(mainsearch);
		ArrayList<WIfiDTO> list3 = ws.mainsearch(mainsearch);
		model.addAttribute("mainsearch", mainsearch);
		model.addAttribute("list", list);
		model.addAttribute("list2", list2);
		model.addAttribute("list3", list3);
		return "mainsearch";
	}
	
}
