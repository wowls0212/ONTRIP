<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>  
<!DOCTYPE html>
<html>
<head>
  <title>패키지상품 출력</title>
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
      text-align: center;
    }
    .pack-card-container {
      display: flex;
      flex-wrap: wrap;
      gap: 20px;
      justify-content: center;
    }
    .card-link {
      text-decoration: none;
      color: inherit;
      display: block;
    }
    .pack-card {
      position: relative;
      width: calc(25% - 20px);
      min-width: 240px;
      background: white;
      border-radius: 12px;
      box-shadow: 0 4px 12px rgba(0,0,0,0.1);
      overflow: hidden;
      transition: 0.2s ease;
    }
    .pack-card:hover {
      transform: translateY(-5px);
      box-shadow: 0 8px 20px rgba(0,0,0,0.15);
    }
    .pack-card img {
      width: 100%;
      height: 160px;
      object-fit: cover;
      display: block;
    }
    .pack-info {
      padding: 15px;
    }
    .pack-info h3 {
      margin: 0 0 8px;
      font-size: 1.2em;
      color: #333;
    }
    .pack-info p {
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

   
    .updel {
      text-align: center;
      padding: 12px;
    }
    .updel a {
      display: inline-block;
      margin: 0 6px;
      padding: 6px 16px;
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
    .packconcard {
      display: flex;
      flex-wrap: wrap;
      justify-content: center;
      gap: 12px;
      margin: 20px 0 30px;
    }
    .packconcard a {
      text-decoration: none;
    }
    .packcon {
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
    .packcon:hover {
      background-color: #0056b3;
    }
  </style>
</head>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
  function toggleLike(id, packagenum) {
     if (!id) {
       alert("로그인 후 이용할 수 있어요 😊");
       location.href = "/login";
       return;
     }

     const btn = $("#likeBtn_" + packagenum);
     let liked = btn.data("liked");

     const url = liked ? 'deletepacklike' : 'packlike';
     const heartImg = liked ? './image/heart2.png' : './image/heart1.png';

     $.ajax({
       url: url,
       type: 'POST',
       data: { id: id, packagenum: packagenum },
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

<h2>패키지 상품 목록</h2>
<div class="packconcard">
  <a href="packcountry?packcon=대한민국"><div class="packcon">한국</div></a>
  <a href="packcountry?packcon=중국"><div class="packcon">중국</div></a>
  <a href="packcountry?packcon=일본"><div class="packcon">일본</div></a>
  <a href="packcountry?packcon=베트남"><div class="packcon">베트남</div></a>
  <a href="packcountry?packcon=호주"><div class="packcon">호주</div></a>
  <a href="packcountry?packcon=미국"><div class="packcon">미국</div></a>
  <a href="packcountry?packcon=영국"><div class="packcon">영국</div></a>
  <a href="packcountry?packcon=독일"><div class="packcon">독일</div></a>
  <a href="packcountry?packcon=프랑스"><div class="packcon">프랑스</div></a>
  <a href="packcountry?packcon=뉴질랜드"><div class="packcon">뉴질랜드</div></a>
</div>

<div class="pack-card-container">
  <c:forEach items="${list}" var="pack">
    <div class="pack-card">
      <a href="${pack.packagelink}" class="card-link" target="_blank">
        <img src="./image/${pack.packageimg}" alt="${pack.packagename}">
        <c:if test="${loginstate==true}">
          <button id="likeBtn_${pack.packagenum}" class="like-button" type="button"
            data-liked="${pack.liked}"
            onclick="toggleLike('${id}', ${pack.packagenum}); event.stopPropagation(); return false;">
            <c:if test="${pack.liked}">
              <img src="./image/heart1.png" alt="좋아요">
            </c:if>
            <c:if test="${!pack.liked}">
              <img src="./image/heart2.png" alt="좋아요 취소">
            </c:if>
          </button>
        </c:if>
        <div class="pack-info">
          <h3>
            <c:choose>
              <c:when test="${fn:length(pack.packagename) > 30}">
                ${fn:substring(pack.packagename, 0, 30)}...
              </c:when>
              <c:otherwise>
                ${pack.packagename}
              </c:otherwise>
            </c:choose>
          </h3>
          <p>
            <c:choose>
              <c:when test="${fn:length(pack.packagedetail) > 50}">
                ${fn:substring(pack.packagedetail, 0, 50)}...
              </c:when>
              <c:otherwise>
                ${pack.packagedetail}
              </c:otherwise>
            </c:choose>
          </p>
          <p><strong>${pack.packagecountry}</strong> | ${pack.packageday}일</p>
        </div>
      </a>
      <c:if test="${id=='admin'}">
        <div class="updel">
          <a href="packupdate?packagenum=${pack.packagenum}">수정</a>
          <a href="packdelete?packagenum=${pack.packagenum}">삭제</a>
        </div>
      </c:if>
    </div>
  </c:forEach>
</div>

<div class="pagination">
  <c:if test="${paging.startPage != 1}">
    <a href="packout?nowPage=${paging.startPage - 1}&cntPerPage=${paging.cntPerPage}">이전</a>
  </c:if>

  <c:forEach begin="${paging.startPage}" end="${paging.endPage}" var="p">
    <c:choose>
      <c:when test="${p == paging.nowPage}">
        <span class="current">${p}</span>
      </c:when>
      <c:otherwise>
        <a href="packout?nowPage=${p}&cntPerPage=${paging.cntPerPage}">${p}</a>
      </c:otherwise>
    </c:choose>
  </c:forEach>

  <c:if test="${paging.endPage < paging.lastPage}">
    <a href="packout?nowPage=${paging.endPage + 1}&cntPerPage=${paging.cntPerPage}">다음</a>
  </c:if>
</div>
</body>
</html>
