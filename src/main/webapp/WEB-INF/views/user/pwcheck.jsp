<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>비밀번호 확인</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <style>

    body {
    }
    h2{
    color: #1f2937;
  font-size: 28px;
  font-weight: 700;
    }
    /* 전체 컨테이너 */
    .container {
      max-width: 600px;
      margin: 60px auto;
      padding: 0 20px;
      margin-bottom: 300px;
    }
    /* 섹션 헤더 */
    .section-header {
      text-align: center;
      margin-bottom: 40px;
    }
    .section-header h2 {
      display: inline-block;
      font-size: 2em;
      font-weight: bold;
      margin: 0 12px;
      vertical-align: middle;
    }
    /* 카드 박스 */
    .card {
      background: #fff;
      padding: 24px;
      border-radius: 8px;
      box-shadow: 0 2px 8px rgba(0,0,0,0.1);
    }
    .card table {
      width: 100%;
      border-collapse: collapse;
      margin-bottom: 24px;
    }
    .card th, .card td {
      padding: 12px 8px;
      text-align: left;
    }
    .card th {
      width: 30%;
      color: #666;
      font-weight: normal;
    }
    .card td {
      color: #333;
    }
    /* 버튼 */
    .button-group {
      text-align: center;
      margin-top: 12px;
    }
    .button-group input {
      margin: 0 8px;
      padding: 10px 24px;
      border: none;
      border-radius: 20px;
      font-size: 1em;
      cursor: pointer;
    }
    .btn-confirm {
      background: #8BC34A;
      color: #fff;
    }
    .btn-cancel {
      background: #eee;
      color: #333;
    }
    
    /* 에러 메시지 */
    .alert {
      padding: 16px;
      margin-bottom: 20px;
      border-radius: 8px;
      background-color: #f8d7da;
      color: #721c24;
      border: 1px solid #f5c6cb;
      font-size: 0.95em;
      animation: fadeIn 0.6s ease-in-out;
     }
    @keyframes fadeIn {
      from { opacity: 0; transform: translateY(-10px); }
      to   { opacity: 1; transform: translateY(0); }
     }
     
  </style>
</head>
<body>

  <div class="container">
    <!-- 섹션 헤더 -->
    <div class="section-header">
        <h2>비밀번호 확인</h2>
    </div>

    <!-- 에러 메시지 -->
   <c:if test="${not empty msg}">
   <div class="alert">${msg}</div>
   </c:if>

    <!-- 비밀번호 입력 카드 -->
    <div class="card">
      <form action="pwcheck" method="post">
        <input type="hidden" name="type" value="${param.type}">
        <table>
          <caption class="sr-only">비밀번호 확인 폼</caption>
          <tr>
            <th>비밀번호</th>
            <td>
              <input type="password"
                     name="pw"
                     required
                     placeholder="비밀번호를 입력하세요"
                     style="width:100%; padding:10px; border:1px solid #ccc; border-radius:4px;">
            </td>
          </tr>
        </table>
        <div class="button-group">
          <input type="submit" value="확인" class="btn-confirm">
          <input type="button" value="취소" class="btn-cancel"
                 onclick="location.href='main'">
        </div>
      </form>
    </div>
  </div>

</body>
</html>
