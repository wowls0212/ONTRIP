	<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<!DOCTYPE html>
<html>
<head>
<style type="text/css">
header{
text-align: center;
background-color : white;
background-image: url("./image/spring.jpg");
background-repeat: no-repeat;
background-position:center;
background-size:contain;
padding: 200px;
margin: 0;
width: 1800px;
height: 400px;
font-size: 3em;
font-style: italic;
}


#logo-container {
  display: flex;
  align-items: center;
  justify-content: center;
  background-color: white;
  padding: 20px;
  gap: 1px;

}

#logo-container img {
  height: 80px;
  object-fit: contain;
  cursor: pointer;
}

#plane-container {
  width: 40px;
  height: 80px;
  position: relative;
}

#plane {
  position: absolute;
  top: 0;
  left: 0;
  transition: transform 1s ease-out;
  z-index: 2;
  margin-top: 15px;
}

.navbar-inverse {
  background-color: #ffffff !important;
  border-color: #e0e0e0 !important;
  margin-bottom: 0 !important;
}

.navbar-inverse .navbar-nav > li > a,
.navbar-inverse .navbar-brand {
  color: #000000 !important;
  font-size: 15px !important;
}

.navbar-inverse .navbar-nav > li:hover > a,
.navbar-inverse .navbar-nav > li > a:hover,
.navbar-inverse .navbar-nav > li > a:focus {
  background-color: #184fa1 !important;
  color: #ffffff !important;
}

.navbar-inverse .navbar-nav > .active > a,
.navbar-inverse .navbar-nav > .active > a:hover,
.navbar-inverse .navbar-nav > .active > a:focus {
  background-color: #ffffff !important;
  padding: 0;
}
#menu-wrap {
  position: absolute;
  top: 8px;
  right: 20px;
  animation: float 3s ease-in-out infinite;
  z-index: 1000;
}
#menu-button {
  background: none;
  border: none;
  padding: 0;
  cursor: pointer;
}
#menu-button img {
  width: 72px;
  height: 72px;
  transition: transform 0.5s ease;
}
#menu-button.hover-carry img {
  transform: scale(1.5) translateX(-130px);
}
@keyframes float {
  0% { transform: translateY(0px); }
  50% { transform: translateY(-6px); }
  100% { transform: translateY(0px); }
}
#carrier {
  font-size: 28px;
  transition: transform 0.4s ease;
}

@keyframes cloudFloat {
  0%, 100% { transform: translateY(0px); }
  50% { transform: translateY(-10px); }
}
#sidebar {
  position: fixed;
  top: 100px;
  right: -500px;
  width: 400px;
  height: 400px;
  background: radial-gradient(circle at 30% 30%, rgba(220,250,245,0.95), rgba(180,220,255,0.9), rgba(255,255,255,0.9));
  -webkit-mask-image: url('./image/side.png');
  mask-image: url('./image/side.png');
  -webkit-mask-size: cover;
  mask-size: cover;
  -webkit-mask-repeat: no-repeat;
  mask-repeat: no-repeat;
  -webkit-mask-position: center;
  mask-position: center;
  box-shadow: 
    0 0 50px rgba(0,0,0,0.3),
    inset 0 0 40px rgba(255,255,255,0.6);
  border: 6px solid transparent;
  border-image: linear-gradient(60deg, rgba(180,250,255,0.8), rgba(255,255,255,0.8)) 1;
  transition: right 0.5s ease;
  padding: 100px 50px 50px 50px; /* 위 padding 늘림 */
  box-sizing: border-box;
  z-index: 999;
  animation: cloudFloat 4s ease-in-out infinite;
}
#sidebar h3 {
  text-align: center;
  font-size: 24px;
  margin-bottom: 20px;
}
#sidebar ul {
  list-style: none;
  padding: 0;
}
#sidebar li {
  margin: 20px 0;
  text-align: center;
}
#sidebar a {
  color: #333;
  text-decoration: none;
  font-weight: bold;
  font-size: 18px;
  text-shadow: 1px 1px 2px rgba(255,255,255,0.9);
  display: inline-block; /* transform이 텍스트에 잘 적용되도록 */
  transition: color 0.4s ease, transform 0.4s ease;
}
#sidebar a:hover {
  color: #184fa1;
  transform: scale(1.3);
  text-decoration: none;
}

</style>

  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

   <div id="logo-container">
   <div id="logo-box">
   <c:choose>
   	<c:when test="${loginstate==true }">
     <a href="main"><img src="${pageContext.request.contextPath}/image/ONTRIP1.png" alt="ONTRIP 로고" id="logo-image"></a>
     </c:when>
     <c:otherwise>
     <a href="logoutmain"><img src="${pageContext.request.contextPath}/image/ONTRIP1.png" alt="ONTRIP 로고" id="logo-image"></a>
     </c:otherwise>
   </c:choose>
   </div>
  <div id="plane-container">
    <canvas id="path-canvas" width="40" height="80"></canvas>
    <img id="plane" src="./image/fly.png" width="48" height="48">
  </div>
</div>
<script>
const plane = document.getElementById('plane');
const logo = document.getElementById('logo-image');

logo.addEventListener('mouseenter', () => {
  plane.style.transform = 'translate(200px, -200px) rotate(-45deg)';
});

logo.addEventListener('mouseleave', () => {
  plane.style.transform = 'translate(0px, 0px) rotate(0deg)';
});

$(document).ready(function(){
	  $("#menu-button").mouseenter(function(){
	    $("#carrier").css("transform", "translateX(-40px)");
	  });

	  $("#menu-button").mouseleave(function(){
	    $("#carrier").css("transform", "translateX(0)");
	  });
	});
$(document).ready(function(){
	  $("#menu-button").mouseenter(function(){
	    $("#sidebar").css("right", "0");
	  });

	  $("#sidebar").mouseleave(function(){
	    $("#sidebar").css("right", "-250px");
	  });
	});

$(document).ready(function(){
	  let keepSidebarOpen = false;

	  $("#menu-button").hover(
	    function() {
	      keepSidebarOpen = true;
	      $("#menu-img").attr("src", "./image/carry.png");
	      $("#menu-button").addClass("hover-carry");
	      $("#sidebar").css("right", "0");
	    },
	    function() {
	      if (!keepSidebarOpen) closeSidebar();
	    }
	  );

	  $("#sidebar").hover(
	    function() {
	      keepSidebarOpen = true;
	      $(this).css("right", "0");
	    },
	    function() {
	      keepSidebarOpen = false;
	      closeSidebar();
	    }
	  );

	  function closeSidebar(){
	    $("#menu-img").attr("src", "./image/bag.png");
	    $("#menu-button").removeClass("hover-carry");
	    $("#sidebar").css("right", "-500px");
	  }
	});
</script>
<nav class="navbar navbar-inverse">
  <div class="container-fluid">
    <ul class="nav navbar-nav">
    <c:choose>
    	<c:when test="${loginstate==true }">
      <li class="active"><a href="main"><img alt="로그인홈" src="./image/로그인상태.png" width="48px" height="48px"></a></li>
      </c:when>
      <c:otherwise>
      	<li class="active"><a href="logoutmain"><img alt="비로그인홈" src="./image/비로그인상태.png" width="48px" height="48px"></a></li>
      </c:otherwise>
    </c:choose>
    <c:if test="${id=='admin'&&loginstate==true }">
          <li><a href="userout">회원 관리</a></li>
      </c:if>
      <c:choose>
      	<c:when test="${id=='admin'&&loginstate==true }">
      <li class="dropdown"><a class="dropdown-toggle" data-toggle="dropdown" href="#">wifi/e-sim <span class="caret"></span></a>
        <ul class="dropdown-menu">
          <li><a href="wifiinput">wifi/e-sim 상품 등록</a></li>
          <li><a href="wifiout">wifi/e-sim 상품 목록</a></li>
          <li><a href="wifisearch">wifi/e-sim 상품 검색</a></li>
        </ul>
      </li>
      </c:when>
      <c:otherwise>
      <li class="dropdown"><a class="dropdown-toggle" data-toggle="dropdown" href="#">wifi/e-sim <span class="caret"></span></a>
        <ul class="dropdown-menu">
          <li><a href="wifiout">wifi/e-sim 상품 목록</a></li>
          <li><a href="wifisearch">wifi/e-sim 상품 검색</a></li>
        </ul>
      </li>
      </c:otherwise>
      </c:choose>
      <c:choose>
      	<c:when test="${id=='admin'&&loginstate==true }">
      <li class="dropdown"><a class="dropdown-toggle" data-toggle="dropdown" href="#">패키지 <span class="caret"></span></a>
        <ul class="dropdown-menu" >
          <li><a href="packinput"><span>패키지 상품 등록</span></a></li>
          <li><a href="packout">패키지 상품 목록</a></li>
          <li><a href="packsearch">패키지 상품 검색</a></li>
        </ul>
      </li>
      </c:when>
      <c:otherwise>
      <li class="dropdown"><a class="dropdown-toggle" data-toggle="dropdown" href="#">패키지 <span class="caret"></span></a>
        <ul class="dropdown-menu" >
          <li><a href="packout">패키지 상품 목록</a></li>
          <li><a href="packsearch">패키지 상품 검색</a></li>
        </ul>
      </li>
      </c:otherwise>
      </c:choose>
      <c:choose>
      	<c:when test="${id=='admin'&&loginstate==true }">
      <li class="dropdown"><a class="dropdown-toggle" data-toggle="dropdown" href="#">여행지 <span class="caret"></span></a>
        <ul class="dropdown-menu">
          <li><a href="countryinput">여행지 등록</a></li>
          <li><a href="countryout">여행지 목록</a></li>
        </ul>
      </li>
      </c:when>
      <c:otherwise>
      <li class="dropdown"><a class="dropdown-toggle" data-toggle="dropdown" href="#">여행지 <span class="caret"></span></a>
        <ul class="dropdown-menu">
          <li><a href="countryout">여행지 목록</a></li>
        </ul>
      </li>
      </c:otherwise>
      </c:choose>
      <c:choose>
      	<c:when test="${loginstate==true }">
      <li class="dropdown"><a class="dropdown-toggle" data-toggle="dropdown" href="#">문의글 <span class="caret"></span></a>
        <ul class="dropdown-menu">
          <li><a href="qnainput">문의글 등록</a></li>
          <li><a href="qnaout">문의글 목록</a></li>
        </ul>
      </li>
      </c:when>
      </c:choose>
          <li><a href="weather">날씨보기</a></li>

          <li><a href="map">여행 경로짜기</a></li>

          <li><a href="flight">항공권</a></li>


          <li><a href="hotel">호텔</a></li>

    </ul>
  </div>
<div id="menu-wrap">
  <button id="menu-button"><img id="menu-img" src="./image/bag.png" alt="가방"></button>
</div>

<div id="sidebar">
  <ul>
    <c:choose>
      <c:when test="${loginstate==true}">
        <li><a href="mypage?id=${id}">마이페이지</a></li>
        <li><a href="likepage?id=${id}">좋아요</a></li>
        <li><a href="myqna?id=${id}">내 문의글</a></li>
        <li><a href="logout">로그아웃</a></li>
      </c:when>
      <c:otherwise>
        <li><a href="#"></a></li>
        <li><a href="userinput">회원가입</a></li>
        <li><a href="login">로그인</a></li>
      </c:otherwise>
    </c:choose>
  </ul>
</div>
</nav>
</body>
</html>