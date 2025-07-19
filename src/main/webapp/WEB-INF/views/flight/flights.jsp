	<%@ page language="java" contentType="text/html; charset=UTF-8"
	    pageEncoding="UTF-8"%>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
	<!DOCTYPE html>
	<html>
	<head>
	  <title>항공편 리스트</title>
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

    td:nth-child(2) {
      font-weight: bold;
      color: #184fa1;
    }

    td:nth-child(3) {
      color: #d70000;
      font-weight: bold;
    }

    tr:hover {
      background-color: #f9fbff;
    }

    .footer-section {
      margin-top: 40px;
      text-align: center;
    }

    .paging {
      display: inline-block;
      margin-top: 10px;
      margin-bottom: 40px;
    }

    .paging a {
      margin: 0 3px;
      text-decoration: none;
      padding: 6px 10px;
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
    .flightbox {
  background: white;
  border-radius: 12px;
  box-shadow: 0 2px 10px rgba(0,0,0,0.05);
  padding: 25px;
  margin: 30px 20px;
}
  </style>
	</head>
	<body>
	  <h2>항공권 목록</h2>
	  
<div class="search-wrapper">
    <form method="get" action="flight" class="search-form">
      <input type="text" name="from" value="${param.from}" placeholder="출발공항 or 항공사" />
	  <input type="text" name="to" value="${param.to}" placeholder="도착공항" />	
      <input type="date" name="date" value="${param.date}" />
      <input type="submit" value="검색" />
    </form>
  </div>
  <div class="flightbox">
	  <table>
	    <thead>
	      <tr>
	        <th>출발일</th><th>항공사</th><th>가격</th><th>출발공항</th><th>도착공항</th>
	        <th>출발시간</th><th>도착시간</th><th>총비행시간</th><th>경유정보</th><th>경유지</th>
	      </tr>
	    </thead>
	    <tbody>
	      <c:forEach var="f" items="${flights}">
	        <tr>
	          <td>${f.출발일}</td>
	          <td>${f.항공사}</td>
	          <td><fmt:formatNumber value="${f.가격}" type="number" pattern="#,###"/>원</td>
	          <td>${f.출발공항}</td>
	          <td>${f.도착공항}</td>
	          <td>${f.출발시간}</td>
	          <td>${f.도착시간}</td>
	          <td>${f.총비행시간}</td>
	          <td>${f.경유정보}</td>
	          <td>${f.경유지}</td>
	        </tr>
	      </c:forEach>
	    </tbody>
	  </table>
	  </div>
<div class="footer-section">
<div class="paging">
  <c:if test="${paging.prev}">
    <a href="?from=${param.from}&to=${param.to}&date=${param.date}&nowPage=${paging.startPage - 1}&cntPerPage=${paging.cntPerPage}">◀ 이전</a>
  </c:if>

  <c:forEach begin="${paging.startPage}" end="${paging.endPage}" var="i">
  <a href="?from=${param.from}&to=${param.to}&date=${param.date}&nowPage=${i}&cntPerPage=${paging.cntPerPage}"
     class="${i == paging.nowPage ? 'active' : ''}">${i}</a>
</c:forEach>

  <c:if test="${paging.next}">
    <a href="?from=${param.from}&to=${param.to}&date=${param.date}&nowPage=${paging.startPage + 1}&cntPerPage=${paging.cntPerPage}">다음 ▶</a>
  </c:if>
</div>
</div>
	
	</body>
	</html>
