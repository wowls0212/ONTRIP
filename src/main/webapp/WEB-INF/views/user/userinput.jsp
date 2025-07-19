<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <title>회원가입</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
	  <style>
    body {
      font-family: 'Noto Sans KR', sans-serif;
      background-color: #f7f9fc;
      margin: 0;
      padding: 0;
    }

    .outer-wrapper {
      padding: 60px 0;
      display: flex;
      justify-content: center;
    }

    .container {
      max-width: 500px;
      width: 90%;
      margin: 0 auto;
      padding: 40px;
      background-color: white;
      border-radius: 20px;
      box-shadow: 0 8px 20px rgba(0, 0, 0, 0.08);
    }

    h2 {
      text-align: center;
      color: #1f2937;
  font-size: 28px;
  font-weight: 700;
    }

    .table {
      width: 100%;
      border-collapse: collapse;
    }

    .table th {
      text-align: left;
      padding: 12px 0;
      font-size: 15px;
    }

    .table td {
      padding: 8px 0;
    }

    input[type="text"],
    input[type="password"],
    input[type="date"],
    select {
      width: 100%;
      padding: 12px;
      border: 1px solid #ccc;
      border-radius: 12px;
      box-sizing: border-box;
      font-size: 14px;
    }

    .input-with-button {
      position: relative;
    }

    .input-with-button input[type="text"] {
      padding-right: 100px;
    }

    .input-with-button button {
      position: absolute;
      right: 5px;
      top: 50%;
      transform: translateY(-50%);
      background-color: #184fa1;
      color: #fff;
      border: none;
      padding: 10px 18px;
      border-radius: 24px;
      font-weight: bold;
      cursor: pointer;
    }

    .btn {
      font-size: 16px;
      font-weight: bold;
      padding: 12px 28px;
      border-radius: 24px;
      margin: 8px 8px 0;
      cursor: pointer;
      border: none;
    }

    .btn-primary {
      background-color: #8BC34A;
      color: #fff;
    }

    .btn-primary:hover {
      background-color: #8BC34A;
      border-color: #10387a;
    }

    .btn-danger {
      background-color: #f8f9fa;
      color: #000;
    }

    .btn-danger:hover {
      background-color: #e0e0e0;
      border-color: #b52b27;
    }
    .btn-confirm {
    	background: #184fa1;
      color: #ffffff; }
      .btn-user, .btn-admin {
  background-color: #f0f0f0;
  color: #333!important;
  border: none;
  padding: 10px 18px;
  border-radius: 8px;
  cursor: pointer;
  margin-right: 10px;
  transition: all 0.3s ease;
}
.btn-selected {
  background-color: #8BC34A!important; 
  color: white !important;
}
.btn-user:hover, .btn-admin:hover
      
  </style>
	
	<script>
	function selectUser(type) {
		  document.getElementById('role').value = type;

		  const adminRow = document.getElementById("adminPasswordRow");
		  if (type === 'admin') {
		    adminRow.style.display = 'table-row';
		  } else {
		    adminRow.style.display = 'none';
		  }

		  document.querySelectorAll('.btn-user, .btn-admin').forEach(btn => {
		    btn.classList.remove('btn-selected');
		  });
		  if (type === 'user') {
		    document.querySelector('.btn-user').classList.add('btn-selected');
		  } else {
		    document.querySelector('.btn-admin').classList.add('btn-selected');
		  }
		}
	 $(function(){
		 $("#idcheck").click(function(){
		        var id=$("#id").val();
		        $.post("idcheck2",{id},function(res){
		          alert(res==="ok"?"사용가능 ID입니다.":"이미 사용중인 ID입니다.");
		        });
		      });
	 		});
 
</script>
	
</head>
<body>
<div class="container">
  <h2>회원가입</h2>
  <form action="usersave" method="post">
  <table class="table">
    <tbody>
    <tr>
    	<td colspan="2">
    		<button type="button" class="btn-user" onclick="selectUser('user')">일반사용자</button>
  			<button type="button" class="btn-admin" onclick="selectUser('admin')">관리자</button>
			<input type="hidden" name="role" id="role" value="user">
    	</td>
    </tr>
    <tr id="adminPasswordRow" style="display: none;">
  		<th style="font-size: 13px;">관리자 비밀번호</th>
  		<td><input type="password" name="adminPw" placeholder="관리자용 비밀번호"></td>
	</tr>
    
      <tr>
      	<th>ID</th>
      	<td>
      	<input type="text" name="id" id="id" placeholder="아이디 입력 (6~20자)">
      	<input type="button" id="idcheck" value="중복확인">
      	</td>
      </tr>
      <tr>
      	<th>PW</th>
      	<td><input type="password" name="pw" placeholder="비밀번호 입력 (문자, 숫자, 특수문자 포함 8~20자)"></td>
      </tr>
      <tr>
      	<th>전화번호</th>
      	<td><input type="text" name="phone" placeholder="000-0000-0000"
				 pattern="\d{3}-\d{3,4}-\d{4}" title="형식: 010-1234-5678" required></td>
      </tr>
      <tr>
      	<th>이메일</th>
      	<td><input type="text" name="email" placeholder="example@email.com" required></td>
      </tr>
      <tr>
      	<th>나이</th>
      	<td><input type="date" name="birth"></td>
      </tr>
      <tr>
      	<th>여행스타일</th>
      	<td>
      		<select name="tripstyle">
      			<option value="activity">액티비티</option>
      			<option value="food">맛집탐방</option>
      			<option value="tourist">관광지 탐방</option>
      			<option value="resort">휴양지</option>
      		</select>
      	</td>
      </tr>
      <tr>
      	<td colspan="2">
      		<button type="submit" class="btn btn-primary">가입</button>
      		<button type="button" class="btn btn-danger" onclick="location.href='logoutmain'">취소</button>
      	</td>
      </tr>
    </tbody>
  </table>
  </form>
</div>
</body>
</html>