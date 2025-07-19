<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html>
<head>
  <title>날씨 앱</title>
  <style>
    body {
      font-family: 'Noto Sans KR', sans-serif;
      background-color: #f4f6f9;
      margin: 0;
      padding: 0;
    }

    .container {
      max-width: 480px;
      margin: 30px auto;
      background: white;
      border-radius: 16px;
      box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
      padding: 30px 20px;
    }

    h2 {
      color: #1f2937;
	  font-size: 28px;
	  font-weight: 700;
      margin-bottom: 20px;
    }

    form {
      display: flex;
      justify-content: center;
      margin-bottom: 25px;
    }

    input[type="text"] {
      padding: 10px;
      font-size: 16px;
      width: 65%;
      border: 1px solid #ccc;
      border-radius: 6px 0 0 6px;
      outline: none;
    }

    button {
      padding: 10px 18px;
      background-color: #184fa1;
      color: white;
      border: none;
      border-radius: 0 6px 6px 0;
      cursor: pointer;
    }

    .weather-layout-box {
      display: flex;
      background: #f1f5f9;
      border-radius: 16px;
      padding: 20px;
      box-shadow: 0 2px 8px rgba(0,0,0,0.08);
      align-items: center;
      justify-content: space-between;
      gap: 20px;
      flex-wrap: wrap;
      margin: 20px 0;
    }

    .weather-main {
      flex: 1 1 40%;
      text-align: center;
    }

    .weather-main .icon {
      font-size: 48px;
      margin-bottom: 10px;
    }

    .weather-main .temp {
      font-size: 24px;
      font-weight: bold;
      color: #184fa1;
    }

    .weather-main .status {
      font-size: 16px;
      color: #333;
    }

    .weather-info {
      flex: 1 1 55%;
      display: flex;
      flex-direction: column;
      gap: 10px;
      align-items: flex-start;
    }

    .info-item {
      font-size: 15px;
      background: transparent;
      padding: 0;
      box-shadow: none;
      color: #184fa1;
      text-align: left;
    }

    .forecast-title {
      font-size: 20px;
      font-weight: bold;
      margin-top: 30px;
      text-align: center;
    }

    .weather-slider {
      display: flex;
      overflow-x: auto;
      gap: 12px;
      padding: 10px 0;
      white-space: nowrap;
    }

    .weather-box {
      flex: 0 0 auto;
      background-color: #fff;
      border-radius: 12px;
      box-shadow: 0 2px 6px rgba(0,0,0,0.1);
      padding: 16px;
      width: 220px;
      font-size: 14px;
      display: flex;
      align-items: center;
      gap: 12px;
    }

    .weather-box .icon {
      font-size: 32px;
    }

    .icon-text-group {
      display: flex;
      flex-direction: column;
      align-items: flex-start;
    }

    .icon-text-group .date {
      font-weight: bold;
      font-size: 15px;
      margin-bottom: 4px;
      color: #184fa1;
    }

    .icon-text-group .temp,
    .icon-text-group .emoji {
      margin-bottom: 2px;
    }
    
  </style>
</head>
<body>
<%
  String statusText = "정보 없음";
  Object codeObj = request.getAttribute("weatherCodeNow");
  if (codeObj != null) {
    try {
      int code = Integer.parseInt(codeObj.toString());
      if (code == 0) statusText = "매운";
      else if (code <= 3) statusText = "흐림";
      else if (code >= 45 && code <= 48) statusText = "안개";
      else if (code >= 51 && code <= 67) statusText = "비";
      else if (code >= 71 && code <= 77) statusText = "눈";
      else if (code >= 80 && code <= 82) statusText = "소나기";
      else if (code >= 95) statusText = "날운";
    } catch (Exception e) {
      statusText = "정보 없음";
    }
  }

  String[] forecastStatus = null;
  Object codeList = request.getAttribute("weatherCodes");
  if (codeList != null && codeList instanceof java.util.List) {
    java.util.List codes = (java.util.List) codeList;
    forecastStatus = new String[codes.size()];
    for (int i = 0; i < codes.size(); i++) {
      try {
        int c = Integer.parseInt(codes.get(i).toString());
        if (c == 0) forecastStatus[i] = "매운";
        else if (c <= 3) forecastStatus[i] = "흐림";
        else if (c >= 45 && c <= 48) forecastStatus[i] = "안개";
        else if (c >= 51 && c <= 67) forecastStatus[i] = "비";
        else if (c >= 71 && c <= 77) forecastStatus[i] = "눈";
        else if (c >= 80 && c <= 82) forecastStatus[i] = "소나기";
        else if (c >= 95) forecastStatus[i] = "날운";
        else forecastStatus[i] = "정보 없음";
      } catch (Exception e) {
        forecastStatus[i] = "정보 없음";
      }
    }
    request.setAttribute("forecastStatus", forecastStatus);
  }
%>
<!-- 순서 : 맑음 / 흐림 / 안개 / 비 / 눈 / 소나기 / 뇌우 / 날씨 정보 없음 -->
<c:set var="emoji">
  <c:choose>
    <c:when test="${weatherCodeNow == 0}">☼</c:when> 
	<c:when test="${weatherCodeNow <= 3}">☁</c:when> 
	<c:when test="${weatherCodeNow >= 45 && weatherCodeNow <= 48}">〰</c:when> 
	<c:when test="${weatherCodeNow >= 51 && weatherCodeNow <= 67}">☂</c:when> 
	<c:when test="${weatherCodeNow >= 71 && weatherCodeNow <= 77}">❅</c:when> 
	<c:when test="${weatherCodeNow >= 80 && weatherCodeNow <= 82}">☂☼</c:when> 
	<c:when test="${weatherCodeNow >= 95}">⚡</c:when> 
	<c:otherwise>★</c:otherwise> 
  </c:choose>
</c:set>
<c:set var="flag">
	<c:choose>
		 <c:when test="${country == 'South Korea'}"><img class="flag" src="https://flagcdn.com/w20/kr.png" alt="South Korea" width="30px"></c:when>
		 <c:when test="${country == 'Japan'}"><img class="flag" src="https://flagcdn.com/w20/jp.png" alt="Japan" width="30px"></c:when>
		 <c:when test="${country == 'China'}"><img class="flag" src="https://flagcdn.com/w20/cn.png" alt="China" width="30px"></c:when>
		 <c:when test="${country == 'Vietnam'}"><img class="flag" src="https://flagcdn.com/w20/vn.png" alt="vietnam" width="30px"></c:when>
		 <c:when test="${country == 'Australia'}"><img class="flag" src="https://flagcdn.com/w20/au.png" alt="Australia" width="30px"></c:when>
		 <c:when test="${country == 'United States'}"><img class="flag" src="https://flagcdn.com/w20/us.png" alt="America" width="30px"></c:when>
		 <c:when test="${country == 'United Kingdom'}"><img class="flag" src="https://flagcdn.com/w20/gb.png" alt="UK" width="30px"></c:when>
		 <c:when test="${country == 'Germany'}"><img class="flag" src="https://flagcdn.com/w20/de.png" alt="Germany" width="30px"></c:when>
		 <c:when test="${country == 'France'}"><img class="flag" src="https://flagcdn.com/w20/fr.png" alt="France" width="30px"></c:when>
		 <c:when test="${country == 'New Zealand'}"><img class="flag" src="https://flagcdn.com/w20/nz.png" alt="New Zealand" width="30px"></c:when>
		 <c:otherwise>🌏</c:otherwise>
	</c:choose>
</c:set>
<h2> 날씨 보기</h2>
<div class="container">
  <form method="get" action="weather">
    <input type="text" name="city" placeholder="도시 입력 (예: Seoul)" value="${city}">
    <button type="submit">날씨 보기</button>
  </form>

  <c:if test="${not empty temperature}">
    <h3>${flag}  ${city}의 현재 날씨</h3>

    <div class="weather-layout-box">
      <div class="weather-main">
        <div class="icon">${emoji}</div>
        <div class="temp">${temperature}°C</div>
        <div class="status"><%= statusText %></div>
      </div>
      <div class="weather-info">
        <div class="info-item">🌬️ 풍속: ${windspeed} km/h</div>
        <div class="info-item">🕒 시간: ${timeFormatted}</div>
      </div>
    </div>
  </c:if>

  <c:if test="${not empty dates}">
    <h3 class="forecast-title">🗓 7일 예보</h3>
    <div class="weather-slider">
      <c:forEach var="i" begin="0" end="${fn:length(dates) - 1}">
        <div class="weather-box">
          <div class="icon">${emoji}</div>
          <div class="icon-text-group">
            <div class="date">${dates[i]}</div>
            <div class="temp">🌡️ ${minTemps[i]}°C ~ ${maxTemps[i]}°C</div>
            <div class="emoji">상태: ${forecastStatus[i]}</div>
          </div>
        </div>
      </c:forEach>
    </div>
  </c:if>
</div>
</body>

</html>
