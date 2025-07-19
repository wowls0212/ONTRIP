<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page import="java.time.LocalDate" %>    
<%
    LocalDate today = LocalDate.now();
    int month = today.getMonthValue();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ONTRIP - 여행 ON, 일상은 OFF</title>
<style>
  body {
    margin: 0;
    font-family: 'Noto Sans KR', sans-serif;
  }

  .main-banner {
    position: relative;
    text-align: center;
    padding: 100px 20px;
    background: url('${pageContext.request.contextPath}/image/sky.png') no-repeat center center;
    background-size: cover;
    height: 400px;
  }

  .main-banner::before {
    content: "";
    position: absolute;
    top: 0; left: 0;
    width: 100%; height: 100%;
    background-color: rgba(255, 255, 255, 0.7); /* 밝은 오버레이 */
    z-index: 1;
  }

  /* 메인 타이틀 */
  .main-banner h1 {
    position: relative;
    z-index: 2;
    font-size: 52px;
    font-weight: 900;
    color: #ffffff;  /* 상단바와 같은 파랑 */
    text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.3);  /* 자연스러운 그림자 */
    margin-bottom: 20px;
  }

  /* 서브 텍스트 */
  .main-banner p {
    position: relative;
    z-index: 2;
    font-size: 24px;
    font-weight: 500;
    color: white;
    margin-bottom: 40px;
  }

  /* 검색창 */
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
  
  .category-icons {
  display: flex;
  justify-content: center;
  align-items: center;
  gap: 40px;
  padding: 40px 0;
  background-color: #ffffff;
}

.category-icons {
  display: flex;
  justify-content: center;
  gap: 80px; /* 아이콘 간 간격 */
  margin-top: 1px;
  flex-wrap: wrap;
}

.icon-item {
  display: flex;
  flex-direction: column;
  align-items: center;
}

.icon-item img {
  width: 70px;
  height: 70px;
  object-fit: contain; /* 이미지 비율 유지 */
  margin-bottom: 10px;
}

.icon-item p {
  font-size: 16px;
  font-weight: 500;
  color: #333;
  margin: 0;
}
 .slider-wrapper {
    position: relative;
    margin: 5px auto;
    padding: 0 60px;
    max-width: 1400px;
    margin-bottom: 10px;    
  }

  .slider-container {
    display: flex;
    overflow: hidden;
    scroll-behavior: smooth;
    justify-content: center;
  }

  .slide {
    flex: 0 0 auto;
    width: 300px;
    height: 400px;
    margin-right: 20px;
    border-radius: 10px;
    overflow: hidden;
    box-shadow: 0 4px 8px rgba(0,0,0,0.1);
  }
    .slide img {
  width: 100%;
  height: 100%;
  object-fit: cover;
  display: block;
  transition: opacity 0.3s ease;  /* ✨ 부드럽게 전환 */
}

.slide img:hover {
  opacity: 0.7; /* ✨ 마우스 올렸을 때 약간 흐려짐 */
}


  .slider-btn {
    position: absolute;
    top: 50%;
    transform: translateY(-50%);
    background-color: white;
    color: #184fa1;
    border: none;
    font-size: 24px;
    padding: 12px;
    border-radius: 50%;
    cursor: pointer;
    z-index: 10;
    width: 50px;
    height: 50px;
  }

  .prev-btn {
    left: 0;
  }

  .next-btn {
    right: 0;
  }

	.event-banner {
  position: relative;
  height: 200px;
  display: flex;
  align-items: center;
  overflow: inherit;
  justify-content: center;
  margin-bottom: 70px; /* ✅ 여백 줄이기 */
}


  #myCarousel {
  width: 1300px;
  height: 250px;
  margin: 0 auto; /* 가운데 정렬 */
  overflow: hidden; /* 혹시 이미지가 넘치지 않도록 */
  border-radius: 12px; /* 선택 사항: 둥근 모서리 */
}

.carousel-inner {
  width: 100%;
}

.carousel-inner .item {
  width: 100%;
}

.carousel-inner .item img {
  width: 100%;
  height: 100%;
  object-fit: cover; /* 잘리는 영역 없이 비율 유지 */
}
   
   
  .sim-slider-wrapper {
  margin: 60px auto 10px;
  position: relative;
  max-width: 1400px;
  padding: 0 60px;
  padding-bottom: 20px;
}


  .sim-title {
  text-align: left;
  font-size: 28px;
  font-weight: 600;
  color: #ffffff;
  margin: 10px 0 20px 100px;
}

.sim-caption {
  margin-bottom: 0;
  padding-bottom: 0;
  line-height: 1.4;
}


  .sim-slider {
    display: flex;
    gap: 10px;
    overflow-x: auto;
    scroll-behavior: smooth;
    justify-content: flex-start;
    scrollbar-width: none;
   
  }

  .sim-slider::-webkit-scrollbar {
    display: none;
  }

  .sim-slide {
  
    flex: 0 0 auto;
    width: 200px;
    height: auto;
    background-color: transparent;
    box-shadow: none;
    margin-right: 12px;
  }

  .sim-slide img {

    width: 100%;
    height: auto;
    border-radius: 0;
  }

  .sim-prev,
  .sim-next {
  position: absolute;
  top: 50%;
  transform: translateY(-50%);
  background: none;        /* ✅ 배경 없애기 */
  color: #184fa1;          /* ✅ 화살표 색 */
  border: none;            /* ✅ 테두리 제거 */
  font-size: 24px;         /* ✅ 크기 키우고 */
  width: auto;             /* ✅ 너비 자동 */
  height: auto;            /* ✅ 높이 자동 */
  box-shadow: none;        /* ✅ 그림자 제거 */
  cursor: pointer;
  z-index: 10;
}


  .sim-prev { left: 0; }
  .sim-next { right: 0; }
  
.recommend-wrapper {
  display: flex;
  justify-content: center;
  margin-bottom: 80px;  /* ✅ footer와 간격 */
}

.recommend-slider {
  display: flex;
  gap: 20px;
  width: fit-content;
  margin: 0 auto;
  overflow-x: auto;
  scroll-behavior: smooth;
  scroll-snap-type: x mandatory;
  padding: 0;
  padding-bottom: 70px; /* ✅ 아래 패딩을 줘야 그림자 안 잘림 */
}

.recommend-slider::-webkit-scrollbar {
  display: none;
}

.recommend-slide {
  flex: 0 0 240px; /* 고정 너비로 카드 5개 정렬 */
  background: white;
  border-radius: 12px;
  box-shadow: 0 2px 6px rgba(0, 0, 0, 0.1);
  text-align: center;
  overflow: hidden;
  width:200px;
}

.recommend-slide img {
  width: 100%;
  height: 140px;
  object-fit: cover;
  
}

.recommend-slide p {
  margin: 10px;
  font-size: 15px;
  font-weight: 500;
  color: #333;
}





/* ✅ 반응형 */
@media (max-width: 1200px) {
  .recommend-slide {
    flex: 0 0 calc(25% - 16px); /* 4개 */
  }
}

@media (max-width: 900px) {
  .recommend-slide {
    flex: 0 0 calc(33.33% - 16px); /* 3개 */
  }
}

@media (max-width: 600px) {
  .recommend-slide {
    flex: 0 0 calc(50% - 16px); /* 2개 */
  }
}

@media (max-width: 400px) {
  .recommend-slide {
    flex: 0 0 100%; /* 1개 */
  }
}

  
</style>
</head>
<body>

  <section class="main-banner">
    <h1>여행을 떠나고 싶은 곳은?</h1>
    <p>나에게 딱 맞는 여행, 여기 있어요</p>
	<form action="mainsearch">
    <div class="search-box">
      <input type="text" placeholder="가고 싶은 곳을 검색해보세요." name="mainsearch">
      <button class="submit">
        <img src="${pageContext.request.contextPath}/image/dd.png" alt="검색">
      </button>
    </div>
    </form>
  </section>
  
  <!-- 카테고리 아이콘 섹션 -->
<div class="category-icons">
  <a href="flight" class="icon-item">
    <img src="${pageContext.request.contextPath}/image/flight.png" alt="항공권&숙박">
    <p>항공권&숙박</p>
  </a>
  <a href="countryout" class="icon-item">
    <img src="${pageContext.request.contextPath}/image/travel.png" alt="여행지">
    <p>여행지</p>
  </a>
  <a href="wifiout" class="icon-item">
    <img src="${pageContext.request.contextPath}/image/wifi.png" alt="와이파이">
    <p>와이파이</p>
  </a>

  <a href="packout" class="icon-item">
    <img src="${pageContext.request.contextPath}/image/package.png" alt="패키지">
    <p>패키지</p>
  </a>
  <a href="map" class="icon-item">
    <img src="${pageContext.request.contextPath}/image/map.png" alt="지도">
    <p>지도</p>
  </a>

  <a href="weather" class="icon-item">
    <img src="${pageContext.request.contextPath}/image/weather.png" alt="날씨">
    <p>날씨</p>
  </a>
</div>
<h2 style="text-align:left; font-size: 28px; font-weight: 600; margin: 40px 0 20px 100px;">
  어디로 떠나 볼까요?
</h2>

<div class="slider-wrapper">
    <button class="slider-btn prev-btn" onclick="prevSlide()">&#10094;</button>
    <div class="slider-container" id="slider">
      <a href="con?con=대한민국" class="slide"><img src="${pageContext.request.contextPath}/image/korea.png" alt="KOREA"></a>
      <a href="con?con=일본" class="slide"><img src="${pageContext.request.contextPath}/image/japan.png" alt="JAPAN"></a>
      <a href="con?con=중국" class="slide"><img src="${pageContext.request.contextPath}/image/china.png" alt="CHINA"></a>
      <a href="con?con=베트남" class="slide"><img src="${pageContext.request.contextPath}/image/vietnam.png" alt="VIETNAM"></a>
      <a href="con?con=호주" class="slide"><img src="${pageContext.request.contextPath}/image/australia.png" alt="AUSTRALIA"></a>
      <a href="con?con=미국" class="slide"><img src="${pageContext.request.contextPath}/image/usa.png" alt="USA"></a>
      <a href="con?con=영국" class="slide"><img src="${pageContext.request.contextPath}/image/england.png" alt="ENGLAND"></a>
      <a href="con?con=독일" class="slide"><img src="${pageContext.request.contextPath}/image/germany.png" alt="GERMANY"></a>
      <a href="con?con=프랑스" class="slide"><img src="${pageContext.request.contextPath}/image/france.png" alt="FRANCE"></a>
      <a href="con?con=뉴질랜드" class="slide"><img src="${pageContext.request.contextPath}/image/newzealand.png" alt="NEW ZEALAND"></a>
    </div>
    <button class="slider-btn next-btn" onclick="nextSlide()">&#10095;</button>
  </div>
<script>
  const slider = document.getElementById('slider');
  function nextSlide() {
    slider.scrollBy({ left: 320, behavior: 'smooth' });
  }
  function prevSlide() {
    slider.scrollBy({ left: -320, behavior: 'smooth' });
  }
</script>

<!-- 유심 추천 국가 슬라이드 -->
<div class="sim-slider-wrapper">

<h2 style="text-align:left; font-size: 28px; font-weight: 600; margig-bottom: 40px 0 20px 100px; color: #333;">
  국가별 유심
</h2>

  <div class="sim-slider" id="simSlider">
  <div class="sim-slide">
    <a href="wificountry?wificon=일본"><img src="./image/jsim4.png" alt="일본 유심"></a>
    <p class="sim-caption">일본 LTE/4G 유심<br>[인천.김포 공항 수령 가능]</p>
  </div>
  <div class="sim-slide">
    <a href="wificountry?wificon=호주"><img src="./image/osim4.png" alt="호주 유심"></a>
    <p class="sim-caption">호주 LTE/4G 유심<br>[인천.김포 공항 수령 가능]</p>
  </div>
  <div class="sim-slide">
    <a href="wificountry?wificon=중국"><img src="./image/csim4.png" alt="중국 유심"></a>
    <p class="sim-caption">중국 LTE/4G 유심<br>[인천.김포 공항 수령 가능]</p>
  </div>
  <div class="sim-slide">
    <a href="wificountry?wificon=미국"><img src="./image/asim4.png" alt="미국 유심"></a>
    <p class="sim-caption">미국 LTE/4G 유심<br>[인천.김포 공항 수령 가능]</p>
    
  </div>
  <div class="sim-slide">
    <a href="wificountry?wificon=베트남"><img src="./image/vsim4.png" alt="베트남 유심"></a>
    <p class="sim-caption">베트남 LTE/4G 유심<br>[인천.김포 공항 수령 가능]</p>
  </div>
  <div class="sim-slide">
    <a href="wificountry?wificon=영국"><img src="./image/esim4.png" alt="영국 유심"></a>
    <p class="sim-caption">영국 LTE/4G 유심<br>[인천.김포 공항 수령 가능]</p>
  </div>
  <div class="sim-slide">
    <a href="wificountry?wificon=독일"><img src="./image/gsim4.png" alt="독일 유심"></a>
    <p class="sim-caption">독일 LTE/4G 유심<br>[인천.김포 공항 수령 가능]</p>
  </div>
  <div class="sim-slide">
    <a href="wificountry?wificon=프랑스"><img src="./image/fsim4.png" alt="프랑스 유심"></a>
    <p class="sim-caption">프랑스 LTE/4G 유심<br>[인천.김포 공항 수령 가능]</p>
  </div>
  <div class="sim-slide">
    <a href="wificountry?wificon=뉴질랜드"><img src="./image/nsim4.png" alt="뉴질랜드 유심"></a>
    <p class="sim-caption">뉴질랜드 LTE/4G 유심<br>[인천.김포 공항 수령 가능]</p>
  </div>
  </div>
  <button class="sim-prev" onclick="prevSimSlide()">❮</button>
  <button class="sim-next" onclick="nextSimSlide()">❯</button>
</div>
   
  

<script>
const simSlider = document.getElementById('simSlider');
function nextSimSlide() {
  simSlider.scrollBy({ left: 220, behavior: 'smooth' });
}
function prevSimSlide() {
  simSlider.scrollBy({ left: -220, behavior: 'smooth' });
}
</script>

	<!-- ==========분기별 추천 여행지 ============== -->
	<div>
		 <h2 style="text-align: left; font-size: 28px; font-weight: 600; margin: 0px 0 10px 100px;">
		  <%= month %>월 추천 여행지
		</h2>
		<div class="recommend-slider" id="recommendSlider">
      <c:forEach items="${mon}" var="mon">
      <a href="countrydetail?countrynum=${mon.countrynum }">
       	<div class="recommend-slide"> 
          <img src="./image/${mon.tripimg}" width="여행지 이미지">
          <p>
          <c:choose>
          <c:when test="${fn:length(mon.tripname)>10}">
          ${mon.country}, ${fn:substring(mon.tripname,0,10)}...
          </c:when>
          <c:otherwise>
          ${mon.country}, ${mon.tripname}
          </c:otherwise>
          </c:choose>
          </p>
        </div>
        </a>
      </c:forEach>
    </div>
		
	</div>
	
	<section class="event-banner">
        <div id="myCarousel" class="carousel slide" data-ride="carousel">
            <ol class="carousel-indicators">
                <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
                <li data-target="#myCarousel" data-slide-to="1"></li>
                <li data-target="#myCarousel" data-slide-to="2"></li>
            </ol>
            <div class="carousel-inner">
                <div class="item active">
                    <img alt="배너이미지" src="./image/sb.png">
                </div>
                <div class="item">
                    <img alt="배너이미지2" src="./image/ontripb.png">
                </div>
                <div class="item">
                    <img alt="배너이미지3" src="./image/paris.png">
                </div>
            </div>
            <a class="left carousel-control" href="#myCarousel" data-slide="prev">
                <span class="glyphicon glyphicon-chevron-left"></span>
                <span class="sr-only">Previous</span>
            </a>
            <a class="right carousel-control" href="#myCarousel" data-slide="next">
                <span class="glyphicon glyphicon-chevron-right"></span>
                <span class="sr-only">Next</span>
            </a>
        </div>
    </section>


</body>
</html>