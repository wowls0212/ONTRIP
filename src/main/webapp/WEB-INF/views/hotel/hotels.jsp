<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>호텔 목록</title>
  <style>
    body {
      font-family: 'Noto Sans KR', sans-serif;
      background-color: #f6f9fc;
      margin: 0;
    }

    h2 {
      text-align: center;
      color: #1f2937;
  font-size: 28px;
  font-weight: 700;
      margin-bottom: 10px;
    }

    .search-wrapper {
      display: flex;
      justify-content: center;
      margin-bottom: 30px;
    }

    .search-form {
      display: flex;
      background: #ffffff;
      border: 1px solid #d0d7e2;
      border-radius: 12px;
      box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
      padding: 10px 15px;
      gap: 10px;
      align-items: center;
    }

    .search-form input[type="text"],
    .search-form input[type="date"] {
      border: none;
      outline: none;
      font-size: 14px;
      padding: 10px 12px;
      border-radius: 8px;
      background-color: #f5f7fa;
      width: 180px;
    }

    .search-form input[type="submit"] {
      background-color: #184fa1;
      color: white;
      border: none;
      padding: 10px 20px;
      font-size: 14px;
      font-weight: 500;
      border-radius: 8px;
      cursor: pointer;
      transition: background-color 0.2s ease;
    }

    .search-form input[type="submit"]:hover {
      background-color: #143f85;
    }

    table {
      width: 100%;
      border-collapse: collapse;
      background-color: #fff;
      border-radius: 10px;
      overflow: hidden;
      box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
      margin-bottom: 30px;
    }

    thead {
      background-color: #f0f4fa;
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
      color: #184fa1;
    }

    td:nth-child(5) {
      font-weight: bold;
      color: #d70000;
    }

    tr:hover {
      background-color: #f9fbff;
    }

    .paging {
      text-align: center;
      margin: 20px 0 50px;
    }

    .paging a {
      margin: 0 4px;
      text-decoration: none;
      padding: 6px 12px;
      font-size: 13px;
      color: #333;
      border: 1px solid #ccc;
      border-radius: 5px;
    }

    .paging a.active {
      background-color: #184fa1;
      color: white;
      border-color: #184fa1;
    }
    .hotelbox {
  background: white;
  border-radius: 12px;
  box-shadow: 0 2px 10px rgba(0,0,0,0.05);
  padding: 25px;
  margin: 30px 20px;
}
  </style>
</head>
<body>
  <h2>호텔 목록</h2>

  <div class="search-wrapper">
    <form method="get" action="hotel" class="search-form">
      <input type="text" name="keyword" value="${param.keyword}" placeholder="도시 또는 호텔명" />
      <input type="date" name="date" value="${param.date}" />
      <input type="submit" value="검색" />
    </form>
  </div>
<div class="hotelbox">
  <table>
    <thead>
      <tr>
        <th>도시</th>
        <th>체크인</th>
        <th>체크아웃</th>
        <th>호텔명</th>
        <th>가격</th>
        <th>예약</th>
      </tr>
    </thead>
    <tbody>
      <c:forEach var="h" items="${hotels}">
        <tr>
          <td>${h.도시}</td>
          <td>${h.체크인}</td>
          <td>${h.체크아웃}</td>
          <td>${h.호텔명}</td>
          <td><fmt:formatNumber value="${h.가격}" type="number" pattern="#,###"/>원</td>
          <td><a href="${h.링크}" target="_blank">이동</a></td>
        </tr>
      </c:forEach>
    </tbody>
  </table>
</div>
  <div class="paging">
    <c:if test="${paging.prev}">
      <a href="?keyword=${param.keyword}&date=${param.date}&nowPage=${paging.startPage - 1}&cntPerPage=${paging.cntPerPage}">◀ 이전</a>
    </c:if>
    <c:forEach begin="${paging.startPage}" end="${paging.endPage}" var="i">
      <a href="?keyword=${param.keyword}&date=${param.date}&nowPage=${i}&cntPerPage=${paging.cntPerPage}"
         class="${i == paging.nowPage ? 'active' : ''}">${i}</a>
    </c:forEach>
    <c:if test="${paging.next}">
      <a href="?keyword=${param.keyword}&date=${param.date}&nowPage=${paging.endPage + 1}&cntPerPage=${paging.cntPerPage}">다음 ▶</a>
    </c:if>
  </div>
</body>
</html>