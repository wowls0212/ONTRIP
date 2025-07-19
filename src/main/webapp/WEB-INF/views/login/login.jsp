<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
      margin: 120px auto 0;
      padding: 0 16px;
       margin-bottom: 150px;
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
      margin: 20px;
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
      width: 30%;
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
    .btn-login {
      background: #8BC34A;
      color: #ffffff;
    }
    .btn-cancel {
      background: #eee;
      color: #333;
    }
    .main-banner {
	position: relative;
	height: 400px;
	display:inline;
	align-items: center;
	overflow: inherit;
	margin-bottom: 150px;
}
</style>
</head>
<body>
  <div class="container">
    <div class="section-header">
		 <h2>로그인</h2>
    </div>

    <div class="card">
      <form action="logincheck" method="post">
        <table>
          <caption class="sr-only">로그인 폼</caption>
          <tr>
            <th>아이디</th>
            <td><input type="text" name="id" placeholder="아이디 입력"></td>
          </tr>
          <tr>
            <th>패스워드</th>
            <td><input type="password" name="pw" placeholder="패스워드 입력"></td>
          </tr>
        </table>
        <div class="button-group">
          <input type="submit" value="로그인" class="btn-login">
          <input type="button" value="비밀번호 찾기" class="btn-cancel"
                 onclick="location.href='passwordfind';">   
        </div>
      </form>
    </div>
  </div>
</body>
</html>