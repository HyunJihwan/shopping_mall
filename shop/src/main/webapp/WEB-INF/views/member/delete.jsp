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
					<form role="form" method="post" action="/member/delete" autocomplete="off">
							<input type="hidden" value="${cart.userId }"/>
						<p>
							<label for="userId">아이디</label>
							<input type="text" id="userId" name="userId" value="${member.userId }" readonly/>
						</p>
						
						<p>
							<label for="userName">닉네임</label>
							<input type="text" id="userName" name="userName" value="${member.userName }" readonly/>
						</p>
						<p>
							<label for="userPhon">휴대폰 번호</label>
							<input type="text" id="userPhon" name="userPhon" value="${member.userPhon }" readonly/>
						</p>
						<p>
							<button type="submit" onclick="">회원정보 탈퇴</button>		
						</p>
						<p>
							<a href="/">처음으로</a>
						</p>
					</form>
						 
				
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