<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>Q&A 답변 수정</title>
<meta name="viewport" content="width=device-width, initial-scale=1">

<style>
    body {
      font-family: 'Noto Sans KR', sans-serif;
      background: linear-gradient(to bottom, #f9fafb, #fdfdfd);
      margin: 0;
    }
    .box {
      position: relative;
      max-width: 600px;
      background: #ffffffcc;
      border-radius: 12px;
      box-shadow: 0 8px 25px rgba(0,0,0,0.05);
      padding: 20px;
      margin: 20px auto 40px;
    }
    table {
      width: 100%;
      border-collapse: collapse;
      background: transparent;
      border-radius: 10px;
      overflow: hidden;
      margin: 0;
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
      width: 80px;
    }
    tr:hover {
      background-color: #f9fbf7;
    }
    input[type="text"] {
      width: 100%;
      padding: 8px 10px;
      border: 1px solid #d0d7e2;
      border-radius: 8px;
      font-size: 14px;
      outline: none;
      background-color: #f8faf7;
    }
    input[type="text"]:focus {
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
      top: 12px;
      right: 16px;
      font-size: 20px;
      color: #6b7280;
      background: none;
      border: none;
      cursor: pointer;
      transition: transform 0.2s;
      z-index: 100;
    }
    .close-btn:hover,
    .close-btn:focus {
      background: none;
      outline: none;
      transform: scale(1.2);
    }
    .table-title {
      text-align: center;
      font-size: 24px;
      font-weight: 700;
      color: #1f2937;
      padding: 10px 0;
    }
</style>
</head>

<body>
<div class="box">
  <button type="button" class="close-btn" onclick="location.href='qnaout'">&times;</button>

  <form action="answerupdatesave" method="post" enctype="multipart/form-data">
    <table>
      <thead>
        <tr>
          <td colspan="2" class="table-title">답변 수정</td>
        </tr>
      </thead>
      <tbody>
        <tr>
          <th>답변</th>
          <td>
            <input type="text" name="answer" value="${dto.answer}" required>
            <input type="hidden" name="answernum" value="${dto.answernum}">
          </td>
        </tr>
        <tr>
          <td colspan="2">
            <button type="submit">수정</button>
          </td>
        </tr>
      </tbody>
    </table>
  </form>
</div>
</body>
</html>
