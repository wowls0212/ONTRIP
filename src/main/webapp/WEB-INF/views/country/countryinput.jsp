<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>여행지 등록</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
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
      background-color: #f0f8ff;
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
  <h2>여행지 등록</h2>
  <form action="consave" method="post" enctype="multipart/form-data">

    <div class="form-group">
      <label>국가</label>
      <select name="country">
        <option value="대한민국">한국</option>
        <option value="일본">일본</option>
        <option value="중국">중국</option>
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
      <label>여행지</label>
      <input type="text" name="tripname">
    </div>

    <div class="form-group">
      <label>이미지</label>
      <input type="file" name="tripimg">
    </div>

    <div class="form-group">
      <label>위도</label>
      <input type="text" name="lat">
    </div>

    <div class="form-group">
      <label>경도</label>
      <input type="text" name="llong">
    </div>

    <div class="form-group">
      <label>주소</label>
      <input type="text" name="address">
    </div>

    <div class="form-group">
      <label>여행스타일</label>
      <select name="tripstyle">
        <option value="activity">액티비티</option>
        <option value="food">맛집탐방</option>
        <option value="tourist">관광지 탐방</option>
        <option value="resort">휴양지</option>
      </select>
    </div>

    <div class="form-group">
      <label>추천월</label>
      <select name="branch">
        <option value="1">1월</option>
        <option value="2">2월</option>
        <option value="3">3월</option>
        <option value="4">4월</option>
        <option value="5">5월</option>
        <option value="6">6월</option>
        <option value="7">7월</option>
        <option value="8">8월</option>
        <option value="9">9월</option>
        <option value="10">10월</option>
        <option value="11">11월</option>
        <option value="12">12월</option>
      </select>
    </div>

    <div class="form-group">
      <label>여행지소개</label>
      <textarea rows="10" name="tripdetail"></textarea>
    </div>

    <div class="btn-group">
      <button type="submit" class="btn-submit">등록</button>
    </div>
  </form>
</div>
</body>
</html>
