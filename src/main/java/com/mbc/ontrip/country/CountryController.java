package com.mbc.ontrip.country;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.mbc.ontrip.user.LikeDTO;
import com.mbc.ontrip.user.UserPageDTO;

@Controller
public class CountryController {
	
	@Autowired
	SqlSession SqlSession;
	String path = "C:\\MBC12AI\\spring\\ontrip\\src\\main\\webapp\\image";
	
	
	@RequestMapping(value = "countryinput")
	public String cinput() {
		
		return "countryinput";
	}
	
	@RequestMapping(value = "consave")
	public String csave(MultipartHttpServletRequest request) throws IllegalStateException, IOException {
		String country = request.getParameter("country");
		String tripname = request.getParameter("tripname");
		String lat = request.getParameter("lat");
		String llong = request.getParameter("llong");
		String address = request.getParameter("address");
		String tripstyle = request.getParameter("tripstyle");
		int branch = Integer.parseInt(request.getParameter("branch"));
		String tripdetail = request.getParameter("tripdetail");
		MultipartFile mf = request.getFile("tripimg");
		String tripimg = mf.getOriginalFilename();
		UUID uu = UUID.randomUUID();
		tripimg = uu+"-"+tripimg;
		mf.transferTo(new File(path+"//"+tripimg));
		CountryService cs = SqlSession.getMapper(CountryService.class);
		cs.csave(country,tripname,tripimg,lat,llong,address,tripstyle,branch,tripdetail);
		return "redirect:/main";
	}
	
	@RequestMapping(value = "countryout")
	public String cout(Model model, HttpServletRequest request, CountryPageDTO dto) {
		String nowPage = request.getParameter("nowPage");
		String cntPerPage = request.getParameter("cntPerPage");
		CountryService cs = SqlSession.getMapper(CountryService.class);
		int total = cs.countrytotal();
		if(nowPage==null && cntPerPage == null) {
	           nowPage="1";
	           cntPerPage="10";
	    }
	    else if(nowPage==null) {
	    	nowPage="1";
	    }
	    else if(cntPerPage==null) {
	    	cntPerPage="10";
	    }
		dto = new CountryPageDTO(Integer.parseInt(nowPage), total, Integer.parseInt(cntPerPage));
		model.addAttribute("paging", dto);
		model.addAttribute("list", cs.out(dto));
		return "countryout";
	}
	
	@RequestMapping(value = "countrydetail")
	public String cdetail(HttpServletRequest request, Model model) {
		String id = (String) request.getSession().getAttribute("id");
		int countrynum = Integer.parseInt(request.getParameter("countrynum"));
		CountryService cs = SqlSession.getMapper(CountryService.class);
		CountryDTO dto = cs.cdetail(countrynum);
		boolean liked = false;
	    if (id != null && !id.trim().isEmpty()) {
	        int result = cs.isLiked(id, countrynum);
	        liked = (result > 0);
	    }
		model.addAttribute("dto", dto);
		model.addAttribute("liked", liked);  // JSP·Î Àü´Þ
	    model.addAttribute("id", id);

		return "countrydetail";
	}
	
	@RequestMapping(value = "countryupdate")
	public String cupdateview(HttpServletRequest request, Model model) {
		int countrynum = Integer.parseInt(request.getParameter("countrynum"));
		CountryService cs = SqlSession.getMapper(CountryService.class);
		CountryDTO dto = cs.cupdateview(countrynum);
		model.addAttribute("dto", dto);
		return "countryupdateview";
	}
	
	@RequestMapping(value = "countryupdatesave")
	public String cupsave(MultipartHttpServletRequest request) throws IllegalStateException, IOException {
		int countrynum = Integer.parseInt(request.getParameter("countrynum"));
		String country = request.getParameter("country");
		String tripname = request.getParameter("tripname");
		String lat = request.getParameter("lat");
		String llong = request.getParameter("llong");
		String address = request.getParameter("address");
		String tripstyle = request.getParameter("tripstyle");
		int branch = Integer.parseInt(request.getParameter("branch"));
		String tripdetail = request.getParameter("tripdetail");
		MultipartFile mf = request.getFile("tripimg");
		CountryService cs = SqlSession.getMapper(CountryService.class);
		String tripimg = mf.getOriginalFilename();
		
		if(tripimg == null || tripimg.trim().isEmpty()) {
			tripimg = request.getParameter("lastimg");
		}else {
			UUID uu = UUID.randomUUID();
			tripimg = uu+"-"+tripimg;
			mf.transferTo(new File(path+"//"+tripimg));
			String lastimg = request.getParameter("lastimg");
			File ff = new File(path+"//"+lastimg);
			ff.delete();
		}
		cs.cupdatesave(countrynum,country,tripname,tripimg,lat,llong,address,tripstyle,branch,tripdetail);
		return "redirect:/countrydetail?countrynum="+countrynum;
	}
	
	@RequestMapping(value = "countrydelete")
	public String countrydelete(HttpServletRequest request) {
		int countrynum = Integer.parseInt(request.getParameter("countrynum"));
		CountryService cs = SqlSession.getMapper(CountryService.class);
		cs.condel(countrynum);
		return "redirect:/countryout";
	}
	
	@RequestMapping(value = "countrysearch")
	public String countrysearch(HttpServletRequest request, Model model,CountryPageDTO dto) {
		String nowPage = request.getParameter("nowPage");
		String cntPerPage = request.getParameter("cntPerPage");
		String search = request.getParameter("countrysearch");
		CountryService cs = SqlSession.getMapper(CountryService.class);
		int total = cs.countrysearchtotal(search);
		if(nowPage==null && cntPerPage == null) {
	           nowPage="1";
	           cntPerPage="10";
	    }
	    else if(nowPage==null) {
	    	nowPage="1";
	    }
	    else if(cntPerPage==null) {
	    	cntPerPage="10";
	    }
		dto = new CountryPageDTO(Integer.parseInt(nowPage), total, Integer.parseInt(cntPerPage));
		dto.setSearch(search);
		ArrayList<CountryDTO> list = cs.consearch(dto);
		model.addAttribute("list", list);
		model.addAttribute("paging", dto);
		return "countryout";
	}
	
	@RequestMapping(value = "tripstyle")
	public String conkor(HttpServletRequest request,Model model, CountryPageDTO dto) {
		String nowPage = request.getParameter("nowPage");
		String cntPerPage = request.getParameter("cntPerPage");
		String tripstyle = request.getParameter("tripstyle");
		CountryService cs = SqlSession.getMapper(CountryService.class);
		int total = cs.countrysertotal(tripstyle);
		if(nowPage==null && cntPerPage == null) {
	           nowPage="1";
	           cntPerPage="10";
	    }
	    else if(nowPage==null) {
	    	nowPage="1";
	    }
	    else if(cntPerPage==null) {
	    	cntPerPage="10";
	    }
		dto = new CountryPageDTO(Integer.parseInt(nowPage), total, Integer.parseInt(cntPerPage));
		ArrayList<CountryDTO> list = cs.countryser(tripstyle, dto);
		model.addAttribute("list", list);
		model.addAttribute("paging", dto);
		return "countryout";
	}
	
	@RequestMapping(value = "bran")
	public String bran(HttpServletRequest request,Model model, CountryPageDTO dto) {
		String nowPage = request.getParameter("nowPage");
		String cntPerPage = request.getParameter("cntPerPage");
		int branch = Integer.parseInt(request.getParameter("branch"));
		CountryService cs = SqlSession.getMapper(CountryService.class);
		int total = cs.branchtotal(branch);
		if(nowPage==null && cntPerPage == null) {
	           nowPage="1";
	           cntPerPage="10";
	    }
	    else if(nowPage==null) {
	    	nowPage="1";
	    }
	    else if(cntPerPage==null) {
	    	cntPerPage="10";
	    }
		dto = new CountryPageDTO(Integer.parseInt(nowPage), total, Integer.parseInt(cntPerPage));
		ArrayList<CountryDTO> list = cs.branchser(branch, dto);
		model.addAttribute("list", list);
		model.addAttribute("paging", dto);
		return "countryout";
	}
	
	@RequestMapping(value = "conlike")
	public String conlike(HttpServletRequest request) {
		CountryService cs = SqlSession.getMapper(CountryService.class);
		String id = request.getParameter("id");
		int countrynum = Integer.parseInt(request.getParameter("countrynum"));
		cs.like(id,countrynum);
		System.out.println(id+","+countrynum);
		return "redirect:/countrydetail?countrynum="+countrynum;
	}
	
	@RequestMapping(value = "deletelike")
	public String deletelike(HttpServletRequest request) {
		CountryService cs = SqlSession.getMapper(CountryService.class);
		String id = request.getParameter("id");
		int countrynum = Integer.parseInt(request.getParameter("countrynum"));
		cs.dellike(id,countrynum);		
		return "redirect:/countrydetail?countrynum="+countrynum;
	}
	
	@RequestMapping(value = "likecountry")
	public String likeCountry(Model model, HttpServletRequest request, CountryPageDTO dto) {
		String nowPage = request.getParameter("nowPage");
		String cntPerPage = request.getParameter("cntPerPage");
		CountryService cs = SqlSession.getMapper(CountryService.class);
		int total = cs.countrytotal();
		if(nowPage==null && cntPerPage == null) {
	           nowPage="1";
	           cntPerPage="10";
	    }
	    else if(nowPage==null) {
	    	nowPage="1";
	    }
	    else if(cntPerPage==null) {
	    	cntPerPage="10";
	    }
		dto = new CountryPageDTO(Integer.parseInt(nowPage), total, Integer.parseInt(cntPerPage));
	    ArrayList<CountryDTO> list = cs.likeCountry(dto);
	    model.addAttribute("list", list);
	    model.addAttribute("paging", dto);
	    return "countryout";
	}
	
	@RequestMapping(value = "con")
	public String con(Model model, HttpServletRequest request, CountryPageDTO dto) {
		String nowPage = request.getParameter("nowPage");
		String cntPerPage = request.getParameter("cntPerPage");
		String con = request.getParameter("con");
		CountryService cs = SqlSession.getMapper(CountryService.class);
		int total = cs.contotal(con);
		if(nowPage==null && cntPerPage == null) {
	           nowPage="1";
	           cntPerPage="10";
	    }
	    else if(nowPage==null) {
	    	nowPage="1";
	    }
	    else if(cntPerPage==null) {
	    	cntPerPage="10";
	    }
		dto = new CountryPageDTO(Integer.parseInt(nowPage), total, Integer.parseInt(cntPerPage));
	    ArrayList<CountryDTO> list = cs.con(con, dto);
	    model.addAttribute("list", list);
	    model.addAttribute("paging", dto);
	    return "countryout";
	}
	

}
