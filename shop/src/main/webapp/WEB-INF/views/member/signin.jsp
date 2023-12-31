<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
<title>로그인 화면</title>
		<script src="/resources/jquery/jquery-3.3.1.min.js"></script>
<link rel="stylesheet" href="/resources/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet"
	href="/resources/bootstrap/css/bootstrap-theme.min.css">
<script src="/resources/bootstrap/js/bootstrap.min.js"></script>
<script src="/resources/ckeditor/ckeditor.js"></script>
</head>
<style>
	#signin_btn{
		padding: 5px 10px;
			background-color: #3498db;
			color: #fff;
			border: none;
			border-radius: 4px;
			cursor: pointer;
			transition: background-color 0.3s;
	}
	
	/* Center the login form */
#container {
  display: flex;
  justify-content: center;
  align-items: center;
  height: 100vh;
  background-color: #f4f4f4;
}

#container_box {
  text-align: center;
  padding: 20px;
  box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
  border-radius: 5px;
  max-width: 400px;
  width: 100%;
  background-color: #fff;
}

/* Input Area Styles */
.input_area {
  margin-bottom: 15px;
  text-align: left;
}

.input_area label {
  display: block;
  font-weight: bold;
}

.input_area input {
  width: 100%;
  padding: 10px;
  border: 1px solid #ccc;
  border-radius: 4px;
}

/* Button Styles */
#signin_btn {
  padding: 10px 20px;
  background-color: #3498db;
  color: #fff;
  border: none;
  border-radius: 4px;
  cursor: pointer;
  transition: background-color 0.3s;
}

#signin_btn:hover {
  background-color: #2980b9;
}

/* Error Message Styles */
#error_message {
  color: #f00;
  margin-top: 10px;
}

/* Footer Styles */
#footer_box {
  text-align: center;
  padding: 10px;
  background-color: ;
  color: #fff;
}
	
	
</style>
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
					<form role="form" method="post" autocomplete="off">
						<div class="input_area">
							<label for="userId">아이디</label> <input type="email" id="userId"
								name="userId" required="required" />
						</div>

						<div class="input_area">
							<label for="userPass">패스워드</label> <input type="password"
								id="userPass" name="userPass" required="required" />
						</div>

						<button type="submit" id="signin_btn" name="signin_btn">로그인</button>

						<c:if test="${msg == false}">
							<p style="color: #f00;">로그인에 실패했습니다.</p>
						</c:if>

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
