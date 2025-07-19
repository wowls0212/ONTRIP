<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>문의글 등록</title>
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
        color: #1f2937;
  font-size: 28px;
  font-weight: 700;
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
    .form-group input,
    .form-group textarea {
        width: 100%;
        padding: 15px;
        border: 1px solid #d1d5db;
        border-radius: 10px;
        font-size: 15px;
        outline: none;
        background: #f8faf7;
    }
    .form-group input:focus,
    .form-group textarea:focus {
        border-color: #8BC34A;
        box-shadow: 0 0 0 3px rgba(139,195,74,0.2);
    }
    .radio-group {
        display: flex;
        align-items: center;
        gap: 50px;
        margin-top: 35px;
        margin-left: 5px;
    }
    .radio-group label {
        font-size: 15px;
        color: #374151;
        display: flex;
        align-items: center;
        gap: 5px;
    }
    .radio-group input[type="radio"] {
        transform: scale(1.2);
        accent-color: #8BC34A;
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
    <h2>문의글 등록</h2>
    <form action="qnasave">
        <div class="form-group">
            <label>문의 제목</label>
            <input type="text" name="qnatitle" placeholder="문의 제목을 입력해주세요" required>
        </div>

        <div class="form-group">
            <label>문의 내용</label>
            <textarea rows="5" name="qnadetail" placeholder="문의 내용을 입력해주세요" required></textarea>
        </div>

        <div class="form-group">
            <label>비밀번호</label>
            <input type="password" name="qnapw" placeholder="비밀번호를 입력해주세요" required>
        </div>

        <div class="radio-group">
            <label><input type="radio" name="secret" value="all" checked> 전체공개</label>
            <label><input type="radio" name="secret" value="secret"> 비공개</label>
        </div>

        <div class="btn-group">
            <input type="hidden" name="userid" value="${id}">
            <button type="submit" class="btn-submit">등록</button>
        </div>
    </form>
</div>

</body>
</html>
