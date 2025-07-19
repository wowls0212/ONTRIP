<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>wifi 상품등록</title>
  <style>
    body {
        background-color: #f9fafb;
        font-family: 'Noto Sans KR', sans-serif;
        margin: 0;
        padding: 0;
    }
    .container {
        position: relative;
        max-width: 600px;
        margin: 50px auto;
        background: white;
        padding: 40px;
        border-radius: 20px;
        box-shadow: 0 4px 20px rgba(0,0,0,0.1);
    }
    h2 {
        text-align: center;
        color: #1f2937;
        font-size: 28px;
        font-weight: 700;
        margin-bottom: 30px;
    }
    .form-group {
        position: relative;
        margin-bottom: 30px;
    }
    .form-group label {
        position: absolute;
        top: -10px;
        left: 15px;
        background: white;
        padding: 0 5px;
        font-size: 13px;
        font-weight: bold;
        color: #374151;
    }
    .form-group input,
    .form-group select,
    .form-group textarea {
        width: 100%;
        padding: 15px;
        border: 1px solid #d1d5db;
        border-radius: 10px;
        font-size: 15px;
        outline: none;
        background-color: #f0f8ff; /* 연한 파란색 */
    }
    .form-group input:focus,
    .form-group select:focus,
    .form-group textarea:focus {
        border-color: #3b82f6;
        box-shadow: 0 0 0 2px rgba(59,130,246,0.2);
    }
    .form-group input[type="file"] {
        padding: 12px;
        background: #f0f8ff; 
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
        color: white;
    }
    .btn-submit {
        background: #3b82f6;
    }
    .btn-submit:hover {
        background: #2563eb;
    }
    .btn-cancel {
        background: #ef4444;
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
<button type="button" class="close-btn" onclick="location.href='main'">✕</button>
  <h2>wifi/e-sim 상품 등록</h2>
  <form action="wifisave" method="post" enctype="multipart/form-data">

    <div class="form-group">
      <label for="wifiname">상품명</label>
      <input type="text" name="wifiname" id="wifiname" placeholder="상품명을 입력해주세요" required />
    </div>

    <div class="form-group">
      <label for="wifiimg">상품이미지</label>
      <input type="file" name="wifiimg" id="wifiimg" />
    </div>

    <div class="form-group">
      <label for="wifidetail">상품설명</label>
      <input type="text" name="wifidetail" id="wifidetail" placeholder="상품 설명을 입력해주세요" required />
    </div>

    <div class="form-group">
      <label for="wifilink">상품링크</label>
      <input type="text" name="wifilink" id="wifilink" placeholder="상품 링크를 입력해주세요" required />
    </div>

    <div class="form-group">
      <label for="wificountry">나라</label>
      <select name="wificountry" id="wificountry" required>
        <option value="" disabled selected hidden>나라를 선택해주세요</option>
        <option value="대한민국">대한민국</option>
        <option value="중국">중국</option>
        <option value="일본">일본</option>
        <option value="베트남">베트남</option>
        <option value="호주">호주</option>
        <option value="미국">미국</option>
        <option value="영국">영국</option>
        <option value="독일">독일</option>
        <option value="프랑스">프랑스</option>
        <option value="뉴질랜드">뉴질랜드</option>
      </select>
    </div>

    <div class="form-group">
      <label for="wifiday">사용 일수</label>
      <input type="text" name="wifiday" id="wifiday" placeholder="예: 3일 / 7일" required />
    </div>

    <div class="btn-group">
      <button type="submit" class="btn-submit">등록</button>
    </div>

  </form>
</div>
</body>
</html>
