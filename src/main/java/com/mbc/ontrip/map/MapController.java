package com.mbc.ontrip.map;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class MapController {
	
	@Autowired
	SqlSession sqlsession;
	
	@RequestMapping(value = "map")
	public String map() {
		return "map";
	}
	
	@RequestMapping(value = "/addplace", method = RequestMethod.POST)
	@ResponseBody
	public String addPlace(HttpServletRequest request,HttpSession session) {
		String userid = (String)session.getAttribute("id");
		String placename = request.getParameter("placename");
		String address = request.getParameter("address");
		String phone = request.getParameter("phone");
		double lat = Double.parseDouble(request.getParameter("lat"));
		double lng = Double.parseDouble(request.getParameter("lng"));
		int placeorder = Integer.parseInt(request.getParameter("placeorder"));
		UserPlaceDTO dto = new UserPlaceDTO();
		dto.setUserid(userid);
		dto.setPlacename(placename);
		dto.setAddress(address);
		dto.setPhone(phone);
		dto.setLat(lat);
		dto.setLng(lng);
		dto.setPlaceorder(placeorder);
		UserPlaceService ups = sqlsession.getMapper(UserPlaceService.class);
		ups.insertPlace(dto);
		System.out.println("↓ 저장 요청 정보 ↓");
		System.out.println("ID = " + userid);
		System.out.println("placename = " + placename);
		System.out.println("address = " + address);
		System.out.println("phone = " + phone);
		System.out.println("lat = " + lat);
		System.out.println("lng = " + lng);
		System.out.println("순서 = " + placeorder);
		return "saved";
	}
	
	@RequestMapping(value = "/updateorder")
	public String updateorder(@RequestBody List<UserPlaceDTO> places) {
		UserPlaceService ups = sqlsession.getMapper(UserPlaceService.class);
		for (UserPlaceDTO dto : places) {
	        ups.updatePlaceOrder(dto.getUserid(), dto.getPlacename(), dto.getPlaceorder());
	    }

		return "order_updated";
	}
	
	@RequestMapping(value = "/getPlaces", method = RequestMethod.GET, produces = "application/json")
	@ResponseBody
	public List<UserPlaceDTO> getPlaces(@RequestParam String userid) {
	    UserPlaceService ups = sqlsession.getMapper(UserPlaceService.class);
	    return ups.getPlacesByUser(userid);
	}


	

	
}
