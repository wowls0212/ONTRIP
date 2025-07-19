<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>회원정보 출력</title>
<meta name="viewport" content="width=device-width, initial-scale=1">

<style>
    body {
      font-family: 'Noto Sans KR', sans-serif;
      background: linear-gradient(to bottom, #f9fafb, #fdfdfd);
      margin: 0;
    }
    h2 {
      text-align: center;
      color: #1f2937;
  font-size: 28px;
  font-weight: 700;
      margin: 20px 0 5px;
    }
    .box {
      max-width: 1000px;
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
      margin-bottom: 20px;
    }
    thead {
      background-color: #f4f8f3;
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
    .btn-delete {
      background-color: #ef5350;
    }
    .btn-delete:hover {
      background-color: #d32f2f;
    }
    td form {
      display: inline-block;
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
<h2>회원 관리</h2>
<div class="box">
  <table>
    <thead>
      <tr>
        <th>회원번호</th>
        <th>ID</th>
        <th>전화번호</th>
        <th>이메일</th>
        <th>생년월일</th>
        <th>나이</th>
        <th>여행스타일</th>
        <th>수정/삭제</th>
      </tr>
    </thead>
    <tbody>
    <c:forEach items="${list}" var="user">
      <tr>
        <td>${user.usernumber}</td>
        <td>${user.id}</td>
        <td>${user.phone}</td>
        <td>${user.email}</td>
        <td>${user.birth}</td>
        <td>${user.age}</td>
        <c:if test="${user.tripstyle == 'activity'}">
          <td>액티비티</td>
        </c:if>
        <c:if test="${user.tripstyle == 'food'}">
          <td>맛집탐방</td>
        </c:if>
        <c:if test="${user.tripstyle == 'tourist'}">
          <td>관광지 탐방</td>
        </c:if>
        <c:if test="${user.tripstyle == 'resort'}">
          <td>휴양지</td>
        </c:if>
        <td>
          <button type="button" onclick="location.href='update?id=${user.id}'">수정</button>
          <form action="userdelete" method="post" style="display:inline;">
            <input type="hidden" name="id" value="${user.id}"/>
            <button type="submit" class="btn-delete" onclick="return confirm('정말 삭제하시겠습니까?');">
              삭제
            </button>
          </form>
        </td>
      </tr>
    </c:forEach>
    </tbody>
  </table>

  <div class="pagination">
    <c:if test="${paging.startPage != 1}">
      <a href="userout?nowPage=${paging.startPage-1}&cntPerPage=${paging.cntPerPage}">이전</a>
    </c:if>
    <c:forEach begin="${paging.startPage}" end="${paging.endPage}" var="p">
      <c:choose>
        <c:when test="${p == paging.nowPage}">
          <span class="current">${p}</span>
        </c:when>
        <c:otherwise>
          <a href="userout?nowPage=${p}&cntPerPage=${paging.cntPerPage}">${p}</a>
        </c:otherwise>
      </c:choose>
    </c:forEach>
    <c:if test="${paging.endPage != paging.lastPage}">
      <a href="userout?nowPage=${paging.endPage+1}&cntPerPage=${paging.cntPerPage}">다음</a>
    </c:if>
  </div>

  <div class="search-area">
    <form action="usersearch" method="get" style="display:flex; gap:10px; align-items:center;">
      <input type="text" name="searchid" placeholder="ID 입력">
      <button type="submit">검색</button>
    </form>
  </div>
</div>
</body>
</html>
