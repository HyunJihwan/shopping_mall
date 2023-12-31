<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
<title>관리자 페이지</title>
<script src="/resources/jquery/jquery-3.3.1.min.js"></script>
<link rel="stylesheet" href="/resources/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet"
	href="/resources/bootstrap/css/bootstrap-theme.min.css">
<script src="/resources/bootstrap/js/bootstrap.min.js"></script>

</head>
<body>
	<script src="//code.jquery.com/jquery-1.11.0.min.js"></script>
	<style>
body {
	font-family: '맑은 고딕', verdana;
	padding: 0;
	margin: 0;
}

ul {
	padding: 0;
	margin: 0;
	list-style: none;
}

div#root {
	width: 90%;
	margin: 0 auto;
}

header#header {
	font-size: 60px;
	padding: 20px 0;
}

header#header h1 a {
	color: #000;
	font-weight: bold;
}

nav#nav {
	padding: 10px;
	text-align: right;
}

nav#nav ul li {
	display: inline-block;
	margin-left: 10px;
}

section#container {
	padding: 20px 0;
	border-top: 2px solid #eee;
	border-bottom: 2px solid #eee;
}

section#container::after {
	content: "";
	display: block;
	clear: both;
}

aside {
	float: left;
	width: 200px;
}

div#container_box {
	float: right;
	width: calc(100% - 200px - 20px);
}

aside ul li {
	text-align: center;
	margin-bottom: 10px;
}

aside ul li a {
	display: block;
	width: 100%;
	padding: 10px 0;
}

aside ul li a:hover {
	background: #eee;
}

footer#footer {
	background: #f9f9f9;
	padding: 20px;
}

footer#footer ul li {
	display: inline-block;
	margin-right: 10px;
}
</style>
	<style>
.inputArea {
	margin: 10px 0;
}

select {
	width: 100px;
}

label {
	display: inline-block;
	width: 70px;
	padding: 5px;
}

label[for='gdsDes'] {
	display: block;
}

input {
	width: 150px;
}

textarea#gdsDes {
	width: 400px;
	height: 180px;
}

.orgImg { width:500px; height:auto; }
.thumbImg {}
.gdsDes img { max-width:600px; height:auto; }
</style>

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
			<aside>
				<%@ include file="../include/aside.jsp"%>
			</aside>
			<div id="container_box">
				<h2>상품 조회</h2>
				<form role="form" method="post" autocomplete="off">
				
					<input type="hidden" name="p" value="${goods.gdsNum }"/>
					
					<div class="inputArea">
						<label>1차 분류</label> <span class="category1"> <label>2차
								분류</label> <span class="category2">${goods.cateCode}
					</div>

					<div class="inputArea">
						<label for="gdsName">상품명</label> <span>${goods.gdsName}
					</div>

					<div class="inputArea">
						<label for="gdsPrice">상품가격</label> <span><fmt:formatNumber
								value="${goods.gdsPrice}" pattern="###,###,###" />
					</div>

					<div class="inputArea">
						<label for="gdsStock">상품수량</label> <span>${goods.gdsStock}
					</div>

					<div class="inputArea">
						<label for="gdsDes">상품소개</label> 
<%-- 						<span>${goods.gdsDes}</span> --%>
						<div class="gdsDes">${goods.gdsDes}</div>
					</div>
					
					<div class="inputArea">
				    <label for="gdsImg">이미지</label>
				    <p>원본 이미지</p>
				    <c:if test="${empty goods.gdsImg}">
				        <p>이미지가 없습니다.</p>
				    </c:if>
				    <c:if test="${!empty goods.gdsImg}">
				        <img src="${goods.gdsImg}" class="oriImg" />
				    </c:if>
				    <p>썸네일</p>
				    	<img src="${goods.gdsThumbImg}" class="thumbImg"/>
					</div>
									
					
					<div class="inputArea">
						<button type="button" id="modify_Btn" class="btn btn-warning">수정</button>
						<button type="button" id="delete_Btn" class="btn btn-danger" >삭제</button>
					
					<script>
						var formObj = $("form[role='form']");

						$("#modify_Btn").click(function(){
							formObj.attr("action", "/admin/goods/modify");
							formObj.attr("method", "get")
							formObj.submit();
						});

						$("#delete_Btn").on("click",function(){
	
							if(confirm("정말 삭제하시겠습니까?")) {
								formObj.attr("action", "/admin/goods/delete");
								formObj.submit();
							}			
											
						})
						

					</script>
					
					</div>

				</form>

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
	<script>
		// 컨트롤러에서 데이터 받기
		var jsonData = JSON.parse('${category}');
		console.log(jsonData);

		var cate1Arr = new Array();
		var cate1Obj = new Object();

		// 1차 분류 셀렉트 박스에 삽입할 데이터 준비
		for (var i = 0; i < jsonData.length; i++) {

			if (jsonData[i].level == "1") {
				cate1Obj = new Object(); //초기화
				cate1Obj.cateCode = jsonData[i].cateCode;
				cate1Obj.cateName = jsonData[i].cateName;
				cate1Arr.push(cate1Obj);
			}
		}

		// 1차 분류 셀렉트 박스에 데이터 삽입
		var cate1Select = $("select.category1")

		for (var i = 0; i < cate1Arr.length; i++) {
			cate1Select.append("<option value='" + cate1Arr[i].cateCode + "'>"
					+ cate1Arr[i].cateName + "</option>");
		}

		$(document)
				.on(
						"change",
						"select.category1",
						function() {

							var cate2Arr = new Array();
							var cate2Obj = new Object();

							// 2차 분류 셀렉트 박스에 삽입할 데이터 준비
							for (var i = 0; i < jsonData.length; i++) {

								if (jsonData[i].level == "2") {
									cate2Obj = new Object(); //초기화
									cate2Obj.cateCode = jsonData[i].cateCode;
									cate2Obj.cateName = jsonData[i].cateName;
									cate2Obj.cateCodeRef = jsonData[i].cateCodeRef;

									cate2Arr.push(cate2Obj);
								}
							}

							var cate2Select = $("select.category2");

							/*
							for(var i = 0; i < cate2Arr.length; i++) {
							  cate2Select.append("<option value='" + cate2Arr[i].cateCode + "'>"
							       + cate2Arr[i].cateName + "</option>");
							}
							 */

							cate2Select.children().remove();

							$("option:selected", this)
									.each(
											function() {

												var selectVal = $(this).val();

												cate2Select
														.append("<option value='" + selectVal + "'>전체</option>");

												for (var i = 0; i < cate2Arr.length; i++) {
													if (selectVal == cate2Arr[i].cateCodeRef) {
														cate2Select
																.append("<option value='" + cate2Arr[i].cateCode + "'>"
																		+ cate2Arr[i].cateName
																		+ "</option>");
													}
												}

											});

						});
	</script>
</body>
</html>
