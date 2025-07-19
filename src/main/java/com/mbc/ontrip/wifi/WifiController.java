package com.mbc.ontrip.wifi;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.mbc.ontrip.country.CountryPageDTO;
import com.mbc.ontrip.pack.PackService;

@Controller
public class WifiController {
	
	@Autowired
	SqlSession sqlsession;
	String path = "C:\\mbc12AI\\spring\\ontrip\\src\\main\\webapp\\image";
	
	@RequestMapping(value = "wifiinput")
	public String wifi1() {
		
		return "wifiinput";
	}
	@RequestMapping(value = "wifisave")
	public String wifisave(MultipartHttpServletRequest request) throws IllegalStateException, IOException {
		MultipartFile mf = request.getFile("wifiimg");
		String image = mf.getOriginalFilename();
		UUID uu = UUID.randomUUID();
		image = uu+"-"+image;		
		mf.transferTo(new File(path+"//"+image));
		String wifiname = request.getParameter("wifiname");
		String wifidetail = request.getParameter("wifidetail");
		String wifilink = request.getParameter("wifilink");
		String wificountry=request.getParameter("wificountry");
		int wifiday = Integer.parseInt(request.getParameter("wifiday"));
		WifiService ws = sqlsession.getMapper(WifiService.class);
		ws.wifiin(wifiname,image,wifidetail,wifilink,wificountry,wifiday);
		return "redirect:/main";
	}
	
	@RequestMapping(value = "wifiout")
	public String wifiout(Model model, HttpServletRequest request, WifiPageDTO pdto) {
		String id = (String) request.getSession().getAttribute("id");
		String nowPage = request.getParameter("nowPage");
		String cntPerPage = request.getParameter("cntPerPage");
		WifiService ws = sqlsession.getMapper(WifiService.class);
		int total = ws.wifitotal();
		if(nowPage==null && cntPerPage == null) {
	           nowPage="1";
	           cntPerPage="16";
	    }
	    else if(nowPage==null) {
	    	nowPage="1";
	    }
	    else if(cntPerPage==null) {
	    	cntPerPage="16";
	    }
		pdto = new WifiPageDTO(Integer.parseInt(nowPage), total, Integer.parseInt(cntPerPage));
		ArrayList<WIfiDTO> list = ws.wifiout(pdto);
		for(WIfiDTO dto : list) {
			int wifinum = dto.getWifinum();
			boolean liked = false;
			if(id != null && !id.trim().isEmpty()) {
				int result = ws.wifiisLiked(id,wifinum);
				liked = (result >0);
				dto.setLiked(result >0);
			}
		}
		model.addAttribute("list", list);
		model.addAttribute("id", id);
		model.addAttribute("paging", pdto);
		return "wifiout";
	}
	@RequestMapping(value = "wifidelete")
	public String wifidel(HttpServletRequest request) {
		int wifinum = Integer.parseInt(request.getParameter("wifinum"));
		WifiService ws = sqlsession.getMapper(WifiService.class);
		ws.wifidel(wifinum);
		return "redirect:/wifiout";
	}
	@RequestMapping(value = "wifiupdate")
	public String wifiupview(HttpServletRequest request,Model model) {
		int wifinum = Integer.parseInt(request.getParameter("wifinum"));
		WifiService ws = sqlsession.getMapper(WifiService.class);
		WIfiDTO dto = ws.wifiupdateview(wifinum);
		model.addAttribute("dto", dto);
		return "wifiupdateview";
	}
	@RequestMapping(value = "wifiupdatesave")
	public String wifiup(MultipartHttpServletRequest request) throws IllegalStateException, IOException {
		int wifinum = Integer.parseInt(request.getParameter("wifinum"));
		String wifiname = request.getParameter("wifiname");
		String wifidetail = request.getParameter("wifidetail");
		String wifilink = request.getParameter("wifilink");
		String wificountry=request.getParameter("wificountry");
		int wifiday = Integer.parseInt(request.getParameter("wifiday"));
		MultipartFile mf = request.getFile("wifiimg");
		String image = mf.getOriginalFilename();
		if(image==null||image.trim().isEmpty()) {
			image = request.getParameter("lastimg");
		}else {
			UUID uu = UUID.randomUUID();
			image = uu+"-"+image;		
			mf.transferTo(new File(path+"//"+image));
			String lastimg = request.getParameter("lastimg");
			File ff = new File(path+"//"+lastimg);
			ff.delete();
		}
		WifiService ws = sqlsession.getMapper(WifiService.class);
		ws.wifiup(wifinum,wifiname,wifidetail,wifilink,wificountry,wifiday,image);
		return "redirect:/wifiout";
	}
	@RequestMapping(value = "wificountry")
	public String wificountry(HttpServletRequest request, Model model, WifiPageDTO dto) {
		String country = request.getParameter("wificon");
		String nowPage = request.getParameter("nowPage");
		String cntPerPage = request.getParameter("cntPerPage");
	    HttpSession session = request.getSession();
	    String userId = (String) session.getAttribute("id");
		WifiService ws = sqlsession.getMapper(WifiService.class);
		int total = ws.wifisertotal(country);
		if(nowPage==null && cntPerPage == null) {
	           nowPage="1";
	           cntPerPage="16";
	    }
	    else if(nowPage==null) {
	    	nowPage="1";
	    }
	    else if(cntPerPage==null) {
	    	cntPerPage="16";
	    }
		dto = new WifiPageDTO(Integer.parseInt(nowPage), total, Integer.parseInt(cntPerPage));
		ArrayList<WIfiDTO> list = ws.wificountry(country,dto);
		if (userId != null) {
	        ArrayList<Integer> likedNums = ws.getLikedWifiNums(userId); // 좋아요한 상품 번호 리스트
	        for (WIfiDTO wifi : list) {
	            if (likedNums.contains(wifi.getWifinum())) {
	                wifi.setLiked(true);
	            }
	        }
	    }
		for(WIfiDTO wdto : list) {
			int wifinum = wdto.getWifinum();
			boolean liked = false;
			if(userId != null && !userId.trim().isEmpty()) {
				int result = ws.wifiisLiked(userId,wifinum);
				liked = (result >0);
				wdto.setLiked(result >0);
			}
		}

		model.addAttribute("list", list);
		model.addAttribute("paging", dto);
		model.addAttribute("loginstate", userId != null);
	    model.addAttribute("id", userId);
		return "wifiout";
	}
	
	@RequestMapping(value = "wifisearch")
	public String search1() {
		
		return "wifisearch";
	}
	@RequestMapping(value = "wifisearch2")
	public String search2(HttpServletRequest request, Model model, WifiPageDTO dto) {
		String wificountry = request.getParameter("wificountry");
		int wifiday = Integer.parseInt(request.getParameter("wifiday"));
		String nowPage = request.getParameter("nowPage");
		String cntPerPage = request.getParameter("cntPerPage");
		HttpSession session = request.getSession();
	    String userId = (String) session.getAttribute("id");
		WifiService ws = sqlsession.getMapper(WifiService.class);
		int total = ws.wifisearchtotal(wificountry, wifiday);
		if(nowPage==null && cntPerPage == null) {
	           nowPage="1";
	           cntPerPage="16";
	    }
	    else if(nowPage==null) {
	    	nowPage="1";
	    }
	    else if(cntPerPage==null) {
	    	cntPerPage="16";
	    }
		
		dto = new WifiPageDTO(Integer.parseInt(nowPage), total, Integer.parseInt(cntPerPage));
		ArrayList<WIfiDTO> list = ws.search(wificountry,wifiday,dto);
		for(WIfiDTO wdto : list) {
			int wifinum = wdto.getWifinum();
			boolean liked = false;
			if(userId != null && !userId.trim().isEmpty()) {
				int result = ws.wifiisLiked(userId,wifinum);
				liked = (result >0);
				wdto.setLiked(result >0);
			}
		}
		model.addAttribute("list", list);
		model.addAttribute("paging", dto);
		return "wifiout";
	}
	
	@RequestMapping(value = "wifilike")
	public String packlike(HttpServletRequest request) {
		WifiService ws = sqlsession.getMapper(WifiService.class);
		String id = request.getParameter("id");
		int wifinum = Integer.parseInt(request.getParameter("wifinum"));
		ws.wlike(id,wifinum);
		return "redirect:/wifiout";
	}
	
	@RequestMapping(value = "deletewifilike")
	public String deletepacklike(HttpServletRequest request) {
		WifiService ws = sqlsession.getMapper(WifiService.class);
		String id = request.getParameter("id");
		int wifinum = Integer.parseInt(request.getParameter("wifinum"));
		ws.wdellike(id,wifinum);
		return "redirect:/wifiout";
	}
	
}
