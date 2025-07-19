package com.mbc.ontrip.user;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;





@Controller
public class UserController {
	
	@Autowired
	SqlSession sqlsession;
	
	@RequestMapping(value = "userinput")
	public String userinput() {
		return "userinput";
	}
	
	@RequestMapping(value = "usersave")
	public String usersave(HttpServletRequest request, HttpSession session, Model model) {
		String id = request.getParameter("id");
		String pw = request.getParameter("pw");
		String phone = request.getParameter("phone");
		String email = request.getParameter("email");
		String birth = request.getParameter("birth");
		String tripstyle = request.getParameter("tripstyle");
		String admin = request.getParameter("role");
		//pw 암호화
		PasswordEncoder pe = new BCryptPasswordEncoder();
		String encodedPw = pe.encode(pw);
		UserService us = sqlsession.getMapper(UserService.class);
		if (us.idcnt(id) > 0) {
			model.addAttribute("msg", "이미 사용 중인 아이디입니다.");
			return "userinput";
		}
		if("admin".equals(admin)) {
			String inputadminpw = request.getParameter("adminPw");
			String saveadminpw = us.getAdminpw();
			if(saveadminpw==null||!pe.matches(inputadminpw, saveadminpw)) {
				session.setAttribute("msg","관리자 비밀번호가 일치하지 않습니다.");
				return "userinput";
			}
		}
		
		us.usersave(id,encodedPw,phone,email,birth,tripstyle,admin);
		session.setAttribute("msg","회원가입이 완료되었습니다.");
		return "redirect:/";
	}
	
	@RequestMapping(value = "userout")
	public String userout(Model model, UserPageDTO dto, HttpServletRequest request) {
		String nowPage = request.getParameter("nowPage");
		String cntPerPage = request.getParameter("cntPerPage");
		UserService us = sqlsession.getMapper(UserService.class);
		
		int total = us.usertotal();
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
		dto = new UserPageDTO(Integer.parseInt(nowPage), total, Integer.parseInt(cntPerPage));
		model.addAttribute("list", us.out(dto));
		model.addAttribute("paging", dto);
		return "userout";
	}
	@RequestMapping(value = "updatepass")
	public String updatepass(HttpServletRequest request, Model model) {
		String type = request.getParameter("type");
		model.addAttribute("type", type);
		return "pwcheck";
	}
	@RequestMapping(value = "pwcheck")
	public String pwcheck(HttpServletRequest request, HttpSession session, Model model) {
		String inputPw = request.getParameter("pw");
		String type = request.getParameter("type");
		String id = (String) session.getAttribute("id");
		
		if(id==null) {
			return "redirect:/login";
		}
		
		if (inputPw == null || type == null) {
		    model.addAttribute("msg", "잘못된 요청입니다.");
		    return "pwcheck";
		}
		
		UserService us = sqlsession.getMapper(UserService.class);
		UserDTO dto = us.idgetuser(id);
		PasswordEncoder pe = new BCryptPasswordEncoder();
		if(dto!=null && pe.matches(inputPw, dto.getPw())) {
			if("update".equals(type)) {
				return "redirect:/update?id="+id;
			}
			else if ("delete".equals(type)) {
				return "redirect:/userdelete?id="+id;
			}
		}
		model.addAttribute("msg", "비밀번호가 일치하지 않습니다.");
		model.addAttribute("type", type);
		return "pwcheck";
		
	}

		
	
	@RequestMapping(value = "update")
	public String userupdate(HttpServletRequest request, Model model) {
		String id = request.getParameter("id");
		
		UserService us = sqlsession.getMapper(UserService.class);
		UserDTO dto = us.updateview(id);
		model.addAttribute("dto", dto);
		return "userupdateview";
	}
	@RequestMapping(value = "userupdate")
	public String update(HttpServletRequest request,HttpSession session) {

	    int usernum = Integer.parseInt(request.getParameter("usernumber"));
	    String id = request.getParameter("newid");
	    String loginid = (String)session.getAttribute("id");
	    UserService us = sqlsession.getMapper(UserService.class);
	    UserDTO dto = us.getuser(usernum);

	    String newpw = request.getParameter("pw");
	    String pw = dto.getPw(); // 기존 비밀번호 유지

	    // 입력된 비밀번호가 null이 아니고, 공백이 아닌 경우에만 암호화 후 변경
	    if (newpw != null && !newpw.trim().isEmpty()) {
	        PasswordEncoder pe = new BCryptPasswordEncoder();
	        pw = pe.encode(newpw);
	    }

	    String phone = request.getParameter("phone");
	    String email = request.getParameter("email");
	    String birth = request.getParameter("birth");
	    String tripstyle = request.getParameter("tripstyle");

	    us.update(usernum, id, pw, phone, email, birth, tripstyle);

	    if ("admin".equals(loginid)) {
	        return "redirect:/userout";
	    } else {
	        return "redirect:/main";
	    }
	}
	@RequestMapping(value = "userdelete")
	public String adminDelete(HttpServletRequest request, HttpSession session) {
	    String id = request.getParameter("id");
	    String loginid = (String)session.getAttribute("id");
	    UserService us = sqlsession.getMapper(UserService.class);
	    us.delete2(id); // 삭제 수행
	    if("admin".equals(loginid)) {
	    	session.setAttribute("msg", "회원 삭제가 완료되었습니다.");
	    	return "redirect:/userout";
	    }
	    session.setAttribute("msg", "회원 삭제가 완료되었습니다.");
	    return "redirect:/logoutmain";
	}
	@ResponseBody
	@RequestMapping(value = "/idcheck2")
	public String idCheck(String id) {
		UserService us = sqlsession.getMapper(UserService.class);
		int count = us.idcnt(id);
		String bigo = "";
		if (count == 1) {
			bigo = "no";
		} else {
			bigo = "ok";
		}
		return bigo;
	}
	
	
	@RequestMapping(value = "login")
	public String login() {
		
		return "login";
	}
	
	@RequestMapping(value = "logincheck")
	public String logincheck(HttpServletRequest request, HttpServletResponse response) throws IOException {
		String id = request.getParameter("id");
		String pw = request.getParameter("pw");
		
		UserService us = sqlsession.getMapper(UserService.class);
		String encodedPw = us.pwsearch(id);
		PasswordEncoder pe = new BCryptPasswordEncoder();
		
		if (encodedPw != null && pe.matches(pw, encodedPw)) {
			HttpSession session = request.getSession();
			session.setAttribute("loginstate", true);
			session.setAttribute("id", id);

			return "redirect:/main";
		} else {
			response.setContentType("text/html;charset=utf-8");
			try (java.io.PrintWriter out = response.getWriter()) {
				out.print("<script>alert('아이디 또는 패스워드가 다릅니다.\\n다시 확인 후 로그인 해주세요.'); location.href='login';</script>");
			}
			return "redirect:/login";
		}
	}
	@RequestMapping(value = "logout")
	public String logout(HttpServletRequest request) {
		HttpSession session = request.getSession();
		session.invalidate();
		return "redirect:/";
	}
	
	@RequestMapping(value = "mypage")
	public String mypage(HttpServletRequest request, Model model) {
		String id = request.getParameter("id");
		UserService us = sqlsession.getMapper(UserService.class);
		UserDTO dto = us.mypage(id);
		model.addAttribute("dto", dto);
		
		//좋아요누른 게시물
		ArrayList<LikeDTO> list = us.conlike(id);
		model.addAttribute("list", list);
		
		ArrayList<LikeDTO> list2 = us.wifilike(id);
		model.addAttribute("list2", list2);
		
		ArrayList<LikeDTO> list3 = us.packlike(id);
		model.addAttribute("list3", list3);
		
		return "mypage";
	}
	
	@RequestMapping(value = "usersearch")
	public String usersearch(HttpServletRequest request, Model model, UserPageDTO dto) {
		String id = request.getParameter("searchid");
		String nowPage = request.getParameter("nowPage");
		String cntPerPage = request.getParameter("cntPerPage");
		UserService us = sqlsession.getMapper(UserService.class);
		int total = us.usersearchtotal(id);
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
		dto = new UserPageDTO(Integer.parseInt(nowPage), total, Integer.parseInt(cntPerPage));
		ArrayList<UserDTO> list = us.usersearch(id,dto);
		model.addAttribute("list", list);
		model.addAttribute("paging", dto);
		return "userout";
	}
	@RequestMapping(value = "passwordfind")
	public String passwordfind() {
		return "passwordfind";
	}
	
	@RequestMapping(value = "passwordfindProcess")
	public String passwordfindProcess(HttpServletRequest request,Model model) {
		UserService us = sqlsession.getMapper(UserService.class);
		String id = request.getParameter("id");
		String phone = request.getParameter("phone");
		UserDTO dto = us.passmatch(id);
		if(dto!=null && phone.equals(dto.phone)) {
			model.addAttribute("dto", dto);
			return "passwordreset";
		}
		else {
			model.addAttribute("msg", "일치하지 않는 정보입니다.");
			return "passwordfind";
		}
		
	}
	
	@RequestMapping(value = "passwordresetProcess")
	public String passwordresetProcess(HttpServletRequest request) {
		UserService us = sqlsession.getMapper(UserService.class);
		String id = request.getParameter("id");
		String password = request.getParameter("newpassword");
		PasswordEncoder pe = new BCryptPasswordEncoder();
		password = pe.encode(password);
		us.newpass(id,password);
		return "redirect:/login";
	}
	@RequestMapping(value = "likepage")
	public String likepage(HttpServletRequest request, Model model) {
		String id = request.getParameter("id");
		UserService us = sqlsession.getMapper(UserService.class);
		//좋아요누른 게시물
		ArrayList<LikeDTO> list = us.conlike(id);
		model.addAttribute("list", list);
		
		ArrayList<LikeDTO> list2 = us.wifilike(id);
		model.addAttribute("list2", list2);
		
		ArrayList<LikeDTO> list3 = us.packlike(id);
		model.addAttribute("list3", list3);
		
		return "likepage";
	}
	
}

