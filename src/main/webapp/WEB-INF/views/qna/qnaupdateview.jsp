<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<style type="text/css">
h2{
color: #1f2937;
  font-size: 28px;
  font-weight: 700;
}
</style>
  <meta charset="UTF-8">
  <title>Q&A</title>
</head>
<body>
<div class="container">
  <h2>문의글등록</h2>
  <form action="qnaupdatesave">
  <table class="table">
  	<input type="hidden" name="qnanum" value="${dto.qnanum }">
    <tbody>
      <tr>
      	<th>문의제목</th>
      	<td><input type="text" name="qnatitle" value="${dto.qnatitle }" required="required"></td>
      </tr>
      <tr>
      	<th>문의내용</th>
      	<td><input type="text" name="qnadetail" value="${dto.qnadetail }" required="required"></td>
      </tr>
      <tr>
      	<th>문의글PW</th>
      	<td>
      		<input type="password" name="qnapw" value="${dto.qnapw }" required="required">
      	</td>
      </tr>
      <tr>
      	<td colspan="2">
      	<c:if test="${loginstate==true }">
      		<input type="hidden" name="userid" value="${id }">
      	</c:if>
      		<button type="submit" class="btn btn-primary">저장</button>
      		<button type="button" class="btn btn-danger" onclick="location.href='qnaout'">취소</button>
      	</td>
      </tr>
    </tbody>
  </table>
  </form>
</div>
</body>
</html>
