<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>정보 수정 창</title>

<script src="/resources/jquery/jquery-3.3.1.min.js"></script>
<link rel="stylesheet" href="/resources/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet"
	href="/resources/bootstrap/css/bootstrap-theme.min.css">
<script src="/resources/bootstrap/js/bootstrap.min.js"></script>
<script src="/resources/ckeditor/ckeditor.js"></script>
</head>
<body>


<div id="root">
		<header id="header">
			<div id="header_box">
				<%@ include file="../include/header.jsp"%>
			</div>
		</header>

		<nav id="nav">
			<div id="nav_box">
				<%@ include file="../include/nav.jsp"%>
			</div>
		</nav>

		<section id="container">
			<div id="container_box">
				<section id="content">
					<form role="form" method="post" action="/member/modify" autocomplete="off">
						
						<p>
							<label for="userName">닉네임</label>
							<input type="text" id="userName" name="userName" value="${member.userName }"/>
						</p>
						<p>
							<label for="userPass">새로운 패스워드</label>
							<input type="password" id="userPass" name="userPass"/>
						</p>
						<p>
							<button type="submit" id="modify">회원정보 수정</button>
							
						</p>
						
						<p>
							<a href="/">처음으로</a>
						</p>
					</form>
					<script>
					 $("#modify").click(function (event) {
					        if (confirm("정말로 바꾸시겠습니까?")) {
					            if ($("#userPass").val() === "") {
					                alert("비밀번호를 확인해주세요");
					                event.preventDefault(); // Prevent the form from submitting
					            }else{
									alert("성공적으로 변경되었습니다!");
						           }
					        }
					    });
					</script>
					
					<a href="/member/delete?userId=${member.userId}">회원 탈퇴로 가기</a>		 
				
				</section>
			</div>
		</section>

<!-- 		<footer id="footer"> -->
<!-- 			<div id="footer_box"> -->
<%-- 				<%@ include file="../include/footer.jsp"%> --%>
<!-- 			</div> -->
<!-- 		</footer> -->
			
		<footer class="py-3 my-4" id="footer_box">
  		<%@ include file="../include/footer.jsp" %>
 
  	</footer>

	</div>


</body>
</html>