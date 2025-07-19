<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>장소 지정 → 마커 + 거리 표시</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=eb5666d215922badc1c86c7e82df8521&libraries=services"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Sortable/1.15.0/Sortable.min.js"></script>

<style>
body {
  font-family: 'Noto Sans KR', sans-serif;
  background-color: #f6f9fc;
  margin: 0;
  padding: 0;
}
h2 {
  text-align: center;
  color: #1f2937;
  font-size: 28px;
  font-weight: 700;
  margin-bottom: 20px;
}
.container {
  display: flex;
  gap: 10px;
  width: calc(100% - 20px); /* 양쪽 끝 여백 20px + 20px */
  margin: 0 auto;
  padding: 0 10px;
  box-sizing: border-box;
  margin-bottom: 30px; /* ✅ 여기 추가 */
 } 
.map-wrapper {
  flex: none;
  width: 770px;
  height: 600px;
}
#map {
  width: 100%;
  height: 100%;
  border-radius: 12px;
  overflow: hidden;
  box-shadow: 0 2px 10px rgba(0,0,0,0.1);
}
.table-wrapper {
  flex: none;
  width: 700px;
  height: 600px;
  background: white;
  border-radius: 15px;
  padding: 20px;
  box-shadow: 0 2px 15px rgba(0,0,0,0.1);
  overflow-y: auto;
}
table {
  width: 100%;
  border-collapse: collapse;
}
thead {
  background-color: #f0f4fa;
}
th, td {
  padding: 12px 10px;
  text-align: center;
  font-size: 14px;
  border-bottom: 1px solid #e0e0e0;
  white-space: nowrap;
}
th {
  font-weight: 600;
  color: #184fa1;
}
td:nth-child(2) {
  font-weight: bold;
  color: #184fa1;
}
td:nth-child(3) {
  color: #d70000;
  font-weight: bold;
}
tr:hover {
  background-color: #f9fbff;
}
.search-wrapper {
  display: flex;
  justify-content: center;
  margin-bottom: 30px;
}
.search-form {
  display: flex;
  background: #ffffff;
  border: 1px solid #d0d7e2;
  border-radius: 12px;
  box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
  padding: 10px 15px;
  gap: 10px;
  align-items: center;
}
.search-form input[type="text"] {
  border: none;
  outline: none;
  font-size: 14px;
  padding: 10px 12px;
  border-radius: 8px;
  background-color: #f5f7fa;
  width: 180px;
}
.search-form button {
  background-color: #184fa1;
  color: white;
  border: none;
  padding: 10px 20px;
  font-size: 14px;
  font-weight: 500;
  border-radius: 8px;
  cursor: pointer;
  transition: background-color 0.2s ease;
}
.search-form button:hover {
  background-color: #143f85;
}
</style>
</head>
<body>

<h2>여행경로 짜기</h2>

<div class="search-wrapper">
  <form class="search-form" onsubmit="searchPlaces(); return false;">
    <input id="keyword" type="text" placeholder="장소를 입력하세요">
    <button type="submit">검색</button>
    <button type="button" onclick="clearMap()">초기화</button>
  </form>
</div>

<div class="container">
  <div class="map-wrapper">
    <div id="map"></div>
  </div>
  <div class="table-wrapper">
    <table id="searchResults">
      <thead>
        <tr>
          <th>순번</th>
          <th>장소명</th>
          <th>주소</th>
          <th>전화번호</th>
          <th>거리</th>
          <th>삭제</th>
        </tr>
      </thead>
      <tbody></tbody>
    </table>
  </div>
</div>

<script>
window.onload = function () {
     new Sortable(document.querySelector("#searchResults tbody"), {
       animation: 150,
       onEnd: reorderPathFromTable
     });

     const loginId = "<%= session.getAttribute("id") %>"; // JSP에서 세션 ID 전달

     window.onload = function () {

        // 👉 1. 테이블 드래그 기능 적용
        new Sortable(document.querySelector("#searchResults tbody"), {
          animation: 150,
          onEnd: reorderPathFromTable
        });

        // 👉 2. 세션에서 로그인 ID 받아오기
        const loginId = "<%= session.getAttribute("id") %>";

        // 👉 3. 저장된 장소 DB에서 불러오기
        $.ajax({
          url: "${pageContext.request.contextPath}/getPlaces",
          method: "GET",
          data: { userid: loginId },
          dataType: "json",
          success: function(data) {
            console.log("복원된 장소:", data);

            data.forEach((place, idx) => {
              const latlng = new kakao.maps.LatLng(place.lat, place.lng);
              restorePlace(latlng, place, idx + 1);
            });
          },
          error: function(xhr) {
            console.error("장소 복원 실패 ❌", xhr);
          }
        });

      };

        // 마커 클릭 시 정보창
        kakao.maps.event.addListener(marker, 'click', function () {
          if (currentOverlay) currentOverlay.setMap(null);
          const content = `
            <div style="position:relative; padding:10px; background:white; border:1px solid #ccc; border-radius:8px;">
              <div style="position:absolute; top:6px; right:8px; cursor:pointer;" onclick="this.parentElement.parentElement.remove(); currentOverlay=null;">❌</div>
              <div style="font-weight:bold;">${place.placename}</div>
              <div>${place.address}</div>
              <div>${place.phone || ''}</div>
            </div>`;
          currentOverlay = new kakao.maps.CustomOverlay({
            content, position: latlng, yAnchor: 1.6, zIndex: 20
          });
          currentOverlay.setMap(map);
        });

        // 순번 커스텀 마커
        const markerHtml = `<div style="width:40px;height:40px;background:#0076ff;color:white;border-radius:50%;text-align:center;line-height:40px;font-weight:bold;">${index}</div>`;
        const customMarker = new kakao.maps.CustomOverlay({
          content: markerHtml, position: latlng, yAnchor: 1.45, zIndex: 10
        });
        customMarker.setMap(map);
        overlays.push(customMarker);

        // 테이블 행 추가
        const row = document.querySelector("#searchResults tbody").insertRow();
        row.setAttribute("data-lat", latlng.getLat());
        row.setAttribute("data-lng", latlng.getLng());

        let distanceText = "-";
        if (positions.length >= 2) {
          const dist = new kakao.maps.Polyline({ path: [positions[positions.length - 2], latlng] }).getLength();
          distanceText = Math.round(dist).toLocaleString() + "m";
        }

        row.innerHTML = `
          <td>${index}</td>
          <td>${place.placename}</td>
          <td>${place.address}</td>
          <td>${place.phone || ''}</td>
          <td>${distanceText}</td>
          <td><button onclick="deletePlace(this, '${place.placename}')">삭제</button></td>`;

        polyline.setPath(positions);
      }
let currentOverlay = null;
var map = new kakao.maps.Map(document.getElementById('map'), {
    center: new kakao.maps.LatLng(37.5665, 126.9780),
    level: 5
});
var places = new kakao.maps.services.Places();
var markers = [];
var positions = [];
var overlays = [];
var polyline = new kakao.maps.Polyline({
    map: map,
    path: [],
    strokeWeight: 4,
    strokeColor: '#184fa1',
    strokeOpacity: 0.8,
    strokeStyle: 'dashed'
});
function searchPlaces() {
    const keyword = document.getElementById('keyword').value.trim();
    if (!keyword) {
      alert("검색어를 입력하세요.");
      return;
    }
    document.getElementById('keyword').value = "";
    places.keywordSearch(keyword, placesSearchCB);
}
function clearMap() {
    markers.forEach(m => m.setMap(null));
    markers = [];
    overlays.forEach(o => o.setMap(null));
    overlays = [];
    polyline.setPath([]);
    positions = [];
    map.setLevel(5);
    map.setCenter(new kakao.maps.LatLng(37.5665, 126.9780));
    document.querySelector("#searchResults tbody").innerHTML = "";
}
function placesSearchCB(data, status) {
    if (status === kakao.maps.services.Status.OK) {
        let place = data[0];
        let latlng = new kakao.maps.LatLng(place.y, place.x);
        addPlace(latlng, place);
        map.panTo(latlng);
    } else {
        alert("장소를 찾을 수 없습니다.");
    }
}
function addPlace(latlng, place) {
    let marker = new kakao.maps.Marker({ map: map, position: latlng });
    marker.place_name = place.place_name;
    marker.latlng = latlng;
    markers.push(marker);
    positions.push(latlng);

    kakao.maps.event.addListener(marker, 'click', function () {
        if (currentOverlay) currentOverlay.setMap(null);
        const kakaoLink = "https://map.kakao.com/link/search/" + encodeURIComponent(place.place_name);
        const content =
          '<div style="position:relative; padding:10px 12px; border:1px solid #ccc; border-radius:8px; background:white; box-shadow:0 2px 8px rgba(0,0,0,0.2); font-size:14px;">' +
          '<div style="position:absolute; top:6px; right:8px; cursor:pointer; font-weight:bold; font-size:16px;" onclick="this.parentElement.parentElement.remove(); currentOverlay=null;">❌</div>' +
          '<div style="font-weight:bold; font-size:15px;">' + place.place_name + '</div>' +
          '<div>' + place.address_name + '</div>' +
          '<div>' + (place.phone ? '📞 ' + place.phone : '') + '</div>' +
          '<div style="margin-top:8px;"><a href="' + kakaoLink + '" target="_blank" style="color:#0076ff; text-decoration:underline;">리뷰 바로가기</a></div>' +
          '</div>';
        const infoOverlay = new kakao.maps.CustomOverlay({
            content: content,
            position: latlng,
            yAnchor: 1.6,
            zIndex: 20
        });
        infoOverlay.setMap(map);
        currentOverlay = infoOverlay;
    });

    let index = positions.length;
    let markerHtml = '<div style="width:40px;height:40px;background:#0076ff;color:white;border-radius:50%;text-align:center;line-height:40px;font-weight:bold;font-size:16px;">' + index + '</div>';
    let customMarker = new kakao.maps.CustomOverlay({
      content: markerHtml,
      position: latlng,
      yAnchor: 1.45,
      zIndex: 10
    });
    customMarker.setMap(map);
    overlays.push(customMarker);

    const table = document.getElementById("searchResults").getElementsByTagName('tbody')[0];
    const row = table.insertRow();
    row.setAttribute("data-lat", latlng.getLat());
    row.setAttribute("data-lng", latlng.getLng());

    let distanceText = "-";
    if (positions.length >= 2) {
      const i = positions.length - 1;
      const dist = new kakao.maps.Polyline({ path: [positions[i - 1], positions[i]] }).getLength();
      distanceText = Math.round(dist).toLocaleString() + "m";
    }

    row.innerHTML = '<td>' + index + '</td>' +
                    '<td>' + place.place_name + '</td>' +
                    '<td>' + place.address_name + '</td>' +
                    '<td>' + (place.phone || '') + '</td>' +
                    '<td>' + distanceText + '</td>' +
                    '<td><button onclick="deletePlace(this, \'' + place.place_name + '\')">삭제</button></td>';
    polyline.setPath(positions);
    
    const loginId = "<%= session.getAttribute("id") %>";

    $.post("${pageContext.request.contextPath}/addplace", {
      placename: place.place_name,
      address: place.address_name,
      phone: place.phone,
      lat: latlng.getLat(),
      lng: latlng.getLng(),
      placeorder: index
    });

}
function restorePlace(latlng, place, index) {
     let marker = new kakao.maps.Marker({ map: map, position: latlng });
     marker.place_name = place.placename;
     marker.latlng = latlng;
     markers.push(marker);
     positions.push(latlng);

     // 마커 클릭 시 정보창
     kakao.maps.event.addListener(marker, 'click', function () {
       if (currentOverlay) currentOverlay.setMap(null);
       const content = `
         <div style="position:relative; padding:10px; background:white; border:1px solid #ccc; border-radius:8px;">
           <div style="position:absolute; top:6px; right:8px; cursor:pointer;" onclick="this.parentElement.parentElement.remove(); currentOverlay=null;">❌</div>
           <div style="font-weight:bold;">${place.placename}</div>
           <div>${place.address}</div>
           <div>${place.phone || ''}</div>
         </div>`;
       currentOverlay = new kakao.maps.CustomOverlay({
         content,
         position: latlng,
         yAnchor: 1.6,
         zIndex: 20
       });
       currentOverlay.setMap(map);
     });

     // 순번 커스텀 마커
     const markerHtml = `<div style="width:40px;height:40px;background:#0076ff;color:white;border-radius:50%;text-align:center;line-height:40px;font-weight:bold;">${index}</div>`;
     const customMarker = new kakao.maps.CustomOverlay({
       content: markerHtml,
       position: latlng,
       yAnchor: 1.45,
       zIndex: 10
     });
     customMarker.setMap(map);
     overlays.push(customMarker);

     // 테이블 행 추가
     const row = document.querySelector("#searchResults tbody").insertRow();
     row.setAttribute("data-lat", latlng.getLat());
     row.setAttribute("data-lng", latlng.getLng());

     let distanceText = "-";
     if (positions.length >= 2) {
       const dist = new kakao.maps.Polyline({
         path: [positions[positions.length - 2], latlng]
       }).getLength();
       distanceText = Math.round(dist).toLocaleString() + "m";
     }

     row.innerHTML = `
       <td>${index}</td>
       <td>${place.placename}</td>
       <td>${place.address}</td>
       <td>${place.phone || ''}</td>
       <td>${distanceText}</td>
       <td><button onclick="deletePlace(this, '${place.placename}')">삭제</button></td>
     `;

     polyline.setPath(positions);
   }
function reorderPathFromTable() {
     const rows = document.querySelectorAll("#searchResults tbody tr");
     const newPositions = [];
     overlays.forEach(o => o.setMap(null));
     overlays = [];

     rows.forEach((row, idx) => {
       const latlng = new kakao.maps.LatLng(
         parseFloat(row.getAttribute("data-lat")),
         parseFloat(row.getAttribute("data-lng"))
       );
       newPositions.push(latlng);
       row.cells[0].textContent = idx + 1;

       // 거리 계산
       let distanceText = "-";
       if (idx >= 1) {
         const dist = new kakao.maps.Polyline({
           path: [newPositions[idx - 1], latlng]
         }).getLength();
         distanceText = Math.round(dist).toLocaleString() + "m";
       }
       row.cells[4].textContent = distanceText; // 5번째 셀에 거리 갱신

       // 마커 재생성
       const markerHtml =
         '<div style="width:40px;height:40px;background:#0076ff;color:white;border-radius:50%;text-align:center;line-height:40px;font-weight:bold;font-size:16px;">' +
         (idx + 1) +
         '</div>';
       const customMarker = new kakao.maps.CustomOverlay({
         content: markerHtml,
         position: latlng,
         yAnchor: 1.45,
         zIndex: 10
       });
       customMarker.setMap(map);
       overlays.push(customMarker);
     });

     positions = [...newPositions];
     polyline.setPath(positions);
   }
function deletePlace(button, placeName) {
  const row = button.closest("tr");
  row.remove();
  const index = markers.findIndex(m => m.place_name === placeName);
  if (index !== -1) {
    markers[index].setMap(null);
    markers.splice(index, 1);
    positions.splice(index, 1);
    overlays[index].setMap(null);
    overlays.splice(index, 1);
  }
  reorderPathFromTable();
}
</script>
</body>
</html>
