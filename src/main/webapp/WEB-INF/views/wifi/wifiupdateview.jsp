<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>wifi 상품 수정</title>
<meta name="viewport" content="width=device-width, initial-scale=1">

<style>
    body {
        background-color: #f9fafb;
        font-family: 'Noto Sans KR', sans-serif;
        margin: 0;
        padding: 0;
    }
    .container {
        position: relative;
        max-width: 600px;
        margin: 50px auto;
        background: white;
        padding: 40px;
        border-radius: 20px;
        box-shadow: 0 4px 20px rgba(0,0,0,0.1);
    }
    h2 {
        text-align: center;
        color: #1f2937;
        font-size: 28px;
        font-weight: 700;
        margin-bottom: 30px;
    }
    .form-group {
        position: relative;
        margin-bottom: 30px;
    }
    .form-group label {
        position: absolute;
        top: -10px;
        left: 15px;
        background: white;
        padding: 0 5px;
        font-size: 13px;
        font-weight: bold;
        color: #374151;
    }
    .form-group input,
    .form-group select,
    .form-group textarea {
        width: 100%;
        padding: 15px;
        border: 1px solid #d1d5db;
        border-radius: 10px;
        font-size: 15px;
        outline: none;
        background-color: #f0f8ff;
    }
    .form-group input:focus,
    .form-group select:focus,
    .form-group textarea:focus {
        border-color: #3b82f6;
        box-shadow: 0 0 0 2px rgba(59,130,246,0.2);
    }
    .form-group input[type="file"] {
        padding: 12px;
        background: #f0f8ff; 
    }
    .preview-img {
        margin-top: 10px;
        max-width: 100%;
        border-radius: 8px;
        box-shadow: 0 2px 8px rgba(0,0,0,0.05);
    }
    .btn-group {
        text-align: center;
        margin-top: 30px;
    }
    .btn-group button {
        padding: 10px 30px;
        border: none;
        border-radius: 8px;
        font-size: 15px;
        font-weight: bold;
        cursor: pointer;
        transition: background 0.3s;
        margin: 0 5px;
        color: white;
    }
    .btn-submit {
        background: #3b82f6;
    }
    .btn-submit:hover {
        background: #2563eb;
    }
    .btn-cancel {
        background: #ef4444;
    }
    .btn-cancel:hover {
        background: #dc2626;
    }
    .close-btn {
        position: absolute;
        top: 20px;
        right: 20px;
        font-size: 20px;
        color: #6b7280;
        background: none;
        border: none;
        cursor: pointer;
        transition: color 0.2s;
    }
    .close-btn:hover {
        color: #374151;
    }
</style>
</head>
<body>

<div class="container">
<button type="button" class="close-btn" onclick="location.href='wifiout'">✕</button>
  <h2>wifi/e-sim 상품 수정</h2>
  <form action="wifiupdatesave" method="post" enctype="multipart/form-data">

    <div class="form-group">
      <label>상품명</label>
      <input type="text" name="wifiname" value="${dto.wifiname}" required>
    </div>

    <div class="form-group">
      <label>상품이미지</label>
      <input type="file" name="wifiimg">
      <input type="hidden" name="lastimg" value="${dto.wifiimg}">
      <img src="./image/${dto.wifiimg}" class="preview-img">
    </div>

    <div class="form-group">
      <label>상품설명</label>
      <input type="text" name="wifidetail" value="${dto.wifidetail}" required>
    </div>

    <div class="form-group">
      <label>상품링크</label>
      <input type="text" name="wifilink" value="${dto.wifilink}" required>
    </div>

    <div class="form-group">
      <label>국가</label>
      <input type="text" name="wificountry" value="${dto.wificountry}" required>
    </div>

    <div class="form-group">
      <label>일수</label>
      <input type="text" name="wifiday" value="${dto.wifiday}" required>
    </div>

    <input type="hidden" name="wifinum" value="${dto.wifinum}">

    <div class="btn-group">
      <button type="submit" class="btn-submit">수정</button>
    </div>
  </form>
</div>

</body>
</html>
