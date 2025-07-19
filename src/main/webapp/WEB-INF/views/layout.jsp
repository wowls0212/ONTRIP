<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="t" %>
<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<title><t:insertAttribute name="title"/></title>
<style type="text/css">

header
{
   text-align: center;
   width: 100%;
}
nav
{
      
}
#top
{
   
}
#body
{
   text-align: center;
   width: 100%;
}
body {
  cursor: url('./image/cloudblue.png'), auto;
}

body:active, html:active {
  cursor: url('./image/cloud.png'), auto;
}

button, a, .box, .icon-item {
  cursor: url('./image/cloud.png'), auto;
  transition: background-color 0.3s, transform 0.2s;
}

button:hover, a:hover, .box:hover, .icon-item:hover {
  cursor: url('./image/cloud.png'), auto;
}

button:active, a:active, .box:active, .icon-item:active {
  background-color: #cce7ff;
  transform: scale(0.97);
  cursor: url('./image/cloud.png'), auto;
}
#footer
{
   position: inherit;
   bottom: 0px;
   width: 100%;
   text-align: center;
   font-size: 15px;
   line-height: 30px;
   background-color: #000000;
   color: #ffffff; 
}
</style>
</head>
<body>
 <!-- 공통 알림 메시지 (회원가입/수정/삭제 등 완료 후 alert 창 띄움) -->
  <c:if test="${not empty sessionScope.msg}">
    <script>
      alert("${sessionScope.msg}");
    </script>
    <c:remove var="msg" scope="session" /> <!--  메시지 한 번 출력 후 제거 -->
  </c:if>


  <div id="top">
        <jsp:include page="/WEB-INF/views/top.jsp" />
  </div>
      <div id="body">
         <t:insertAttribute name="body"/>
                  <script>
         let moveCount = 0;

         document.addEventListener('mousemove', function(e) {
           moveCount++;
           if (moveCount % 5 !== 0) return;  

           const circle = document.createElement('div');
           circle.style.position = 'fixed';
           circle.style.left = (e.clientX - 5) + 'px';
           circle.style.top = (e.clientY - 5) + 'px';
           circle.style.width = '24px';
           circle.style.height = '24px';
           circle.style.backgroundImage = 'url("./image/cloudblue.png")';
           circle.style.backgroundSize = 'cover';
           circle.style.backgroundRepeat = 'no-repeat';
           circle.style.pointerEvents = 'none';
           circle.style.opacity = '0.8';
           circle.style.transition = 'transform 0.8s ease, opacity 1s ease';
           document.body.appendChild(circle);

           setTimeout(() => {
             circle.style.transform = 'scale(1.5)';
             circle.style.opacity = '0';
             setTimeout(() => circle.remove(), 1000);
           }, 10);
         });

</script>
      </div>
      <div id="footer">
         <t:insertAttribute name="footer"/>
      </div>	
</body>
</html>