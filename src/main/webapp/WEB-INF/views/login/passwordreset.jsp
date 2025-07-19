<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>비밀번호 재설정</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <style>
 
    
    body {
    background-color: #f4f6f9;
      margin: 0;
    }
    h2{  
    color: #1f2937;
  font-size: 28px;
  font-weight: 700;
  }
    .container {
      max-width: 420px;
      margin: 100px auto 0;
      padding: 0 16px;
       margin-bottom: 250px;
    }

    .section-header {
      text-align: center;
      margin-bottom: 32px;
    }
    .section-header .paw {
      display: inline-block;
      width: 44px;
      height: 44px;
      vertical-align: middle;
    }
    .section-header h2 {
      display: inline-block;
      font-size: 2em;
      font-weight: bold;
      margin: 0 8px;
      vertical-align: middle;
    }

    .card {
      background: #fff;
      padding: 28px;
      border-radius: 10px;
      box-shadow: 0 2px 8px rgba(0,0,0,0.1);
    }
    .card table {
      width: 100%;
      border-collapse: collapse;
      margin-bottom: 20px;
    }
    .card th, .card td {
      padding: 14px 8px;
      vertical-align: middle;
    }
    .card th {
      width: 40%;
      color: #666;
      font-weight: normal;
      text-align: left;
    }
    .card td input {
      width: 100%;
      height: 44px;
      padding: 0 12px;
      border: 1px solid #ccc;
      border-radius: 4px;
      font-size: 1em;
      box-sizing: border-box;
    }

    .button-group {
      text-align: center;
    }
    .button-group input {
      margin: 0 8px;
      height: 44px;
      padding: 0 24px;
      border: none;
      border-radius: 22px;
      font-size: 1em;
      cursor: pointer;
      vertical-align: middle;
    }
    .btn-confirm {
      background:#8BC34A;
      color: #ffffff;
    }
    .btn-cancel {
      background: #eee;
      color: #333;
    }

    .error {
      color: #d9534f;
      text-align: center;
      margin-bottom: 16px;
    }

	
}
  </style>
</head>
<body>

  <div class="container">

    <c:if test="${not empty msg}">
      <div class="error">${msg}</div>
    </c:if>

    <div class="card">
      <form action="passwordresetProcess" method="post">
        <input type="hidden" name="id" value="${dto.id}">
        <table>
          <caption class="sr-only">새 비밀번호 입력</caption>
          <tr>
            <th>새 비밀번호</th>
            <td>
              <input type="password" name="newpassword" required placeholder="새 비밀번호 입력">
            </td>
          </tr>
        </table>
        <div class="button-group">
          <input type="submit" value="변경" class="btn-confirm">
          <input type="button" value="취소" class="btn-cancel"
                 onclick="location.href='logoutmain';">	
        </div>
      </form>
    </div>
  </div>
</body>
</html>
