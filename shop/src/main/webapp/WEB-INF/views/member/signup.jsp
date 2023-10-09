<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
	<title>회원 가입</title>
		<script src="/resources/jquery/jquery-3.3.1.min.js"></script>
<link rel="stylesheet" href="/resources/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet"
	href="/resources/bootstrap/css/bootstrap-theme.min.css">
<script src="/resources/bootstrap/js/bootstrap.min.js"></script>
<script src="/resources/ckeditor/ckeditor.js"></script>
<style>
		body {
			font-family: Arial, sans-serif;
			background-color: #f4f4f4;
		}
		span{
			font-weight: bold;
		}
		.container {
			margin-top: 50px;
		}

		.form-container {
			background-color: #ffffff;
			padding: 20px;
			box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
			border-radius: 5px;
		}

		.form-group {
			margin-bottom: 20px;
		}

		label {
			font-weight: bold;
		}

		.input-group {
			position: relative;
		}

		.input-group-addon {
			position: absolute;
			top: 0;
			bottom: 0;
			left: 0;
			padding: 6px 12px;
			background-color: #eee;
			border: 1px solid #ccc;
			border-radius: 4px;
		}

		.input-group input {
			padding-left: 10px; /* 아이콘 공간 확보 */
		}

		.select-group {
			display: flex;
			align-items: center;
		}

		.select-group select {
			flex: 1;
			margin-left: 10px;
			border-radius: 3px;
		}

		.button-group {
			display: flex;
			justify-content: space-between;
		}

		.chkbtn {
			padding: 5px 10px;
			background-color: #3498db;
			color: #fff;
			border: none;
			border-radius: 4px;
			cursor: pointer;
			transition: background-color 0.3s;
		}

		.chkbtn:hover {
			background-color: #2980b9;
		}

		.email-result {
			font-weight: bold;
			margin-top: 10px;
		}

		.success {
			color: green;
		}

		.error {
			color: red;
		}
	</style>
	<style>
    /* 기본 스타일 유지 */

    /* 폼 컨테이너의 스타일 */
    .input_area {
        margin-bottom: 15px; /* 각 입력 필드 아래에 간격 추가 */
    }

    /* 이메일 그룹의 스타일 */
    .form-group.d-flex {
        align-items: center; /* 요소를 수직으로 가운데 정렬 */
        margin-bottom: 15px; /* 간격 추가 */
    }

    /* 이메일 입력 필드 스타일 */
    .input-group.inputText {
        flex: 1; /* 자동으로 남은 공간을 차지하도록 함 */
    }

    /* 이메일 선택 드롭다운 스타일 */
    #domainselect {
        flex: 1; /* 자동으로 남은 공간을 차지하도록 함 */
        margin-left: 10px;
    }

    /* 인증 버튼 간격 조정 */
    .chkbtn {
        margin-left: 10px;
    }
</style>
	
	
</head>
<body>
<div id="root">
	<header id="header">
		<div id="header_box">
			<%@ include file="../include/header.jsp" %>
		</div>
	</header>
	
	<nav id="nav">
		<div id="nav_box">
			<%@ include file="../include/nav.jsp" %>
		</div>
	</nav>
	
	<section id="container">
		<div id="container_box">
			<section id="content">
 <form role="form" method="post" autocomplete="off">
  <div class="input_area">
   <label for="userId">아이디</label>
   <input type="email" id="userId" name="userId" placeholder="example@email.com" required="required" />      
  </div>
  
  <div class="input_area">
   <label for="userPass">패스워드</label>
   <input type="password" id="userPass" name="userPass" required="required" />      
  </div>
  
  <div class="input_area">
   <label for="userName">닉네임</label>
   <input type="text" id="userName" name="userName" placeholder="닉네임을 입력해주세요" required="required" />      
  </div>
  
<!--    <div class="input_area"> -->
<!--    <label for="userPhon">연락처</label> -->
<!--    <input type="text" id="userPhon" name="userphon" placeholder="연락처를 입력해주세요" required="required" />       -->
<!--   </div> -->
  
  
  <div class="input_area">
   <label for="userPhon">연락처</label>
   <div class="input-group-sm">
   <input type="text" id="userPhon" name="userPhon" placeholder="연락처를 입력해주세요" required="required" style="width: 100px;" class="form-control float-left"/>
         <label class="float-left" style="padding: 0; text-align: center;">&nbsp;-&nbsp;</label>
         <input type="text" id="userPhon" name="userPhon" placeholder="연락처를 입력해주세요" required="required" style="width: 100px;" class="form-control float-left"/>
          <label class="float-left" style="padding: 0; text-align: center;">&nbsp;-&nbsp;</label>
         <input type="text" id="userPhon" name="userPhon" placeholder="연락처를 입력해주세요" required="required" style="width: 100px;" class="form-control float-left"/>
  	</div>
  	
  </div>
  
  <!-- 이메일 -->
	<div class="form-group d-flex">
			<div class="input-group inputText">
					<span class="fa"><i class="fa fa-envelope"></i></span><span style="width: 15px;">이메일</span>
					<!-- 아 오타 진짜 짜증나.. id eamil 로해가지고 하.. -->
					<input type="text" class="form-control" value="" placeholder="이메일" name="email" id="email" required="required"/> 
				</div>
					<div class="input-group" style="width: 50%;align-items: center;margin-right: 20px; margin-left: 10px;" >
						@
						<select name="domainselect" id="domainselect" class="form-select form-select-sm" style="align-items: baseline;margin-left: 10px;border-radius: 3px;">
							<option disabled="disabled" selected="selected">선택</option>
							<option value="@naver.com">naver.com</option>
							<option value="@gmail.com">gmail.com</option>
							<option value="@hanmail.net">hanmail.net</option>
							<option value="@daum.net">daum.net</option>
							<option value="">직접입력</option>
						</select>
						<div class="select-dropdown"></div>
					</div>
		<div>
			<input type="button" class="chkbtn" name="emailauth" id="emailauth" required="required"  value="인증번호 전송">							
		</div>
	</div>
	<div class="form-group d-flex">
		<div class="input-group">
			<span class="fa"><i class="fa fa-envelope"></i></span><span style="width: 15px;">인증번호 확인</span>
			<input type="text" class="form-control mail-check-input" name="emailch" style="margin-right: 30px;" placeholder="인증번호" required="required">
		</div>
		<div>
			<input type="button" class="chkbtn" id="emailauthchk" name="emailauthchk" value="인증번호 확인">			
		</div>
	</div>
	<!-- 이메일 끝 -->
		
  
  <button type="submit" id="signup_btn" name="signup_btn">회원가입</button>
  
 </form>   
</section>
		</div>
	</section>
	
	<footer id="footer">
		<div id="footer_box">
			<%@ include file="../include/footer.jsp" %>
		</div>
	</footer>
</div>

<!-- 이메일 인증 스크립트 -->
<script>
 	var emailChk = 0;
$('#email').on('change', function(){
	emailChk = 0;
})
	
	
$('#emailauth').on('click',function () {

	function isValidEmail(email) {
	    const emailRegex = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/;
	    return emailRegex.test(email);
	}
		

	
	let email = $('#email').val() + $('#domainselect').val(); // 이메일 주소값 얻어오기!
	if(!isValidEmail(email)){
		alert('이메일입력하라고');
		return;
	}
	
	console.log('완성된 이메일 : ' + email); // 이메일 오는지 확인
	const checkInput = $('.mail-check-input') // 인증번호 입력하는곳 

	
	alert('인증번호가 전송되었습니다.')
	$.ajax({
		type : 'get',
		url :  '<%=request.getContextPath()%>/member/mailCheck.do?email=' + email,
		success : function (data) {
			checkInput.attr('disabled',false);
			code = data;
			console.log(code);
		},
		error : function(err){
			alert(err.status)
		}
	}); // end ajax
}); // end send eamil

// 인증번호 비교 
// blur -> focus가 벗어나는 경우 발생
// 인증번호 확인
$('#emailauthchk').click(function () {
    const inputCode = $('.mail-check-input').val();
    const $resultMsg = $('#emailauthchk');

	
    if (inputCode === code) {
        emailChk = 1;
        alert('인증번호가 일치합니다.');
        $resultMsg.css('color', 'green');
        $('#mail-Check-Btn').attr('disabled', true);
        $('#email').attr('readonly', true);
        $('#domainselect').attr('readonly', true);
        $('#domainselect').attr('onFocus', 'this.initialSelect = this.selectedIndex');
        $('#domainselect').attr('onChange', 'this.selectedIndex = this.initialSelect');
    } else {
        alert('인증번호가 불일치합니다. 다시 확인해주세요.');
        emailChk = 0;
        $resultMsg.css('color', 'red');
    }
});
</script> 			

</body>
</html>
