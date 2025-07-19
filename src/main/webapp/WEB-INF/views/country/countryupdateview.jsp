<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <title>여행지 수정</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">

  <style>
  body {
    font-family: 'Noto Sans KR', sans-serif;
    background: #f4f6f9;
  }
  h2.title {
    text-align: center;
    color: #1f2937;
  font-size: 28px;
  font-weight: 700;
    margin-bottom: 30px;
  }
  .main-card {
    position: relative;
    max-width: 700px;
    margin: 0 auto 40px auto;
    background: #ffffff;
    border-radius: 20px;
    box-shadow: 0 10px 30px rgba(0,0,0,0.08);
    padding: 25px;
  }
  .close-btn {
        position: absolute;
        top: 10px;
        right: 20px;
        font-size: 20px;
        color: #6b7280;
        background: none;
        border: none;
        cursor: pointer;
        transition: color 0.2s;
        margin-top: 20px;
        margin-right: 5px;
    }
    .close-btn:hover {
        color: #374151;
    }
  .info-box {
    background: #f0f4fa;
    padding: 20px;
    border-radius: 15px;
    display: flex;
    flex-direction: column;
    gap: 14px;
  }
  .info-box label {
    font-size: 16px;
    color: #333;
    font-weight: 600;
    margin-bottom: 5px;
    display: block;
  }
  .info-box input[type="text"],
  .info-box select,
  .info-box textarea {
    width: 100%;
    padding: 8px 12px;
    font-size: 14px;
    border: 1px solid #ccc;
    border-radius: 6px;
    box-sizing: border-box;
  }
  .info-box textarea {
    resize: vertical;
  }
  .info-box img {
    margin-top: 8px;
    border-radius: 6px;
    max-width: 100%;
    height: auto;
  }
  .admin-buttons {
    display: flex;
    justify-content: center;
    gap: 10px;
    margin-top: 20px;
  }
  .admin-buttons button {
    padding: 8px 18px;
    font-size: 13px;
    border: none;
    border-radius: 6px;
    cursor: pointer;
    transition: all 0.2s;
  }
  .admin-buttons .save {
    background: #3b82f6;
    color: white;
  }
  .admin-buttons .save:hover {
    background: #2563eb;
  }
  .admin-buttons .cancel {
    background: #ef4444;
    color: white;
  }
  .admin-buttons .cancel:hover {
    background: #dc2626;
  }
</style>

</head>

<body>
<h2 class="title">여행지 수정</h2>

<div class="main-card">
  <!-- X 버튼 -->
  <button type="button" class="close-btn" onclick="location.href='main'">&times;</button>

  <form action="countryupdatesave" method="post" enctype="multipart/form-data" class="info-box">

    <input type="hidden" name="lastcountry" value="${dto.country }">
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

    <label>여행지</label>
    <input type="text" name="tripname" value="${dto.tripname }" required="required">

    <label>이미지</label>
    <input type="file" name="tripimg">
    <input type="hidden" name="lastimg" value="${dto.tripimg }">
    <img src="./image/${dto.tripimg }" alt="기존 이미지">

    <label>위도</label>
    <input type="text" name="lat" value="${dto.lat }" required="required">

    <label>경도</label>
    <input type="text" name="llong" value="${dto.llong }" required="required">

    <label>주소</label>
    <input type="text" name="address" value="${dto.address }" required="required">

    <input type="hidden" name="laststyle" value="${dto.tripstyle }">
    <label>여행스타일</label>
    <select name="tripstyle">
      <option value="activity">액티비티</option>
      <option value="food">맛집탐방</option>
      <option value="tourist">관광지 탐방</option>
      <option value="resort">휴양지</option>
    </select>

    <input type="hidden" name="lastbranch" value="${dto.branch }">
    <label>추천분기</label> 
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

    <label>여행지 소개</label>
    <textarea rows="10" name="tripdetail">${dto.tripdetail}</textarea>

    <input type="hidden" name="countrynum" value="${dto.countrynum }">

    <div class="admin-buttons">
      <button type="submit" class="save">저장</button>
        </div>

  </form>
</div>
</body>
</html>
