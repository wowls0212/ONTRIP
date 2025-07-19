package com.mbc.ontrip.qna;

import java.util.ArrayList;
import java.util.Map;

public interface QnaService {
	ArrayList<QnaDTO> qnaout(QnaPageDTO dto);

	void insert(String qnatitle, String qnadetail, String id, String qnapw, String secret);

	QnaDTO qnadetail(int qnanum);

	void answer(int qnanum, String answer, String id);

	QnaDTO ans(int qnanum);

	ArrayList<QnaDTO> qnaserch(String qnase, String qnass);
	
	QnaDTO qnapw(int qnanum);

	QnaDTO updateview(int qnanum);

	void upsave(String qnatitle, String qnadetail, String qnapw, int qnanum);

	void qnadelete(int qnanum);

	QnaDTO adminupdateview(int answernum);

	void adminupdatesave(int answernum, String answer);

	int qnatotal();

	int idtotal(String userid);

	ArrayList<QnaDTO> qnaidout(String userid, QnaPageDTO dto);

	
	

}
