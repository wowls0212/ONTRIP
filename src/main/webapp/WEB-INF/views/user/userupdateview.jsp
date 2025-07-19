<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>회원정보 수정</title>
<meta name="viewport" content="width=device-width, initial-scale=1">

<style>
    body {
      font-family: 'Noto Sans KR', sans-serif;
      background: linear-gradient(to bottom, #f9fafb, #fdfdfd);
      margin: 0;
    }
    .box-title {
      text-align: center;
      color: #1f2937;
      font-size: 26px;
      font-weight: 700;
      margin-bottom: 15px;
    }
    .box {
      position: relative;
      max-width: 600px;
      background: #ffffffcc;
      border-radius: 12px;
      box-shadow: 0 8px 25px rgba(0,0,0,0.05);
      padding: 20px;
      margin: 30px auto 40px;
    }
    table {
      width: 100%;
      border-collapse: collapse;
      background: transparent;
      border-radius: 10px;
      overflow: hidden;
      margin-bottom: 20px;
    }
    th, td {
      padding: 12px 10px;
      font-size: 14px;
      border-bottom: 1px solid #e0e0e0;
      vertical-align: middle;
    }
    th {
      text-align: left;
      font-weight: 600;
      color: #8BC34A;
      width: 120px;
    }
    tr:hover {
      background-color: #f9fbf7;
    }
    input[type="password"],
    input[type="text"],
    input[type="date"],
    select {
      width: 100%;
      padding: 8px 10px;
      border: 1px solid #d0d7e2;
      border-radius: 8px;
      font-size: 14px;
      outline: none;
      background-color: #f8faf7;
    }
    input:focus, select:focus {
      border-color: #8BC34A;
    }
    button {
      background-color: #8BC34A;
      color: white;
      border: none;
      padding: 8px 20px;
      font-size: 14px;
      font-weight: 500;
      border-radius: 8px;
      cursor: pointer;
      transition: background-color 0.2s ease;
      margin-right: 5px;
    }
    button:hover {
      background-color: #7CB342;
    }
    .btn-cancel {
      background-color: #ef5350;
    }
    .btn-cancel:hover {
      background-color: #d32f2f;
    }
    td[colspan="2"] {
      text-align: center;
      padding-top: 20px;
      border-bottom: none;
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
      transition: transform 0.2s;
    }
    .close-btn:hover,
    .close-btn:focus {
      background: none;
      outline: none;
      transform: scale(1.2);
    }
</style>
</head>

<body>
<div class="box">
  <!-- 박스 내부에 제목 -->
  <div class="box-title">회원정보 수정</div>
  
  <!-- X 버튼 -->
  <button type="button" class="close-btn" onclick="location.href='userout'">&times;</button>

  <form action="userupdate">
    <table>
      <tbody>
        <tr>
          <th>ID</th>
          <td><input type="text" name="newid" value="${dto.id}" required></td>
        </tr>
        <tr>
          <th>PW</th>
          <td><input type="password" name="pw"></td>
        </tr>
        <tr>
          <th>전화번호</th>
          <td>
            <input type="text" name="phone"
                   pattern="\d{3}-\d{3,4}-\d{4}"
                   title="형식: 010-1234-5678"
                   value="${dto.phone}" required>
          </td>
        </tr>
        <tr>
          <th>이메일</th>
          <td><input type="text" name="email" value="${dto.email}" required></td>
        </tr>
        <tr>
          <th>나이</th>
          <td><input type="date" name="birth" value="${dto.birth}" required></td>
        </tr>
        <tr>
          <th>여행스타일</th>
          <td>
            <select name="tripstyle">
              <option value="activity">액티비티</option>
              <option value="food">맛집탐방</option>
              <option value="tourist">관광지 탐방</option>
              <option value="resort">휴양지</option>
            </select>
          </td>
        </tr>
        <tr>
          <td colspan="2">
            <input type="hidden" name="usernumber" value="${dto.usernumber}">
            <button type="submit">수정</button>
          </td>
        </tr>
      </tbody>
    </table>
  </form>
</div>
</body>
</html>
