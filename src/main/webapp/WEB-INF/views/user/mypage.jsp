<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지</title>
<style>
body {
  font-family: 'Noto Sans KR', sans-serif;
  background-color: #f7f9fc;
  margin: 0;
  padding: 0;
}

.outer-wrapper {
  padding: 80px 0;
  display: flex;
  justify-content: center;
}

.container {
  max-width: 550px;
  width: 90%;
  margin: 0 auto;
  padding: 50px;
  background: white;
  border-radius: 25px;
  box-shadow: 0 15px 40px rgba(0, 0, 0, 0.12);
  position: relative;
  overflow: hidden;
}

.container::before {
  content: "";
  position: absolute;
  top: -50%;
  left: -50%;
  width: 200%;
  height: 200%;
  transform: rotate(25deg);
}

h2 {
  text-align: center;
  color: #1f2937;
  font-size: 30px;
  font-weight: 800;
  position: relative;
  z-index: 1;
  margin-bottom: 30px;
}
h2::after {
  content: "";
  display: block;
  width: 60px;
  height: 3px;
  background: #8BC34A;
  margin: 10px auto 0;
  border-radius: 3px;
}


.profile-box {
  background: rgba(255,255,255,0.85);
  border-radius: 20px;
  padding: 30px;
  box-shadow: inset 0 0 10px rgba(0,0,0,0.05), 0 5px 20px rgba(0,0,0,0.05);
  margin-bottom: 40px;
}

.table {
  width: 100%;
  border-collapse: separate;
  border-spacing: 0 12px;
  position: relative;
  z-index: 1;
}

.table th {
  text-align: left;
  font-size: 16px;
  color: #666;
  width: 30%;
  padding-right: 10px;
}

.table td {
  font-weight: bold;
  color: #333;
}

.table tr {
  background: #f9fdf8;
  border-radius: 12px;
}
.table tr td, .table tr th {
  padding: 14px 18px;
}
.table tr:hover {
  background: #eefae5;
}


.btn {
  font-size: 17px;
  font-weight: bold;
  padding: 14px 32px;
  border-radius: 30px;
  margin: 16px 10px 0;
  cursor: pointer;
  border: none;
  transition: all 0.35s ease;
  display: inline-block;
  text-decoration: none;
  box-shadow: 0 4px 12px rgba(0,0,0,0.15);
  position: relative;
  z-index: 1;
}

.btn-primary {
  background-color: #8BC34A;
  color: #fff;
}

.btn-primary:hover {
  background-color: #7cb342;
  transform: scale(1.12) rotate(-1deg);
  box-shadow: 0 8px 20px rgba(139,195,74,0.4);
}

.btn-danger {
  background-color: #F44336;
  color: #fff;
}

.btn-danger:hover {
  background-color: #e53935;
  transform: scale(1.12) rotate(1deg);
  box-shadow: 0 8px 20px rgba(244,67,54,0.4);
}
</style>
</head>

<body>
<div class="outer-wrapper">
  <div class="container">
    <h2>마이페이지</h2>

    <div class="profile-box">
      <table class="table">
        <tr>
          <th>아이디</th>
          <td>${dto.id}</td>
        </tr> 
        <tr>
          <th>연락처</th>
          <td>${dto.phone}</td>
        </tr>
        <tr>
          <th>생년월일</th>
          <td>${dto.birth}</td>
        </tr>
        <tr>
          <th>여행스타일</th>
          <td>
            <c:if test="${dto.tripstyle == 'activity'}">액티비티</c:if>
            <c:if test="${dto.tripstyle == 'food'}">맛집탐방</c:if>
            <c:if test="${dto.tripstyle == 'tourist'}">관광지 탐방</c:if>
            <c:if test="${dto.tripstyle == 'resort'}">휴양지</c:if>
          </td>
        </tr>
      </table>
    </div>

    <div class="actions" style="text-align:center;">
      <a href="updatepass?type=update" class="btn btn-primary">회원정보 수정</a>
      <a href="updatepass?type=delete" class="btn btn-danger"
         onclick="return confirm('정말 탈퇴하시겠습니까?');">회원탈퇴</a>
    </div>
  </div>
</div>
</body>
</html>
