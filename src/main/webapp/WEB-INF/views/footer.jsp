<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>ONTRIP</title>
  <style>
/* footer 전체 */
#fot {
	background-color: #e0e0e0;
	color: #black;
	box-sizing: border-box;
	font-family: 'Malgun Gothic', Arial, sans-serif;
	padding: 20px 0;
}
/* 가운데 컨테이너 */
#fot .inner {
	width: 90%;
	max-width: 1200px;
	margin: 0 auto;
}

#fot .footer-top {
	display: flex;
	flex-direction: column;
	align-items: flex-start;
	padding-bottom: 1px;
	border-bottom: 1px solid rgba(255, 255, 255, 0.5);
}

#fot .footer-top img {
	height: 50px; /* ← 여기서 로고 키움 */
	width: auto;
}

#fot .footer-top nav {
	display: flex;
	gap: 24px;
	margin-top: 1px; /* 로고와 링크 사이 공간 */
	font-size: 14px;
	white-space: nowrap;
}

#fot .footer-top nav a {
	color: black;
	text-decoration: none;
}

#fot .footer-top nav a:hover {
	text-decoration: underline;
}

/* 하단: 사업자 정보 */
#fot .footer-info {
	display: grid;
	grid-template-columns: max-content auto; /* 라벨 칸 / 값 칸 */
	column-gap: 8px; /* 라벨과 값 사이 */
	row-gap: 4px; /* 항목 간 세로 간격 */
	margin-top: 8px; /* 링크 아래 여백 */
	font-size: 13px;
	line-height: 1.5;
	justify-items: start; /* 그리드 아이템 좌측 정렬 */
}

#fot .footer-info .label {
	text-align: left; /* 좌측 정렬로 변경 */
	opacity: 0.8;
	color: black;
}
</style>
</head>
<body>
  <!-- …페이지 다른 콘텐츠… -->

  <footer id="fot">
    <div class="inner">
      <div class="footer-top">
        <img src="${pageContext.request.contextPath}/image/ONTRIP.png" alt="ONTRIP 로고">
        <nav>
          <a href="#">이용약관</a>
          <a href="#">개인정보처리방침</a>
          <a href="#">이메일무단수집거부</a>
          <a href="#">사이트소개</a>
        </nav>
      </div>

      <div class="footer-info">
        <div class="label">상호명 :</div><div class="label">ONTRIP</div>
        <div class="label">주소  :</div><div class="label">경기도 수원시 팔달구</div>
        <div class="label">대표자 :</div><div class="label">대표자</div>
        <div class="label">사업자등록번호 :</div><div class="label">032-07292-12</div>
      </div>
    </div>
  </footer>
</body>
</html>
