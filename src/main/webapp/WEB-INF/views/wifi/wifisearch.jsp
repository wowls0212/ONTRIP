<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>wifi/e-sim 상품 검색</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<style>
body {
  font-family: 'Noto Sans KR', sans-serif;
  background: #f9fafb;
  margin: 0;
  padding: 0;
}
h2 {
  text-align: center;
  color: #1f2937;
  font-size: 28px;
  font-weight: 700;
  margin: 50px 0 20px 0;
}
.container {
  max-width: 1000px;
  margin: 0 auto;
  background: white;
  border-radius: 15px;
  box-shadow: 0 4px 20px rgba(0,0,0,0.1);
  padding: 40px;
  margin-bottom: 50px;
}
.form-row {
  display: flex;
  align-items: center;
  padding: 20px 0;
  border-bottom: 1px solid #e5e7eb;
}
.form-row:last-child {
  border-bottom: none;
}
.form-label {
  width: 100px;
  font-size: 15px;
  font-weight: bold;
  color: #374151;
  margin-right: 20px;
}
.form-content {
  flex: 1;
  display: flex;
  flex-wrap: wrap;
  align-items: center;
  gap: 10px 20px;
}
label {
  font-size: 14px;
  color: #374151;
  display: inline-flex;
  align-items: center;
}
input[type="radio"] {
  accent-color: #3b82f6;
  margin-right: 5px;
}
label img.flag {
  width: 20px;
  height: 15px;
  margin-right: 5px;
  border-radius: 3px;
  box-shadow: 0 0 2px rgba(0,0,0,0.2);
}
button[type="submit"] {
  width: 100%;
  padding: 15px 0;
  border: none;
  border-radius: 10px;
  background: #3b82f6;
  color: white;
  font-size: 16px;
  font-weight: bold;
  cursor: pointer;
  transition: background 0.3s;
  margin-top: 30px;
}
button[type="submit"]:hover {
  background: #2563eb;
}
</style>
</head>
<body>

<h2>wifi/e-sim 상품 검색</h2>

<div class="container">
  <form action="wifisearch2">
    
    <div class="form-row">
      <div class="form-label">여행국가</div>
      <div class="form-content">
        <label><input type="radio" name="wificountry" value="대한민국"><img class="flag" src="https://flagcdn.com/w20/kr.png">대한민국</label>
        <label><input type="radio" name="wificountry" value="중국"><img class="flag" src="https://flagcdn.com/w20/cn.png">중국</label>
        <label><input type="radio" name="wificountry" value="일본"><img class="flag" src="https://flagcdn.com/w20/jp.png">일본</label>
        <label><input type="radio" name="wificountry" value="베트남"><img class="flag" src="https://flagcdn.com/w20/vn.png">베트남</label>
        <label><input type="radio" name="wificountry" value="호주"><img class="flag" src="https://flagcdn.com/w20/au.png">호주</label>
        <label><input type="radio" name="wificountry" value="미국"><img class="flag" src="https://flagcdn.com/w20/us.png">미국</label>
        <label><input type="radio" name="wificountry" value="영국"><img class="flag" src="https://flagcdn.com/w20/gb.png">영국</label>
        <label><input type="radio" name="wificountry" value="독일"><img class="flag" src="https://flagcdn.com/w20/de.png">독일</label>
        <label><input type="radio" name="wificountry" value="프랑스"><img class="flag" src="https://flagcdn.com/w20/fr.png">프랑스</label>
        <label><input type="radio" name="wificountry" value="뉴질랜드"><img class="flag" src="https://flagcdn.com/w20/nz.png">뉴질랜드</label>
      </div>
    </div>
    
    <div class="form-row">
      <div class="form-label">기간</div>
      <div class="form-content">
        <% for (int i=1; i<=10; i++) { %>
          <label><input type="radio" name="wifiday" value="<%=i%>"><%=i%>일</label>
        <% } %>
      </div>
    </div>

    <button type="submit">검색</button>
  </form>
</div>

</body>
</html>
