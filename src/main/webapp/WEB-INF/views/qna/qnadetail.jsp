<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>Q&A</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<style>
    body {
        background: linear-gradient(to bottom, #f9fafb, #fdfdfd);
        font-family: 'Noto Sans KR', sans-serif;
        margin: 0;
        padding: 0;
    }
    .container {
        position: relative;
        max-width: 600px;
        margin: 30px auto;
        background: #ffffffcc;
        padding: 40px;
        border-radius: 20px;
        box-shadow: 0 8px 25px rgba(0,0,0,0.05);
    }
    h2 {
        text-align: center;
        font-size: 24px;
        font-weight: bold;
        color: #333;
        margin-bottom: 25px;
    }
    .form-group {
        position: relative;
        margin-bottom: 30px;
    }
    .form-group label {
        position: absolute;
        top: -10px;
        left: 15px;
        background: #ffffffcc;
        padding: 0 5px;
        font-size: 13px;
        font-weight: bold;
        color: #374151;
    }
    .form-group div,
    .form-group textarea {
        width: 100%;
        padding: 15px;
        border: 1px solid #d1d5db;
        border-radius: 10px;
        font-size: 15px;
        background: #f8faf7;
    }
    .form-group textarea {
        background: white;
    }
    .form-group textarea:focus {
        border-color: #8BC34A;
        box-shadow: 0 0 0 3px rgba(139,195,74,0.2);
        outline: none;
    }
    .btn-group {
        text-align: center;
        margin-top: 30px;
    }
    .btn-group button {
        padding: 10px 30px;
        border: none;
        border-radius: 8px;
        font-size: 15px;
        font-weight: bold;
        cursor: pointer;
        transition: background 0.3s;
        margin: 0 5px;
    }
    .btn-submit {
        background: #8BC34A;
        color: white;
    }
    .btn-submit:hover {
        background: #7CB342;
    }
    .btn-cancel {
        background: #ef4444;
        color: white;
    }
    .btn-cancel:hover {
        background: #dc2626;
    }
    .close-btn {
        position: absolute;
        top: 20px;
        right: 20px;
        font-size: 20px;
        color: #6b7280;
        background: none;
        border: none;
        cursor: pointer;
        transition: color 0.2s;
    }
    .close-btn:hover {
        color: #374151;
    }
</style>
</head>
<body>

<div class="container">
    <button type="button" class="close-btn" onclick="location.href='qnaout'">✕</button>
    <h2>문의글 조회</h2>
    <form action="answersave" method="post">
        <div class="form-group">
            <label>문의번호</label>
            <div>${qdto.qnanum}</div>
        </div>
        <div class="form-group">
            <label>문의제목</label>
            <div>${qdto.qnatitle}</div>
        </div>
        <div class="form-group">
            <label>문의내용</label>
            <div>${qdto.qnadetail}</div>
        </div>
        <div class="form-group">
            <label>회원ID</label>
            <div>${qdto.userid}</div>
        </div>
        <div class="form-group">
            <label>답변</label>
            <div>
                ${ans.answer}
                <c:if test="${ans.answer==null}">
                    <c:if test="${loginstate==true}">
                        <c:choose>
                            <c:when test="${id=='admin'}">
                                <textarea rows="5" name="answer" placeholder="답변을 입력하세요"></textarea>
                                <input type="hidden" name="qnanum" value="${qdto.qnanum}">
                                <input type="hidden" name="id" value="${id}">
                            </c:when>
                            <c:otherwise>
                                답변 입력 전입니다.
                            </c:otherwise>
                        </c:choose>
                    </c:if>
                </c:if>
            </div>
        </div>

        <div class="btn-group">
            <c:if test="${loginstate==true}">
                <c:choose>
                    <c:when test="${id=='admin'}">
                        <c:choose>
                            <c:when test="${ans.answer==null}">
                                <button type="submit" class="btn-submit">답변등록</button>
                            </c:when>
                            <c:otherwise>
                                <button type="button" class="btn-submit"
                                    onclick="location.href='answerupdate?answernum=${ans.answernum}'">답변수정</button>
                            </c:otherwise>
                        </c:choose>
                    </c:when>
                    <c:otherwise>
                        <button type="button" class="btn-submit"
                            onclick="location.href='qnaupdateview?qnanum=${qdto.qnanum}'">문의글 수정</button>
                    </c:otherwise>
                </c:choose>
            </c:if>
            <input type="hidden" name="qnanum" value="${qdto.qnanum}">
            <button type="button" class="btn-cancel"
                onclick="if(confirm('정말 삭제하시겠습니까?')) location.href='qnadelete?qnanum=${qdto.qnanum}'">
                문의삭제
            </button>
        </div>
    </form>
</div>

</body>
</html>
