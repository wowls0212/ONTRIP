package com.mbc.ontrip.qna;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.mbc.ontrip.pack.PackService;

@Controller
public class QnaController {
	
	@Autowired
	SqlSession sqlSession;
	String path = "C:\\mbc12AI\\spring\\ontrip\\src\\main\\webapp\\image";
	
	@RequestMapping(value = "qnainput")
	public String qq1() {
		
		return "qnainput";
	}
	
	@RequestMapping(value = "qnasave")
	public String qq2(HttpServletRequest request) throws IllegalStateException, IOException {
		String qnatitle = request.getParameter("qnatitle");
		String qnadetail = request.getParameter("qnadetail");
		String id = request.getParameter("userid");
		String qnapw = request.getParameter("qnapw");
		String secret = request.getParameter("secret");
		PasswordEncoder pe = new BCryptPasswordEncoder();
		qnapw = pe.encode(qnapw);
		QnaService qs =sqlSession.getMapper(QnaService.class);
		qs.insert(qnatitle, qnadetail, id, qnapw,secret);		
		
		return "redirect:/qnaout";
	}

	
	@RequestMapping(value = "qnaout")
	public String qq3(Model model, HttpServletRequest request, QnaPageDTO dto) {
		String nowPage = request.getParameter("nowPage");
		String cntPerPage = request.getParameter("cntPerPage");
		QnaService qs =sqlSession.getMapper(QnaService.class);
		int total = qs.qnatotal();
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
		dto = new QnaPageDTO(Integer.parseInt(nowPage), total, Integer.parseInt(cntPerPage));
		ArrayList<QnaDTO>list = qs.qnaout(dto);
		model.addAttribute("list",list);
		model.addAttribute("paging", dto);
		return "qnaout";
	}
	
	@RequestMapping(value = "qnaanswer")
	public String qq4(Model model, HttpServletRequest request) {
		int qnanum = Integer.parseInt(request.getParameter("qnanum"));
		String qnapassword = request.getParameter("qnapassword");
		QnaService qs=sqlSession.getMapper(QnaService.class);
		QnaDTO pwdto = qs.qnapw(qnanum);
		String qnapw = pwdto.getQnapw();
		PasswordEncoder pe = new BCryptPasswordEncoder();
		if(pe.matches(qnapassword,qnapw)){
			QnaDTO qdto=qs.qnadetail(qnanum);
			QnaDTO ans=qs.ans(qnanum);
			model.addAttribute("qdto",qdto);
			model.addAttribute("ans", ans);
			return "qnadetail";
		}
		else {
			return "main";
		}
	}
	
	@RequestMapping(value = "answersave")
	public String qq5(HttpServletRequest request) {
		int qnanum = Integer.parseInt(request.getParameter("qnanum"));
		String answer = request.getParameter("answer");
		String id = request.getParameter("id");
		QnaService qs = sqlSession.getMapper(QnaService.class);
		qs.answer(qnanum,answer,id);
		return "redirect:/qnaout";
	}
	
	@RequestMapping(value = "qnasearch")
	public String qq6(HttpServletRequest request, Model model) {
		String qnase = request.getParameter("qnase");
		String qnass = request.getParameter("qnass");
		QnaService qs = sqlSession.getMapper(QnaService.class);
		ArrayList<QnaDTO>list = qs.qnaserch(qnase,qnass);
		model.addAttribute("list",list);
		return "qnaout";
	}
	
	@RequestMapping(value = "qnadelete")
	public String qq8(HttpServletRequest request) {
		int qnanum =Integer.parseInt(request.getParameter("qnanum"));
		QnaService qs = sqlSession.getMapper(QnaService.class);
		qs.qnadelete(qnanum);		
		
		return "redirect:/qnaout";
	}
	
	@RequestMapping(value = "qnaupdateview")
	public String qq7(HttpServletRequest request, Model model) {
		int qnanum = Integer.parseInt(request.getParameter("qnanum"));
		QnaService qs = sqlSession.getMapper(QnaService.class);
		QnaDTO dto = qs.updateview(qnanum);
		model.addAttribute("dto", dto);
		return "qnaupdateview";
	}
	
	@RequestMapping(value = "qnaupdatesave")
	public String qq9(HttpServletRequest request) {
		int qnanum = Integer.parseInt(request.getParameter("qnanum"));
		String qnatitle=request.getParameter("qnatitle");
		String qnadetail = request.getParameter("qnadetail");
		String qnapw = request.getParameter("qnapw");
		PasswordEncoder pe = new BCryptPasswordEncoder();
		qnapw = pe.encode(qnapw);
		QnaService qs = sqlSession.getMapper(QnaService.class);
		qs.upsave(qnatitle, qnadetail, qnapw,qnanum);
		
		return "redirect:/qnaout";
	}
	
	@RequestMapping(value = "answerupdate")
	public String qq10(HttpServletRequest request, Model model) {
		int answernum = Integer.parseInt(request.getParameter("answernum"));
		QnaService qs = sqlSession.getMapper(QnaService.class);
		QnaDTO dto = qs.adminupdateview(answernum);
		model.addAttribute("dto", dto);
		return "answerupdateview";
	}
	
	@RequestMapping(value = "answerupdatesave")
	public String qq11(HttpServletRequest request) {
		int answernum =Integer.parseInt(request.getParameter("answernum"));
		String answer = request.getParameter("answer");
		QnaService qs = sqlSession.getMapper(QnaService.class);
		qs.adminupdatesave(answernum, answer);
		
		return "redirect:/qnaout";
	}
	
	@RequestMapping(value = "myqna")
	public String qq12(HttpServletRequest request,Model model, QnaPageDTO dto) {
		String userid = request.getParameter("id");
		String nowPage = request.getParameter("nowPage");
		String cntPerPage = request.getParameter("cntPerPage");
		QnaService qs =sqlSession.getMapper(QnaService.class);
		int total = qs.idtotal(userid);
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
		dto = new QnaPageDTO(Integer.parseInt(nowPage), total, Integer.parseInt(cntPerPage));
		ArrayList<QnaDTO>list = qs.qnaidout(userid,dto);
		model.addAttribute("list",list);
		model.addAttribute("paging", dto);
		return "myqnaout";
	}
	
	
}
