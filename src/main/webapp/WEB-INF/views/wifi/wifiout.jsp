<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<!DOCTYPE html>
<html>
<head>
  <title>wifi상품 출력</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <style>
    body {
      font-family: 'Noto Sans KR', sans-serif;
      background-color: #f4f6f9;
    }
    h2 {
      color: #1f2937;
      font-size: 28px;
      font-weight: 700;
    }
    .wifi-card-container {
      display: flex;
      flex-wrap: wrap;
      gap: 20px;
      justify-content: center;
    }
    .wifi-card {
      width: calc(25% - 20px);
      min-width: 240px;
      background: white;
      border-radius: 12px;
      box-shadow: 0 4px 12px rgba(0,0,0,0.1);
      overflow: hidden;
      transition: 0.2s ease;
    }
    .wifi-card:hover {
      transform: translateY(-5px);
      box-shadow: 0 8px 20px rgba(0,0,0,0.15);
    }
    .image-container {
      position: relative;
      width: 100%;
      height: 160px;
    }
    .image-container img {
      width: 100%;
      height: 100%;
      object-fit: cover;
      display: block;
    }
    .wifi-info {
      padding: 15px;
    }
    .wifi-info h3 {
      margin: 0 0 8px;
      font-size: 1.2em;
      color: #333;
    }
    .wifi-info p {
      font-size: 0.95em;
      color: #666;
      margin: 6px 0;
    }
    .like-button {
      position: absolute;
      top: 10px;
      right: 10px;
      width: 32px;
      height: 32px;
      border: none;
      background: #fff;
      border-radius: 50%;
      box-shadow: 0 3px 8px rgba(0,0,0,0.15);
      cursor: pointer;
      transition: transform 0.2s;
      padding: 0;
      display: flex;
      align-items: center;
      justify-content: center;
    }
    .like-button:hover {
      transform: scale(1.15);
    }
    .like-button img {
      width: 16px;
      height: 16px;
    }

    /* 수정 삭제 버튼 꾸미기 */
    .updel {
      text-align: center;
      padding: 15px;
    }
    .updel a {
      display: inline-block;
      margin: 0 5px;
      padding: 6px 14px;
      font-size: 13px;
      font-weight: 500;
      color: white;
      border-radius: 6px;
      text-decoration: none;
      transition: background 0.3s;
    }
    .updel a:first-child {
      background: #3b82f6;
    }
    .updel a:first-child:hover {
      background: #2563eb;
    }
    .updel a:last-child {
      background: #ef4444;
    }
    .updel a:last-child:hover {
      background: #dc2626;
    }

    .pagination {
      text-align: center;
      margin-top: 30px;
    }
    .pagination a, .pagination span {
      margin: 0 4px;
      text-decoration: none;
      color: #007bff;
      font-weight: bold;
    }
    .pagination .current {
      color: #fff;
      background-color: #007bff;
      padding: 4px 10px;
      border-radius: 4px;
    }
    .wificoncard {
      display: flex;
      flex-wrap: wrap;
      justify-content: center;
      gap: 12px;
      margin-bottom: 30px;
    }
    .wificoncard a {
      text-decoration: none;
    }
    .wificon {
      background-color: #007bff;
      color: white;
      padding: 10px 16px;
      border-radius: 20px;
      font-size: 14px;
      text-align: center;
      transition: 0.2s ease;
      cursor: pointer;
      white-space: nowrap;
    }
    .wificon:hover {
      background-color: #0056b3;
    }
  </style>
</head>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
  function toggleLike(id, wifinum) {
    if (!id) {
      alert("로그인 후 이용할 수 있어요 😊");
      location.href = "/login";
      return;
    }

    const btn = $("#likeBtn_" + wifinum);
    let liked = btn.data("liked");

    const url = liked ? 'deletewifilike' : 'wifilike';
    const heartImg = liked ? './image/heart2.png' : './image/heart1.png';

    $.ajax({
      url: url,
      type: 'POST',
      data: { id: id, wifinum: wifinum },
      success: function () {
        btn.find('img').attr("src", heartImg);
        btn.data("liked", !liked);
      },
      error: function () {
        alert((liked ? '좋아요 취소' : '좋아요 등록') + ' 중 오류가 발생했어요 😢');
      }
    });
  }
</script>

<body>
<h2 style="text-align:center;">wifi/e-sim 상품 목록</h2>
<div class="wificoncard"> 
  <a href="wificountry?wificon=대한민국"><div class="wificon">한국</div></a>
  <a href="wificountry?wificon=중국"><div class="wificon">중국</div></a>
  <a href="wificountry?wificon=일본"><div class="wificon">일본</div></a>
  <a href="wificountry?wificon=베트남"><div class="wificon">베트남</div></a>
  <a href="wificountry?wificon=호주"><div class="wificon">호주</div></a>
  <a href="wificountry?wificon=미국"><div class="wificon">미국</div></a>
  <a href="wificountry?wificon=영국"><div class="wificon">영국</div></a>
  <a href="wificountry?wificon=독일"><div class="wificon">독일</div></a>
  <a href="wificountry?wificon=프랑스"><div class="wificon">프랑스</div></a>
  <a href="wificountry?wificon=뉴질랜드"><div class="wificon">뉴질랜드</div></a>
</div>

<div class="wifi-card-container">
  <c:forEach items="${list}" var="wifi">
    <div class="wifi-card">
    <a href=${wifi.wifilink }>
      <div class="image-container">
        <img src="./image/${wifi.wifiimg}" alt="${wifi.wifiname}">
        <c:if test="${loginstate==true}">
          <button id="likeBtn_${wifi.wifinum}" class="like-button" type="button"
            data-liked="${wifi.liked}"
            onclick="toggleLike('${id}', ${wifi.wifinum}); event.stopPropagation(); return false;">
            <c:if test="${wifi.liked}">
              <img src="./image/heart1.png" alt="좋아요" width="30" height="30">
            </c:if>
            <c:if test="${!wifi.liked}">
              <img src="./image/heart2.png" alt="좋아요 취소" width="30" height="30">
            </c:if>
          </button>
        </c:if>
      </div>
      </a>
      <div class="wifi-info">
        <h3>${wifi.wifiname}</h3>
        <p>${wifi.wifidetail}</p>
        <p><strong>${wifi.wificountry}</strong> | ${wifi.wifiday}일</p>
      </div>
      <c:if test="${id=='admin'}">
        <div class="updel">
          <a href="wifiupdate?wifinum=${wifi.wifinum}">수정</a>
          <a href="wifidelete?wifinum=${wifi.wifinum}">삭제</a>
        </div>
      </c:if>
    </div>
  </c:forEach>
</div>
<c:choose>
<c:when test="${wifi.wificon==null }">
<div class="pagination">
  <c:if test="${paging.startPage != 1}">
    <a href="wifiout?nowPage=${paging.startPage - 1}&cntPerPage=${paging.cntPerPage}">이전</a>
  </c:if>
  <c:forEach begin="${paging.startPage}" end="${paging.endPage}" var="p">
    <c:choose>
      <c:when test="${p == paging.nowPage}">
        <span class="current">${p}</span>
      </c:when>
      <c:otherwise>
        <a href="wifiout?nowPage=${p}&cntPerPage=${paging.cntPerPage}">${p}</a>
      </c:otherwise>
    </c:choose>
  </c:forEach>
  <c:if test="${paging.endPage < paging.lastPage}">
    <a href="wifiout?nowPage=${paging.endPage + 1}&cntPerPage=${paging.cntPerPage}">다음</a>
  </c:if>
</div>
</c:when>
<c:otherwise>
	<c:if test="${paging.startPage != 1}">
    <a href="wificountry?wificon=${wifi.wificountry}&nowPage=${paging.startPage - 1}&cntPerPage=${paging.cntPerPage}">이전</a>
  </c:if>
  <c:forEach begin="${paging.startPage}" end="${paging.endPage}" var="p">
    <c:choose>
      <c:when test="${p == paging.nowPage}">
        <span class="current">${p}</span>
      </c:when>
      <c:otherwise>
        <a href="wificountry?wificon=${wifi.wificountry}&nowPage=${p}&cntPerPage=${paging.cntPerPage}">${p}</a>
      </c:otherwise>
    </c:choose>
  </c:forEach>
  <c:if test="${paging.endPage < paging.lastPage}">
    <a href="wificountry?wificon=${wifi.wificountry}&nowPage=${paging.endPage + 1}&cntPerPage=${paging.cntPerPage}">다음</a>
  </c:if>
</c:otherwise>
</c:choose>

</body>
</html>
