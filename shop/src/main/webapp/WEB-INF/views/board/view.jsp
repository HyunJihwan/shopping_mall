<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<html>
<head>
<meta charset="UTF-8">
<title>게시판 리스트?</title>
<script src="/resources/jquery/jquery-3.3.1.min.js"></script>
<link rel="stylesheet" href="/resources/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet"
	href="/resources/bootstrap/css/bootstrap-theme.min.css">
<script src="/resources/bootstrap/js/bootstrap.min.js"></script>
<script src="/resources/ckeditor/ckeditor.js"></script>
</head>
<style>
body {
	margin: 0;
	padding: 0;
	font-family: '맑은 고딕', verdana;
}

a {
	color: #05f;
	text-decoration: none;
}

a:hover {
	text-decoration: underline;
}

h1, h2, h3, h4, h5, h6 {
	margin: 0;
	padding: 0;
}

ul, lo, li {
	margin: 0;
	padding: 0;
	list-style: none;
}

/* ---------- */
div#root {
	width: 900px;
	margin: 0 auto;
}

header#header {
	
}

nav#nav {
	
}

section#container {
	
}

section#content {
	float: right;
	width: 700px;
}

aside#aside {
	float: left;
	width: 180px;
}

section#container::after {
	content: "";
	display: block;
	clear: both;
}

footer#footer {
	background: #eee;
	padding: 20px;
}

/* ---------- */
header#header div#header_box {
	text-align: center;
	padding: 30px 0;
}

header#header div#header_box h1 {
	font-size: 50px;
}

header#header div#header_box h1 a {
	color: #000;
}

nav#nav div#nav_box {
	font-size: 14px;
	padding: 10px;
	text-align: right;
}

nav#nav div#nav_box li {
	display: inline-block;
	margin: 0 10px;
}

nav#nav div#nav_box li a {
	color: #333;
}

section#container {
	
}

aside#aside h3 {
	font-size: 22px;
	margin-bottom: 20px;
	text-align: center;
}

aside#aside li {
	font-size: 16px;
	text-align: center;
}

aside#aside li a {
	color: #000;
	display: block;
	padding: 10px 0;
}

aside#aside li a:hover {
	text-decoration: none;
	background: #eee;
}

aside#aside li {
	position: relative;
}

aside#aside li:hover {
	background: #eee;
}

aside#aside li>ul.low {
	display: none;
	position: absolute;
	top: 0;
	left: 180px;
}

aside#aside li:hover>ul.low {
	display: block;
}

aside#aside li:hover>ul.low li a {
	background: #eee;
	border: 1px solid #eee;
}

aside#aside li:hover>ul.low li a:hover {
	background: #fff;
}

aside#aside li>ul.low li {
	width: 180px;
}

/* 		footer#footer { margin-top:100px; border-radius:50px 50px 0 0; } */
/* 		footer#footer div#footer_box { padding:0 20px; } */
</style>
<style>
section#content ul li {
	display: inline-block;
	margin: 10px;
}

section#content div.goodsThumb img {
	width: 200px;
	height: 200px;
}

section#content div.goodsName {
	padding: 10px 0;
	text-align: center;
}

section#content div.goodsName a {
	color: #000;
}
</style>
<style>
/* 기본 테이블 스타일 */
table {
	width: 100%;
	border-collapse: collapse;
	font-family: Arial, sans-serif;
}

/* 테이블 헤더 스타일 */
thead {
	background-color: #333;
	color: #fff;
}

thead th {
	padding: 10px;
}

/* 짝수 행 스타일 */
tbody tr:nth-child(even) {
	background-color: #f2f2f2;
}

/* 홀수 행 스타일 */
tbody tr:nth-child(odd) {
	background-color: #fff;
}

/* 테이블 셀 스타일 */
td, th {
	border: 1px solid #ddd;
	padding: 8px;
	text-align: left;
}

/* 링크 스타일 (작성자 열) */
td a {
	text-decoration: none;
	color: #007bff;
	font-weight: bold;
}

/* 링크 호버 스타일 */
td a:hover {
	text-decoration: underline;
}
</style>
<style>
/* Style for the comments section */
ul.comments {
	list-style-type: none;
	padding: 0;
}

ul.comments li {
	background-color: #f5f5f5;
	margin: 10px 0;
	padding: 10px;
	border: 1px solid #ddd;
}

ul.comments p {
	margin: 0;
}

ul.comments p.author {
	font-weight: bold;
}

ul.comments p.date {
	font-size: 0.8em;
	color: #777;
}

ul.comments p.content {
	margin-top: 10px;
}
</style>
<style>
div.replyModal {
	position: relative;
	z-index: 1;
	display: none;
}

div.modalBackground {
	position: fixed;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	background: rgba(0, 0, 0, 0.8);
	z-index: -1;
}

div.modalContent {
	position: fixed;
	top: 20%;
	left: calc(50% - 250px);
	width: 500px;
	height: 250px;
	padding: 20px 10px;
	background: #fff;
	border: 2px solid #666;
}

div.modalContent textarea {
	font-size: 16px;
	font-family: '맑은 고딕', verdana;
	padding: 10px;
	width: 500px;
	height: 200px;
}

div.modalContent button {
	font-size: 20px;
	padding: 5px 10px;
	margin: 10px 0;
	background: #fff;
	border: 1px solid #ccc;
}

div.modalContent button.modal_cancel {
	margin-left: 20px;
}
</style>
<style>
.like-button {
	display: inline-block;
	cursor: pointer;
	color: #333;
}

.liked {
	color: red;
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

					<label>제목</label> ${view.title}<br /> <label readonly>작성자</label>
					${view.userName}<br /> <label>내용</label><br /> ${view.content}<br />
					<br> <label>조회수</label><br /> ${view.viewCnt}<br /> <br>

					<input type="hidden" id="likeBno" name="bno" value="${view.bno}">
					<input type="hidden" id="likeId" name="userId"
						value="${member.userId}">

					<c:if test="${member != null }">
						<div id="mylike">
							<div id="mylikeBtn">
								<img id="mylikeImg" src="../resources/img/heart.jpg"
									style="width: 50px; height: 50px;">
							</div>
						</div>
					</c:if>
					<c:if test="${member == null }">
						<h1>좋아요는 로그인이 되야 보입니다.</h1>
					</c:if>
					<script>
						$(document)
								.ready(
										function() {
											let bno = $("#likeBno").val();
											let userId = $("#likeId").val();
											let likeValue;

											likeChk(bno, userId);

											$("#mylikeBtn").on("click",
													function() {
														alert("하트 누름");
														likeBtn({
															bno : bno,
															userId : userId
														});
														likeChk(bno, userId);
													});

											function likeChk(bno, userId) {
												$
														.getJSON(
																"/board/likeChk/"
																		+ bno
																		+ "/"
																		+ userId
																		+ ".json",
																function(data) {
																	likeValue = data;
																	console
																			.log(likeValue);

																	if (likeValue === 0) {
																		$(
																				"#mylikeImg")
																				.attr(
																						"src",
																						"../resources/img/heart.jpg");
																	} else {
																		$(
																				"#mylikeImg")
																				.attr(
																						"src",
																						"../resources/img/full-heart.jpg");
																	}
																});
											}

											function likeBtn(like) {
												if (likeValue === 0) {
													$
															.ajax({
																type : "post",
																url : "/board/likeUp",
																data : JSON
																		.stringify(like),
																contentType : "application/json; charset=utf-8",
																success : function(
																		result) {
																	if (result === "success") {
																		alert("좋아요 _ 꽉하트");

																	}
																},
																error : function() {
																	alert("실패했습니다 하 좀 되라");
																},
															});
												} else {
													$
															.ajax({
																type : "post",
																url : "/board/likeDown", // Fixed missing ':' in this line
																data : JSON
																		.stringify(like),
																contentType : "application/json; charset=utf-8",
																success : function(
																		result) {
																	if (result === "success") {
																		if (confirm("좋아요를 취소하시겠습니까?")) {
																			alert("좋아요 _ 하트비움");

																		}
																	}
																},
																error : function() {
																	alert("실패했습니다 하..");
																},
															});
												}
											}
										});
					</script>


					<c:if test="${member != null }">
						<c:choose>
							<c:when test="${view.userId eq member.userId}">
								<div>
									<button type="button"
										onclick="location.href='/board/modify?bno=${view.bno}'">수정</button>
									<%-- 									<a href="/board/modify?bno=${view.bno}">게시물 수정</a> --%>
									<!-- 									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  -->
									<%-- 									<a href="/board/delete?bno=${view.bno}">게시물 삭제</a> --%>
									<button type="button" id="viewDel"
										onclick="location.href='/board/delete?bno=${view.bno}'">삭제</button>
								</div>
							</c:when>
							<c:otherwise>
								<p>자신의 게시물이 아니면 삭제할수없습니다.</p>
							</c:otherwise>
						</c:choose>
					</c:if>





					<!-- 댓글구현 부 -->
					<hr />

					<ul id="ul_input">
						<c:forEach items="${reply}" var="comment">

							<li>
								<div>
									<p>${comment.userName }
										/
										<fmt:formatDate value="${comment.regDate}"
											pattern="yyyy-MM-dd" />
									</p>
									<p>${comment.content }</p>
									<input type="hidden" name="userId" value="${comment.userId }">
								</div>
							</li>
							<div>
								<c:if test="${!empty member}">
									<button type="button" class="btn btn-primary"
										onclick="location.href='/board/replyUpdate?bno=${view.bno}&rno=${comment.rno}'">수정</button>
									<form role="form" action="/board/replyDelete" method="POST">
										<input type="hidden" name="bno" value="${view.bno}" /> <input
											type="hidden" name="rno" value="${comment.rno}" />
										<button type="submit" class="btn btn-danger" id="deleteBtn">삭제</button>
									</form>
									<button type="button" class="btn btn-info" id="reply_btn">답글 달기</button>

								</c:if>
							</div>
							<hr />
						</c:forEach>
						
						<script>
						$("#reply_btn").on("click", function () {

							
						    $('#ul_input').append('<li>' +
						        '<div>' +
						        '<p>${comment.userName}gd' +
						        '<fmt:formatDate value="${comment.regDate}" pattern="yyyy-MM-dd" />' +
						        '</p>' +
						        '<p>${comment.content}</p>' +
						        '<input type="hidden" name="userId" value="${comment.userId}" />' +
						        '</div>' +
						        '</li>');
						});
												
						</script>

					</ul>


					<script>
						$("#deleteBtn").click(function() {
							if (confirm("정말 삭제하시겠습니까?")) {

								alert("삭제 성공");

							} else {
								alert("삭제를 취소합니다");
							}
						});
					</script>
					<div>
						<c:if test="${member != null }">
						
							<form method="post" action="/board/replyWrite">
								<p>
									<input type="hidden" name="userId" value="${member.userId }"
										readonly /> <label>댓글 작성자</label> <input type="text"
										name="userName" value=${member.userName } readonly />
								</p>

								<p>
									<textarea rows="5" cols="50" name="content"></textarea>
								</p>

								<p>
									<input type="hidden" name="bno" value="${view.bno}">
									<button type="submit">댓글 작성</button>
								</p>
							</form>
						</c:if>
					</div>




				</section>

				<!-- 			<aside id="aside"> -->
				<%-- 				<%@ include file="../include/aside.jsp" %> --%>
				<!-- 			</aside> -->



			</div>
		</section>

		<script>
			$('#viewDel').on("click", function() {
				if (confirm("정말 삭제하시겠습니까?")) {
					alert("삭제되었습니다.");
				}
			})
		</script>

		<footer class="py-3 my-4" id="footer_box">
			<%@ include file="../include/footer.jsp"%>

		</footer>

	</div>
</body>
</html>
