<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
  <title>여행지 출력</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">

  <style>
    body {
      font-family: 'Noto Sans KR', sans-serif;
      background-color: #f4f6f9;
      margin: 0;
    }

    .container {
      max-width: 1000px;
      margin: 40px auto;
      padding: 0 20px;
    }

    h2 {
      text-align: left;
      color: #1f2937;
  font-size: 28px;
  font-weight: 700;
      margin-bottom: 30px;
    }

    .search-box {
      position: relative;
      z-index: 2;
      margin-bottom: 20px;
      width: 100%;
      height: 60px;
      display: flex;
      background: white;
      border-radius: 10px;
      overflow: hidden;
      box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2);
    }

    .search-box input {
      flex: 1;
      padding: 0 20px;
      font-size: 18px;
      border: none;
      outline: none;
    }

    .search-box button {
      width: 60px;
      background: #005c8d;
      border: none;
      display: flex;
      align-items: center;
      justify-content: center;
      cursor: pointer;
    }

    .search-box button img {
      height: 28px;
      width: auto;
    }

    .trip-list {
      display: flex;
      flex-direction: column;
      gap: 20px;
    }

    .trip-card {
      display: flex;
      background: #fff;
      border-radius: 12px;
      box-shadow: 0 2px 10px rgba(0,0,0,0.08);
      overflow: hidden;
      transition: transform 0.2s, box-shadow 0.2s;
    }

    .trip-card:hover {
      transform: translateY(-4px);
      box-shadow: 0 6px 20px rgba(0,0,0,0.12);
    }

    .trip-card img.trip-photo {
      width: 240px;
      height: 160px;
      object-fit: cover;
      flex-shrink: 0;
    }

    .trip-info {
      flex: 1;
      padding: 16px 20px;
      display: flex;
      flex-direction: column;
      justify-content: center;
    }

    .trip-info h3 {
      margin: 0;
      font-size: 22px;
      color: #184fa1;
    }

 .trip-info .address-line {
  display: flex;
  align-items: center;
  justify-content: center; /* 추가! */
  margin: 8px 0;
  font-size: 15px;
  color: #555;
}
    .trip-info .address-line img.flag {
      width: 22px;
      height: 16px;
      object-fit: cover;
      margin-right: 8px;
      border-radius: 3px;
      box-shadow: 0 1px 3px rgba(0,0,0,0.2);
    }

    .tags {
      display: flex;
      gap: 8px;
      margin-top: 6px;
    }

    .tag {
      background: #184fa1;
      color: white;
      font-size: 12px;
      padding: 4px 8px;
      border-radius: 8px;
    }

    .pagination {
      display: flex;
      justify-content: center;
      flex-wrap: wrap;
      gap: 8px;
      margin-top: 30px;
    }

    .pagination a {
      text-decoration: none;
      padding: 6px 12px;
      font-size: 14px;
      color: #333;
      border: 1px solid #ccc;
      border-radius: 6px;
      background-color: #fff;
      transition: all 0.2s ease;
    }

    .pagination a:hover {
      background-color: #f0f4fa;
      border-color: #184fa1;
    }

    .pagination a.active {
      background-color: #184fa1;
      color: white;
      border-color: #184fa1;
      font-weight: bold;
    }

    .side-banner {
      position: absolute;
      top: 250px;
      left: 20px;
      width: 220px;
      background-color: #ffffff;
      border-radius: 12px;
      box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
      padding: 25px 15px;
      z-index: 999;
    }

    .category {
      background-color: #005c8d;
      color: white;
      border-radius: 12px;
      margin-bottom: 10px;
      text-align: center;
      padding: 10px;
    }

    .side-dropdown, .side-dropdown-menu {
      list-style: none;
      padding: 0;
      margin: 0;
    }

    .side-dropdown-item {
      position: relative;
    }

    .side-dropdown-toggle {
      display: block;
      text-align: left;
      text-decoration: none;
      color: #333;
      padding: 8px 0;
    }

    .side-dropdown-menu {
      position: absolute;
      left: 100%;
      top: 0;
      background: #ffffff;
      box-shadow: 0 2px 8px rgba(0,0,0,0.1);
      border-radius: 8px;
      display: none;
      min-width: 160px;
      z-index: 999;
    }

    .side-dropdown-item:hover .side-dropdown-menu {
      display: block;
    }

    .side-dropdown-menu li {
      padding: 8px 16px;
      white-space: nowrap;
    }

    .side-dropdown-menu li a {
      text-decoration: none;
      color: #333;
      display: block;
    }

    .side-dropdown-menu li:hover {
      background-color: #f0f4fa;
    }
  </style>
</head>
<body>
<div class="container">
  <h2>여행지 목록</h2>

  <form action="countrysearch">
    <div class="search-box">
      <input type="text" placeholder="가고 싶은 곳을 검색해보세요." name="countrysearch">
      <button class="submit">
        <img src="${pageContext.request.contextPath}/image/dd.png" alt="검색">
      </button>
    </div>
  </form>

  <div class="trip-list">
    <c:forEach items="${list}" var="con">
      <c:set var="countryLower" value="${fn:toLowerCase(con.country)}" />
      <c:choose>
        <c:when test="${fn:contains(countryLower, '한국') || fn:contains(countryLower, '대한민국')}"><c:set var="flag" value="kr"/></c:when>
        <c:when test="${fn:contains(countryLower, '중국')}"><c:set var="flag" value="cn"/></c:when>
        <c:when test="${fn:contains(countryLower, '일본')}"><c:set var="flag" value="jp"/></c:when>
        <c:when test="${fn:contains(countryLower, '베트남')}"><c:set var="flag" value="vn"/></c:when>
        <c:when test="${fn:contains(countryLower, '호주')}"><c:set var="flag" value="au"/></c:when>
        <c:when test="${fn:contains(countryLower, '미국') || fn:contains(countryLower, 'usa')}"><c:set var="flag" value="us"/></c:when>
        <c:when test="${fn:contains(countryLower, '영국') || fn:contains(countryLower, 'uk') || fn:contains(countryLower, 'united kingdom')}"><c:set var="flag" value="gb"/></c:when>
        <c:when test="${fn:contains(countryLower, '독일')}"><c:set var="flag" value="de"/></c:when>
        <c:when test="${fn:contains(countryLower, '프랑스')}"><c:set var="flag" value="fr"/></c:when>
        <c:when test="${fn:contains(countryLower, '뉴질랜드')}"><c:set var="flag" value="nz"/></c:when>
        <c:otherwise><c:set var="flag" value="us"/></c:otherwise>
      </c:choose>
	<a href="countrydetail?countrynum=${con.countrynum}">
      <div class="trip-card">
          <img src="./image/${con.tripimg}" class="trip-photo" alt="${con.tripname}">
        <div class="trip-info">
          <h3>${con.tripname}</h3>
          <div class="address-line">
            <img src="https://flagcdn.com/w20/${flag}.png" class="flag" alt="${con.country}">
            ${con.country} : ${con.address}
          </div>
          <div class="tags">
            <div class="tag">
              <c:choose>
                <c:when test="${con.tripstyle == 'activity'}">액티비티</c:when>
                <c:when test="${con.tripstyle == 'food'}">맛집탐방</c:when>
                <c:when test="${con.tripstyle == 'tourist'}">관광지 탐방</c:when>
                <c:when test="${con.tripstyle == 'resort'}">휴양지</c:when>
              </c:choose>
            </div>
            <div class="tag">
              <c:choose>
                <c:when test="${con.branch <= 3}">1분기</c:when>
                <c:when test="${con.branch <= 6}">2분기</c:when>
                <c:when test="${con.branch <= 9}">3분기</c:when>
                <c:otherwise>4분기</c:otherwise>
              </c:choose>
            </div>
          </div>
        </div>
      </div>
      </a>
    </c:forEach>
  </div>

  <div class="pagination">
    <c:if test="${paging.startPage != 1}">
      <a href="countryout?nowPage=${paging.startPage - 1}&cntPerPage=${paging.cntPerPage}">◀ 이전</a>
    </c:if>
    <c:forEach begin="${paging.startPage}" end="${paging.endPage}" var="p">
      <c:choose>
        <c:when test="${p == paging.nowPage}">
          <a class="active">${p}</a>
        </c:when>
        <c:otherwise>
          <a href="countryout?nowPage=${p}&cntPerPage=${paging.cntPerPage}">${p}</a>
        </c:otherwise>
      </c:choose>
    </c:forEach>
    <c:if test="${paging.endPage != paging.lastPage}">
      <a href="countryout?nowPage=${paging.endPage + 1}&cntPerPage=${paging.cntPerPage}">다음 ▶</a>
    </c:if>
  </div>
</div>

<div class="side-banner">
  <div class="category"><label>카테고리</label></div>
  <a href="likecountry" class="side-dropdown-toggle">▶ 인기순</a>
  <ul class="side-dropdown">
    <li class="side-dropdown-item">
      <a href="#" class="side-dropdown-toggle">▶ 여행스타일</a>
      <ul class="side-dropdown-menu">
        <li><a href="tripstyle?tripstyle=activity">액티비티</a></li>
        <li><a href="tripstyle?tripstyle=tourist">관광지탐방</a></li>
        <li><a href="tripstyle?tripstyle=food">맛집탐방</a></li>
        <li><a href="tripstyle?tripstyle=resort">휴양지</a></li>
      </ul>
    </li>
  </ul>
  <ul class="side-dropdown">
    <li class="side-dropdown-item">
      <a href="#" class="side-dropdown-toggle">▶ 분기별 인기 여행지</a>
      <ul class="side-dropdown-menu">
        <li><a href="bran?branch=1&branch=2&branch=3">1분기(1~3월)</a></li>
        <li><a href="bran?branch=4&branch=5&branch=6">2분기(4~6월)</a></li>
        <li><a href="bran?branch=7&branch=8&branch=9">3분기(7~9월)</a></li>
        <li><a href="bran?branch=10&branch=11&branch=12">4분기(10~12월)</a></li>
      </ul>
    </li>
  </ul>
  <ul class="side-dropdown" style="padding: 0; margin: 0;">
        <li class="side-dropdown-item">
          <a href="#" class="side-dropdown-toggle">▶ 나라별 여행지</a>
          <ul class="side-dropdown-menu">
            <li><a href="con?con=대한민국">대한민국</a></li>
            <li><a href="con?con=일본">일본</a></li>
            <li><a href="con?con=중국">중국</a></li>
            <li><a href="con?con=베트남">베트남</a></li>
            <li><a href="con?con=호주">호주</a></li>
            <li><a href="con?con=미국">미국</a></li>
            <li><a href="con?con=영국">영국</a></li>
            <li><a href="con?con=독일">독일</a></li>
            <li><a href="con?con=프랑스">프랑스</a></li>
            <li><a href="con?con=뉴질랜드">뉴질랜드</a></li>
          </ul>
        </li>
      </ul>
</div>
</body>
</html>
