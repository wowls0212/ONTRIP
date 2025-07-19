<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>검색 결과</title>
<meta name="viewport" content="width=device-width, initial-scale=1">

<style>
body {
  position: relative;
  overflow-x: hidden;
}
body::before {
  content: "";
  position: fixed;
  top: 0; left: 0;
  width: 100%;
  height: 100%;
  background: url('${pageContext.request.contextPath}/image/sky.gif') center center / cover no-repeat fixed;
  filter: blur(8px);
  z-index: -1;
  opacity: 0.8;
}
.section-title {
  font-size: 22px;
  font-weight: 600;
  color: #000;
  margin: 30px 0 15px;
  text-align: center;
}

.card {
  flex: 0 0 auto;
  background: white;
  border-radius: 12px; 
  box-shadow: 0 4px 12px rgba(0,0,0,0.08);
  overflow: hidden;
  transition: transform 0.3s, box-shadow 0.3s;
  text-decoration: none;
  color: inherit;
  margin-bottom: 20px; 
  width: 260px; 
}
.card img {
  width: 100%;
  height: 160px;
  object-fit: cover;
  display: block;
}
.card-content {
  padding: 15px;
  font-size: 14px;
}
.card-content h3 {
  margin: 0 0 8px;
  font-size: 16px;
  font-weight: 700;
  color: #333;
}
.card-content p {
  font-size: 13px;
  color: #555;
  margin: 6px 0;
  line-height: 1.4;
}


.travel-wrapper {
  position: relative;
  display: flex;
  align-items: left;
  justify-content: center;
  margin: 0 auto 20px auto;
}

#travelSlider {
  display: flex;
  gap: 10px;
  overflow-x: auto;           
  scroll-behavior: smooth;
  scrollbar-width: none;
  -ms-overflow-style: none;
  flex-wrap: nowrap;
  width: calc(260px * 5 + 10px * 4); 
}

#travelSlider::-webkit-scrollbar {
  display: none; 
}

.travel-prev, .travel-next,
.sim-prev, .sim-next,
.wifi-prev, .wifi-next {
  background: none;
  border: none;
  color: #0076ff;
  font-size: 32px;
  cursor: pointer;
  z-index: 10;
}
.travel-prev { margin-right: 10px; }
.travel-next { margin-left: 10px; }


.sim-wrapper, .wifi-wrapper {
  position: relative;
  display: flex;
  align-items: center;
  justify-content: center;
  margin: 0 20px 20px 20px;
}


.sim-slider, .wifi-slider {
  display: flex;
  gap: 10px;
  overflow-x: auto;
  scroll-behavior: smooth;
  scrollbar-width: none;
  -ms-overflow-style: none;
  flex-wrap: nowrap;
  width: calc(260px * 5 + 10px * 4); 
}
.sim-slider::-webkit-scrollbar,
.wifi-slider::-webkit-scrollbar {
  display: none;
}

.sim-prev { left: 10px; }
.sim-next { right: 10px; }
.wifi-prev { left: 10px; }
.wifi-next { right: 10px; }
.search-box {
  position: relative;
  z-index: 2;
  margin: 0 auto;
  width: 600px;
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
.searbox{
  margin-top: 25px;
}

</style>
</head>

<body>
<div class="searbox">
	<form action="mainsearch">
    <div class="search-box">
      <input type="text" value="${mainsearch}" name="mainsearch">
      <button class="submit">
        <img src="${pageContext.request.contextPath}/image/dd.png" alt="검색">
      </button>
    </div>
    </form>
   </div>
<!-- 여행지  -->
<div class="section-title">여행지</div>
<div class="travel-wrapper">
  <button class="travel-prev" onclick="prevTravelSlide()">❮</button>
  <div class="travel-slider" id="travelSlider">
    <c:forEach items="${list}" var="con">
      <a href="countrydetail?countrynum=${con.countrynum}" class="card travle">
        <img src="./image/${con.tripimg}" alt="${con.tripname}">
        <div class="card-content">
          <h3>${con.tripname}</h3>
          <p>
            <c:choose>
              <c:when test="${con.tripstyle=='activity'}">액티비티</c:when>
              <c:when test="${con.tripstyle=='food'}">맛집탐방</c:when>
              <c:when test="${con.tripstyle=='tourist'}">관광지 탐방</c:when>
              <c:when test="${con.tripstyle=='resort'}">휴양지</c:when>
            </c:choose> |
            <c:choose>
              <c:when test="${con.branch==1}">1분기</c:when>
              <c:when test="${con.branch==2}">1분기</c:when>
              <c:when test="${con.branch==3}">1분기</c:when>
              <c:when test="${con.branch==4}">2분기</c:when>
              <c:when test="${con.branch==5}">2분기</c:when>
              <c:when test="${con.branch==6}">2분기</c:when>
              <c:when test="${con.branch==7}">3분기</c:when>
              <c:when test="${con.branch==8}">3분기</c:when>
              <c:when test="${con.branch==9}">3분기</c:when>
              <c:when test="${con.branch==10}">4분기</c:when>
              <c:when test="${con.branch==11}">4분기</c:when>
              <c:when test="${con.branch==12}">4분기</c:when>
            </c:choose>
          </p>
        </div>
      </a>
    </c:forEach>
  </div>
  <button class="travel-next" onclick="nextTravelSlide()">❯</button>
</div>

<!-- 패키지 -->
<div class="section-title">패키지</div>
<div class="sim-wrapper">
  <button class="sim-prev" onclick="prevSimSlide()">❮</button>
  <div class="sim-slider" id="simSlider">
    <c:forEach items="${list2}" var="pack">
      <a href="${pack.packagelink}" class="card default" target="_blank">
        <img src="./image/${pack.packageimg}" alt="${pack.packagename}">
        <div class="card-content">
          <h3>
            <c:choose>
              <c:when test="${fn:length(pack.packagename) > 25}">
                ${fn:substring(pack.packagename, 0, 25)}...
              </c:when>
              <c:otherwise>${pack.packagename}</c:otherwise>
            </c:choose>
          </h3>
          <p>
            <c:choose>
              <c:when test="${fn:length(pack.packagedetail) > 40}">
                ${fn:substring(pack.packagedetail, 0, 40)}...
              </c:when>
              <c:otherwise>${pack.packagedetail}</c:otherwise>
            </c:choose>
          </p>
          <p>${pack.packagecountry} | ${pack.packageday}일</p>
        </div>
      </a>
    </c:forEach>
  </div>
  <button class="sim-next" onclick="nextSimSlide()">❯</button>
</div>

<!-- wifi/e-sim -->
<div class="section-title">wifi/e-sim</div>
<div class="wifi-wrapper">
  <button class="wifi-prev" onclick="prevWifiSlide()">❮</button>
  <div class="wifi-slider" id="wifiSlider">
    <c:forEach items="${list3}" var="wifi">
      <a href="${wifi.wifilink}" class="card default" target="_blank">
        <img src="./image/${wifi.wifiimg}" alt="${wifi.wifiname}">
        <div class="card-content">
          <h3>
            <c:choose>
              <c:when test="${fn:length(wifi.wifiname) > 25}">
                ${fn:substring(wifi.wifiname, 0, 25)}...
              </c:when>
              <c:otherwise>${wifi.wifiname}</c:otherwise>
            </c:choose>
          </h3>
          <p>
            <c:choose>
              <c:when test="${fn:length(wifi.wifidetail) > 40}">
                ${fn:substring(wifi.wifidetail, 0, 40)}...
              </c:when>
              <c:otherwise>${wifi.wifidetail}</c:otherwise>
            </c:choose>
          </p>
          <p>${wifi.wificountry} | ${wifi.wifiday}일</p>
        </div>
      </a>
    </c:forEach>
  </div>
  <button class="wifi-next" onclick="nextWifiSlide()">❯</button>
</div>

<script>
document.addEventListener('DOMContentLoaded', function() {
    const travelSlider = document.getElementById('travelSlider');

    window.nextTravelSlide = function() {
      if (!travelSlider) return; 

      const card = travelSlider.querySelector('.card');
      if (!card) return; 

      const maxScrollLeft = travelSlider.scrollWidth - travelSlider.clientWidth;
      if (travelSlider.scrollLeft >= maxScrollLeft - card.offsetWidth) {
        travelSlider.scrollTo({ left: 0, behavior: 'smooth' });
      } else {
        travelSlider.scrollBy({ left: card.offsetWidth + 10, behavior: 'smooth' });
      }
    };

    window.prevTravelSlide = function() {
      if (!travelSlider) return; 

      const card = travelSlider.querySelector('.card');
      if (!card) return; 

 
      if (travelSlider.scrollLeft <= 0) {
        const maxScrollLeft = travelSlider.scrollWidth - travelSlider.clientWidth;
        travelSlider.scrollTo({ left: maxScrollLeft, behavior: 'smooth' });
      } else {
        travelSlider.scrollBy({ left: -(card.offsetWidth + 10), behavior: 'smooth' });
      }
    };
  });
function nextSimSlide() {
	  const card = simSlider.querySelector('.card');
	  const maxScrollLeft = simSlider.scrollWidth - simSlider.clientWidth;
	  if (simSlider.scrollLeft >= maxScrollLeft - card.offsetWidth) {
	    simSlider.scrollTo({ left: 0, behavior: 'smooth' });
	  } else {
	    simSlider.scrollBy({ left: card.offsetWidth + 10, behavior: 'smooth' });
	  }
	}
function prevSimSlide() {
  const card = simSlider.querySelector('.card');
  if (simSlider.scrollLeft <= 0) {
    const maxScrollLeft = simSlider.scrollWidth - simSlider.clientWidth;
    simSlider.scrollTo({ left: maxScrollLeft, behavior: 'smooth' });
  } else {
    simSlider.scrollBy({ left: -(card.offsetWidth + 10), behavior: 'smooth' });
  }
}

const wifiSlider = document.getElementById('wifiSlider');
function nextWifiSlide() {
  const card = wifiSlider.querySelector('.card');
  const maxScrollLeft = wifiSlider.scrollWidth - wifiSlider.clientWidth;

  if (wifiSlider.scrollLeft >= maxScrollLeft - card.offsetWidth) {
    wifiSlider.scrollTo({ left: 0, behavior: 'smooth' });
  } else {
    wifiSlider.scrollBy({ left: card.offsetWidth + 10, behavior: 'smooth' });
  }
}

function prevWifiSlide() {
  const card = wifiSlider.querySelector('.card');
  if (wifiSlider.scrollLeft <= 0) {
    const maxScrollLeft = wifiSlider.scrollWidth - wifiSlider.clientWidth;
    wifiSlider.scrollTo({ left: maxScrollLeft, behavior: 'smooth' });
  } else {
    wifiSlider.scrollBy({ left: -(card.offsetWidth + 10), behavior: 'smooth' });
  }
}

</script>
</body>
</html>
