package com.mbc.ontrip.pack;

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

import com.mbc.ontrip.pack.PackDTO;
import com.mbc.ontrip.pack.PackService;
import com.mbc.ontrip.wifi.WIfiDTO;
import com.mbc.ontrip.wifi.WifiPageDTO;
import com.mbc.ontrip.wifi.WifiService;

@Controller
public class PackController {
	
	@Autowired
	SqlSession sqlSession;
	String path = "C:\\mbc12AI\\spring\\ontrip\\src\\main\\webapp\\image";
	
	@RequestMapping(value = "packinput")
	public String pp1() {
		
		return "packinput";
	}
	
	@RequestMapping(value = "packagesave")
	public String pp2(MultipartHttpServletRequest request) throws IllegalStateException, IOException {
		MultipartFile mf = request.getFile("packageimg");
		String packageimg = mf.getOriginalFilename();
		UUID uu = UUID.randomUUID();
		packageimg = uu+"-"+packageimg;
		mf.transferTo(new File(path+"//"+packageimg));
		String packagename = request.getParameter("packagename");
		String packagedetail = request.getParameter("packagedetail");
		String packagelink = request.getParameter("packagelink");
		String packagecountry = request.getParameter("packagecountry");
		int packageday = Integer.parseInt(request.getParameter("packageday"));
		PackService ps =sqlSession.getMapper(PackService.class);
		ps.ps(packagename, packageimg, packagedetail, packagelink, packagecountry, packageday);		
		return "redirect:/main";
		
	}
	
		@RequestMapping(value = "packout")
		public String pp3(Model model, HttpServletRequest request, PackPageDTO pdto) {
			String id = (String) request.getSession().getAttribute("id");
			String nowPage = request.getParameter("nowPage");
			String cntPerPage = request.getParameter("cntPerPage");
			PackService ps =sqlSession.getMapper(PackService.class);
			int total = ps.packtotal();
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
			pdto = new PackPageDTO(Integer.parseInt(nowPage), total, Integer.parseInt(cntPerPage));
			ArrayList<PackDTO>list = ps.packout(pdto);
			for (PackDTO dto : list) {
			    int packagenum = dto.getPackagenum();
				boolean liked = false;
				if (id != null && !id.trim().isEmpty()) {
			        int result = ps.packisLiked(id, packagenum);
			        liked = (result > 0);
			        dto.setLiked(result>0);
			    }
			}
			model.addAttribute("list",list);
			model.addAttribute("id", id);
			model.addAttribute("paging", pdto);
			return "packout";
		}
	
	@RequestMapping(value = "packdelete")
	public String pp4(HttpServletRequest request) {
		int packnum =Integer.parseInt(request.getParameter("packagenum"));
		PackService ps = sqlSession.getMapper(PackService.class);
		ps.psd(packnum);		
		
		return "redirect:/main";
	}
	
	@RequestMapping(value = "packupdate")
	public String pp5(HttpServletRequest request, Model model) {
		int packnum =Integer.parseInt(request.getParameter("packagenum"));
		PackService ps = sqlSession.getMapper(PackService.class);
		PackDTO pdto = ps.pss(packnum);
		model.addAttribute("dto", pdto);
		
		return "packupdateview";
	}
	
	@RequestMapping(value = "packageupdatesave")
	public String pp6(MultipartHttpServletRequest request) throws IllegalStateException, IOException {
		int packnum =Integer.parseInt(request.getParameter("packagenum"));
		PackService ps = sqlSession.getMapper(PackService.class);
		MultipartFile mf = request.getFile("packageimg");
		String packageimg = mf.getOriginalFilename();
		if(packageimg==null||packageimg.trim().isEmpty()) {
			packageimg = request.getParameter("lastimg");
		}
		else {
			UUID uu = UUID.randomUUID();
			packageimg = uu+"-"+packageimg;
			mf.transferTo(new File(path+"\\"+packageimg));
			String lastimg = request.getParameter("lastimg");
			File ff = new File(path+"//"+lastimg);
			ff.delete();
		}
		String packagename = request.getParameter("packagename");
		String packagedetail = request.getParameter("packagedetail");
		String packagelink = request.getParameter("packagelink");
		String packagecountry = request.getParameter("packagecountry");
		int packageday = Integer.parseInt(request.getParameter("packageday"));
		ps.ps2(packagename, packageimg, packagedetail, packagelink, packagecountry, packageday, packnum);
		
		return "redirect:/main";
	}
	
	@RequestMapping(value = "packcountry")
	public String packcountry(HttpServletRequest request, Model model, PackPageDTO dto, HttpSession session) {
		String country = request.getParameter("packcon");
		String nowPage = request.getParameter("nowPage");
		String cntPerPage = request.getParameter("cntPerPage");
		String id = (String)session.getAttribute("id");
		PackService ps = sqlSession.getMapper(PackService.class);
		int total = ps.packsertotal(country);
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
		dto = new PackPageDTO(Integer.parseInt(nowPage), total, Integer.parseInt(cntPerPage));
		ArrayList<PackDTO> list = ps.packcountry(country,dto);
		for (PackDTO pdto : list) {
		    int packagenum = pdto.getPackagenum();
			boolean liked = false;
			if (id != null && !id.trim().isEmpty()) {
		        int result = ps.packisLiked(id, packagenum);
		        liked = (result > 0);
		        pdto.setLiked(result>0);
		    }
		}
		model.addAttribute("list", list);
		model.addAttribute("paging", dto);
		return "packout";
	}
	
	@RequestMapping(value = "packsearch")
	public String c1h() {
		
		return "packsearch";
	}
	
	@RequestMapping(value = "packsearch2")
	public String ch2(HttpServletRequest request, Model model, PackPageDTO dto, HttpSession session) {
		String packcountry = request.getParameter("packcountry");
		int packday = Integer.parseInt(request.getParameter("packday"));
		String nowPage = request.getParameter("nowPage");
		String cntPerPage = request.getParameter("cntPerPage");
		String id = (String) session.getAttribute("id");
		PackService ps = sqlSession.getMapper(PackService.class);
		int total = ps.packsearchtotal(packcountry, packday);
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
		dto = new PackPageDTO(Integer.parseInt(nowPage), total, Integer.parseInt(cntPerPage));
		ArrayList<PackDTO>list = ps.serch(packcountry,packday, dto);
		for (PackDTO pdto : list) {
		    int packagenum = pdto.getPackagenum();
			boolean liked = false;
			if (id != null && !id.trim().isEmpty()) {
		        int result = ps.packisLiked(id, packagenum);
		        liked = (result > 0);
		        pdto.setLiked(result>0);
		    }
		}
		model.addAttribute("list",list);
		model.addAttribute("paging", dto);
		return "packout";
	}
	
	@RequestMapping(value = "packlike")
	public String packlike(HttpServletRequest request) {
		PackService ps = sqlSession.getMapper(PackService.class);
		String id = request.getParameter("id");
		int packagenum = Integer.parseInt(request.getParameter("packagenum"));
		ps.palike(id,packagenum);
		return "redirect:/packout";
	}
	
	@RequestMapping(value = "deletepacklike")
	public String deletepacklike(HttpServletRequest request) {
		PackService ps = sqlSession.getMapper(PackService.class);
		String id = request.getParameter("id");
		int packagenum = Integer.parseInt(request.getParameter("packagenum"));
		ps.padellike(id,packagenum);
		return "redirect:/packout";
	}
	
}
