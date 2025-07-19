<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>문의글 조회</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<style>
    body {
      font-family: 'Noto Sans KR', sans-serif;
      background: linear-gradient(to bottom, #f9fafb, #fdfdfd); /* ✅ 더 부드러운 배경 */
      margin: 0;
    }
    h2 {
      text-align: center;
      color: #1f2937;
  font-size: 28px;
  font-weight: 700;
      margin: 20px 0 5px;
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
    .box {
      max-width: 1000px;
      background: #ffffffcc; /* ✅ 약간 투명 흰색으로 부드럽게 */
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
      margin-bottom: 20px;
    }
    thead {
      background-color: #f4f8f3; /* ✅ 연초록계열 테이블 헤더 */
    }
    th, td {
      padding: 12px 10px;
      text-align: center;
      font-size: 14px;
      border-bottom: 1px solid #e0e0e0;
      white-space: nowrap;
    }
    th {
      font-weight: 600;
      color: #8BC34A;
    }
    tr:hover {
      background-color: #f9fbf7;
    }
    input[type="password"],
    input[type="text"],
    select {
      padding: 8px 10px;
      border: 1px solid #d0d7e2;
      border-radius: 8px;
      font-size: 14px;
      outline: none;
      background-color: #f8faf7;
    }
    input[type="password"]:focus,
    input[type="text"]:focus,
    select:focus {
      border-color: #8BC34A;
    }
    button,
    input[type="submit"] {
      background-color: #8BC34A;
      color: white;
      border: none;
      padding: 8px 16px;
      font-size: 14px;
      font-weight: 500;
      border-radius: 8px;
      cursor: pointer;
      transition: background-color 0.2s ease;
    }
    button:hover,
    input[type="submit"]:hover {
      background-color: #7CB342;
    }
    td form {
      display: inline-block;
    }
    td form input[type="password"] {
      width: 120px;
    }
    .search-area {
      border: 1px solid #e0e0e0;
      border-radius: 12px;
      padding: 15px;
      background: #f7fbf5;
      display: flex;
      justify-content: center;
      gap: 10px;
      margin-top: 20px;
    }
    .pagination {
      text-align: center;
      margin-top: 20px;
    }
    .pagination a, .pagination span.current {
      margin: 0 4px;
      padding: 6px 12px;
      font-size: 14px;
      border-radius: 6px;
      text-decoration: none;
      border: 1px solid #ccc;
      color: #333;
    }
    .pagination span.current {
      background: #8BC34A;
      color: white;
      border-color: #8BC34A;
    }
</style>
</head>

<body>
<h2>내 문의글</h2>
<div class="box">
  <table>
    <thead>
      <tr>
        <th>문의번호</th>
        <th>문의제목</th>
        <th>회원ID</th>
        <th>비밀번호</th>
      </tr>
    </thead>
    <tbody>
      <c:forEach items="${list}" var="qna">
        <tr>
          <td>${qna.qnanum}</td>
          <c:if test="${qna.secret == 'secret'}">
            <td>비밀글입니다.</td>
          </c:if>
          <c:if test="${qna.secret != 'secret'}">
            <td>${qna.qnatitle}</td>
          </c:if>
          <td>${qna.userid}</td>
          <td>
            <form action="qnaanswer">
              <input type="password" name="qnapassword" placeholder="비밀번호">
              <input type="hidden" name="qnanum" value="${qna.qnanum}">
              <button type="submit">확인</button>
            </form>
          </td>
        </tr>
      </c:forEach>
    </tbody>
  </table>

  <div class="search-area">
    <form action="qnasearch" method="get" style="display: flex; align-items: center; gap: 10px;">
      <select name="qnase">
        <option value="userid">아이디</option>
        <option value="qnadetail">내용</option>
        <option value="qnatitle">제목</option>
      </select>
      <input type="text" name="qnass" placeholder="검색어 입력">
      <input type="submit" value="검색">
    </form>
  </div>
</div>
</body>
</html>
