package com.mbc.ontrip.qna;

public class QnaDTO {
	int qnanum;
	String qnatitle, qnadetail, userid, qnapw, answer, secret;
	int answernum;
	
	
	

	public String getSecret() {
		return secret;
	}

	public void setSecret(String secret) {
		this.secret = secret;
	}

	public QnaDTO() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	public int getAnswernum() {
		return answernum;
	}

	public void setAnswernum(int answernum) {
		this.answernum = answernum;
	}

	public int getQnanum() {
		return qnanum;
	}

	public void setQnanum(int qnanum) {
		this.qnanum = qnanum;
	}

	public String getQnatitle() {
		return qnatitle;
	}

	public void setQnatitle(String qnatitle) {
		this.qnatitle = qnatitle;
	}

	public String getQnadetail() {
		return qnadetail;
	}

	public void setQnadetail(String qnadetail) {
		this.qnadetail = qnadetail;
	}

	public String getUserid() {
		return userid;
	}

	public void setUserid(String userid) {
		this.userid = userid;
	}

	public String getQnapw() {
		return qnapw;
	}

	public void setQnapw(String qnapw) {
		this.qnapw = qnapw;
	}

	public String getAnswer() {
		return answer;
	}

	public void setAnswer(String answer) {
		this.answer = answer;
	}
	
	
}
