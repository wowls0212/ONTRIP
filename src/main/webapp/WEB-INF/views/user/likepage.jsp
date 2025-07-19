<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>좋아요</title>
<style>
body {
  font-family: 'Noto Sans KR', sans-serif;
  background: #f7f9fc;
  margin: 0;
  padding: 40px 0;
}

h2 {
  text-align: center;
  font-size: 32px;
  font-weight: 800;
  color: #1f2937;
  margin-bottom: 15px;
  position: relative;
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

button {
  background: #8BC34A;
  color: #fff;
  font-size: 16px;
  font-weight: bold;
  padding: 12px 28px;
  margin: 10px 8px;
  border: none;
  border-radius: 24px;
  cursor: pointer;
  transition: all 0.3s ease;
  box-shadow: 0 4px 12px rgba(0,0,0,0.15);
}
button:hover {
  background: #7cb342;
  transform: scale(1.08);
  box-shadow: 0 8px 20px rgba(139,195,74,0.4);
}

.section-box {
  max-width: 1000px;
  margin: 30px auto;
  background: #fff;
  border-radius: 16px;
  box-shadow: 0 6px 18px rgba(0,0,0,0.1);
  padding: 30px;
}
.section-box h3 {
  margin-top: 0;
  margin-bottom: 20px;
  font-size: 22px;
  color: #333;
  font-weight: 800;
  text-align: left; 
  border-left: 6px solid #8BC34A;
  padding-left: 12px;
}


.like-list-wrapper {
  display: flex;
  flex-direction: column;
  gap: 12px;
}

.like-list-header {
  display: grid;
  grid-template-columns: 1fr 1fr 1fr;
  text-align: center;
  font-size: 15px;
  color: #666;
  background: #dcedc8;
  padding: 16px;
  border-radius: 12px;
}


.like-list-row {
  display: grid;
  grid-template-columns: 1fr 1fr 1fr;
  text-align: center;
  background: #fdfdfd;
  border-radius: 12px;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.06);
  transition: all 0.3s ease;
  padding: 16px;
}
.like-list-row:hover {
  background: #f1f8e9;
  transform: translateY(-2px);
}


.like-list-row .col,
.like-list-header .col {
  font-size: 14px;
  color: #333;
  display: flex;
  align-items: center;
  justify-content: center;
}


.like-list-row img {
  border-radius: 8px;
  width: 140px;
  height: auto;
  max-height: 100px;
}


.no-like-list {
  padding: 20px;
  text-align: center;
  font-style: italic;
  color: #888;
}
</style>
</head>

<script>
document.addEventListener("DOMContentLoaded", function () {
  const btnTrip = document.getElementById("btnTrip");
  const btnWifi = document.getElementById("btnWifi");
  const btnPackage = document.getElementById("btnPackage");
  const btnAll = document.getElementById("btnAll");

  const tripSection = document.getElementById("tripSection");
  const wifiSection = document.getElementById("wifiSection");
  const packageSection = document.getElementById("packageSection");

  btnTrip.addEventListener("click", function () {
    tripSection.style.display = "block";
    wifiSection.style.display = "none";
    packageSection.style.display = "none";
  });

  btnWifi.addEventListener("click", function () {
    tripSection.style.display = "none";
    wifiSection.style.display = "block";
    packageSection.style.display = "none";
  });

  btnPackage.addEventListener("click", function () {
    tripSection.style.display = "none";
    wifiSection.style.display = "none";
    packageSection.style.display = "block";
  });

  btnAll.addEventListener("click", function () {
    tripSection.style.display = "block";
    wifiSection.style.display = "block";
    packageSection.style.display = "block";
  });

  btnAll.click(); 
});
</script>

<body>
  <h2>좋아요</h2>
  <div style="text-align:center;">
    <button id="btnAll">전체보기</button>
    <button id="btnTrip">여행지</button>
    <button id="btnWifi">WIFI/U-SIM</button>
    <button id="btnPackage">패키지</button>
  </div>

  <div id="tripSection" class="section-box">
    <h3>여행지</h3>
	 <c:choose>
	  <c:when test="${empty list}">
	    <div class="no-like-list">찜한 목록이 없습니다.</div>
	  </c:when>
	  <c:otherwise>
	    <div class="like-list-wrapper">
	      <div class="like-list-header">
	        <div class="col">여행국가</div>
	        <div class="col">여행지</div>
	        <div class="col">이미지</div>
	      </div>
	
	      <c:forEach items="${list}" var="like">
	      <a href="countrydetail?countrynum=${like.countrynum}">
	        <div class="like-list-row">
	          <div class="col">${like.country}</div>
	          <div class="col">${like.tripname}</div>
	          <div class="col"><img src="./image/${like.tripimg}" width="100"></div>
	        </div>
	        </a>
	      </c:forEach>
	    </div>
	  </c:otherwise>
	</c:choose>
  </div>

  <div id="wifiSection" class="section-box">
    <h3>WIFI/U-SIM</h3>
   	<c:choose>
	  <c:when test="${empty list2}">
	    <div class="no-like-list">찜한 목록이 없습니다.</div>
	  </c:when>
	  <c:otherwise>
	    <div class="like-list-wrapper">
	      <div class="like-list-header">
	        <div class="col">여행국가</div>
	        <div class="col">상품명</div>
	        <div class="col">이미지</div>
	      </div>
	
	      <c:forEach items="${list2}" var="wlike">
	      <a href="${wlike.wifilink }">
	        <div class="like-list-row">
	          <div class="col">${wlike.wificountry}</div>
	          <div class="col">${wlike.wifiname}</div>
	          <div class="col"><img src="./image/${wlike.wifiimg}" width="100"></div>
	        </div>
	        </a>
	      </c:forEach>
	    </div>
	  </c:otherwise>
	</c:choose>
  </div>

  <div id="packageSection" class="section-box">
    <h3>패키지</h3>
    <c:choose>
	  <c:when test="${empty list3}">
	    <div class="no-like-list">찜한 목록이 없습니다.</div>
	  </c:when>
	  <c:otherwise>
	    <div class="like-list-wrapper">
	      <div class="like-list-header">
	        <div class="col">여행국가</div>
	        <div class="col">상품명</div>
	        <div class="col">이미지</div>
	      </div>
	
	      <c:forEach items="${list3}" var="plike">
	      <a href="${plike.packagelink }">
	        <div class="like-list-row">
	          <div class="col">${plike.packagecountry}</div>
	          <div class="col">${plike.packagename}</div>
	          <div class="col"><img src="./image/${plike.packageimg}" width="100"></div>
	        </div>
	        </a>
	      </c:forEach>
	    </div>
	  </c:otherwise>
	</c:choose>
  </div>
</body>
</html>
