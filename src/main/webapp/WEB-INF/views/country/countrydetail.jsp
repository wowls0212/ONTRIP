<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<!DOCTYPE html>
<html>
<head>
  <title>여행지 상세보기</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">

  <style>
    body {
      font-family: 'Noto Sans KR', sans-serif;
      background: #f4f6f9;

    }
    h2.title {
      text-align: center;
      color: #1f2937;
  font-size: 28px;
  font-weight: 700;
      margin-bottom: 40px;
    }
    .main-card {
      max-width: 1200px;
      margin: 0 auto 60px auto;
      background: #ffffff;
      border-radius: 30px;
      box-shadow: 0 14px 40px rgba(0,0,0,0.1);
      padding: 35px;
    }
    .row {
      display: flex;
      gap: 20px;
      margin-bottom: 30px;
    }
    .card-box {
      flex: 1;
      border-radius: 20px;
      box-shadow: 0 8px 24px rgba(0,0,0,0.08);
      overflow: hidden;
      position: relative;
    }
    .image-box img {
      width: 100%;
      height: 100%;
      object-fit: cover;
      display: block;
    }
    .info-box {
      background: #f0f4fa;
      padding: 30px;
      border-radius: 20px;
      text-align: left;
      display: flex;
      flex-direction: column;
      justify-content: space-between;
    }
    .info-content {
      display: flex;
      flex-direction: column;
      gap: 16px;
    }
    .info-box .item {
      font-size: 18px;
      color: #333;
    }
    .info-box .item strong {
      color: #184fa1;
      margin-right: 8px;
      font-weight: 700;
    }
    .map-btn {
      padding: 10px 20px;
      background: #3b82f6;
      color: white;
      border: none;
      border-radius: 8px;
      cursor: pointer;
      font-size: 14px;
      transition: background 0.3s;
      align-self: flex-start;
      margin-top: 20px;
    }
    .map-btn:hover {
      background: #2563eb;
    }
    .like-button {
      position: absolute;
      top: 20px;
      right: 20px;
      width: 60px;
      height: 60px;
      font-size: 28px;
      border: none;
      background: #fff;
      border-radius: 50%;
      box-shadow: 0 4px 12px rgba(0,0,0,0.1);
      cursor: pointer;
      transition: transform 0.2s;
      padding-bottom: 5px;
    }
    .like-button:hover {
      transform: scale(1.2);
    }
    .description-box {
      background: #f0f4fa;
      padding: 25px;
      border-radius: 20px;
      font-size: 16px;
      line-height: 1.7;
      color: #555;
      text-align: center;
    }
    .admin-buttons {
      display: flex;
      justify-content: center;
      gap: 15px;
      margin-top: 20px;
    }
    .admin-buttons button {
      padding: 10px 22px;
      font-size: 14px;
      border: none;
      border-radius: 8px;
      cursor: pointer;
      transition: all 0.2s;
    }
    .admin-buttons .edit {
      background: #3b82f6;
      color: white;
    }
    .admin-buttons .edit:hover {
      background: #2563eb;
    }
    .admin-buttons .delete {
      background: #ef4444;
      color: white;
    }
    .admin-buttons .delete:hover {
      background: #dc2626;
    }
    .modal-overlay {
      position: fixed;
      top: 0; left: 0;
      width: 100%; height: 100%;
      background: rgba(0,0,0,0.5);
      display: none;
      justify-content: center;
      align-items: center;
      z-index: 9999;
    }
    .modal-content {
      background: white;
      width: 600px;
      height: 400px;
      border-radius: 12px;
      overflow: hidden;
      position: relative;
      box-shadow: 0 6px 20px rgba(0,0,0,0.2);
    }
    .modal-close {
      position: absolute;
      top: 8px; right: 12px;
      font-size: 20px;
      color: #555;
      cursor: pointer;
      z-index: 10;
      pointer-events: auto;
    }
    #map {
      width: 100%;
      height: 100%;
    }
  </style>

  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <script>
    let liked = ${liked};

    function toggleLike(id, countrynum) {
      if (!id) {
        alert("로그인 후 이용할 수 있어요 😊");
        location.href = "/login";
        return;
      }

      if (liked) {
        $.ajax({
          url: 'deletelike',
          type: 'POST',
          data: { id: id, countrynum: countrynum },
          success: function () {
            liked = false;
            $('#likeBtn').html('<img src="./image/heart2.png" alt="좋아요 취소" width="30" height="30">');
          },
          error: function () {
            alert('좋아요 취소 중 오류가 발생했어요 😢');
          }
        });
      } else {
        $.ajax({
          url: 'conlike',
          type: 'POST',
          data: { id: id, countrynum: countrynum },
          success: function () {
            liked = true;
            $('#likeBtn').html('<img src="./image/heart1.png" alt="좋아요" width="30" height="30">');
          },
          error: function () {
            alert('좋아요 등록 중 오류가 발생했어요 😢');
          }
        });
      }
    }

    function showMap() {
      $(".modal-overlay").fadeIn(200, function(){
        initMap();
      });
    }

    function closeMap() {
      console.log("닫기 클릭됨");
      $(".modal-overlay").fadeOut(200, function(){
        $(this).css("display","none");
      });
    }

    function initMap() {
      var mapContainer = document.getElementById('map'),
      mapOption = {
        center: new kakao.maps.LatLng(${dto.lat}, ${dto.llong}),
        level: 3
      };
      var map = new kakao.maps.Map(mapContainer, mapOption);
      new kakao.maps.Marker({
        position: new kakao.maps.LatLng(${dto.lat}, ${dto.llong}),
        map: map
      });
      setTimeout(function(){
        kakao.maps.event.trigger(map, 'resize');
        map.setCenter(new kakao.maps.LatLng(${dto.lat}, ${dto.llong}));
      }, 100);
    }
  </script>
  <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=eb5666d215922badc1c86c7e82df8521"></script>
</head>

<body>
<h2 class="title">여행지 상세보기</h2>

<div class="main-card">
  <div class="row">
    <div class="card-box image-box">
      <img src="./image/${dto.tripimg}" alt="${dto.tripname}">
    </div>
    <div class="card-box info-box">
      <c:if test="${loginstate==true}">
        <button id="likeBtn" class="like-button" type="button"
          onclick="toggleLike('${id}', ${dto.countrynum})">
          <c:if test="${liked}"><img src="./image/heart1.png" alt="좋아요" width="30" height="30"></c:if>
          <c:if test="${!liked}"><img src="./image/heart2.png" alt="좋아요 취소" width="30" height="30"></c:if>
        </button>
      </c:if>
      <div class="info-content">
        <div class="item"><strong>국가</strong>${dto.country}</div>
        <div class="item"><strong>여행지</strong>${dto.tripname}</div>
        <div class="item"><strong>주소</strong>${dto.address}</div>
        <div class="item">
          <strong>여행스타일</strong>
          <c:if test="${dto.tripstyle=='activity'}"><span>액티비티</span></c:if>
          <c:if test="${dto.tripstyle=='food'}"><span>맛집탐방</span></c:if>
          <c:if test="${dto.tripstyle=='tourist'}"><span>관광지 탐방</span></c:if>
          <c:if test="${dto.tripstyle=='resort'}"><span>휴양지</span></c:if>
        </div>
        <div class="item">
          <strong>추천분기</strong>
          <c:if test="${dto.branch<=3}"><span>1분기</span></c:if>
          <c:if test="${dto.branch>=4 && dto.branch<=6}"><span>2분기</span></c:if>
          <c:if test="${dto.branch>=7 && dto.branch<=9}"><span>3분기</span></c:if>
          <c:if test="${dto.branch>=10}"><span>4분기</span></c:if>
        </div>
        <button class="map-btn" onclick="showMap()">지도 보기</button>
      </div>
    </div>
  </div>

  <div class="card-box description-box">${dto.tripdetail}</div>

  <c:if test="${loginstate==true && id=='admin'}">
    <div class="admin-buttons">
      <button type="button" class="edit"
        onclick="location.href='countryupdate?countrynum=${dto.countrynum}'">수정</button>
      <button type="button" class="delete"
        onclick="if(confirm('정말 삭제하시겠습니까?')) location.href='countrydelete?countrynum=${dto.countrynum}';">삭제</button>
    </div>
  </c:if>
</div>

<div class="modal-overlay">
  <div class="modal-content">
    <div class="modal-close" onclick="closeMap()">×</div>
    <div id="map"></div>
  </div>
</div>

</body>
</html>
