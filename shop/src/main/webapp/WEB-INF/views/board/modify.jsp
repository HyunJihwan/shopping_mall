<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
	
		body { margin:0; padding:0; font-family:'맑은 고딕', verdana; }
		a { color:#05f; text-decoration:none; }
		a:hover { text-decoration:underline; }
		
		h1, h2, h3, h4, h5, h6 { margin:0; padding:0; }
		ul, lo, li { margin:0; padding:0; list-style:none; }
	
		/* ---------- */
		
		div#root { width:900px; margin:0 auto; }
		header#header {}
		nav#nav {}
		section#container { }
			section#content { float:right; width:700px; }
			aside#aside { float:left; width:180px; }
			section#container::after { content:""; display:block; clear:both; }	
		footer#footer { background:#eee; padding:20px; }
		
		/* ---------- */
		
		header#header div#header_box { text-align:center; padding:30px 0; }
		header#header div#header_box h1 { font-size:50px; }
		header#header div#header_box h1 a { color:#000; }
		
		nav#nav div#nav_box { font-size:14px; padding:10px; text-align:right; }
		nav#nav div#nav_box li { display:inline-block; margin:0 10px; }
		nav#nav div#nav_box li a { color:#333; }
		
		section#container { }
		
		aside#aside h3 { font-size:22px; margin-bottom:20px; text-align:center; }
		aside#aside li { font-size:16px; text-align:center; }
		aside#aside li a { color:#000; display:block; padding:10px 0; }
		aside#aside li a:hover { text-decoration:none; background:#eee; }
		
		aside#aside li { position:relative; }
		aside#aside li:hover { background:#eee; } 		
		aside#aside li > ul.low { display:none; position:absolute; top:0; left:180px;  }
		aside#aside li:hover > ul.low { display:block; }
		aside#aside li:hover > ul.low li a { background:#eee; border:1px solid #eee; }
		aside#aside li:hover > ul.low li a:hover { background:#fff;}
		aside#aside li > ul.low li { width:180px; }
		
/* 		footer#footer { margin-top:100px; border-radius:50px 50px 0 0; } */
/* 		footer#footer div#footer_box { padding:0 20px; } */
		
	</style>
	<style>
   section#content ul li { display:inline-block; margin:10px; }
   section#content div.goodsThumb img { width:200px; height:200px; }
   section#content div.goodsName { padding:10px 0; text-align:center; }
   section#content div.goodsName a { color:#000; }
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

.orgImg {
width:500px; heigth:auto;
}
</style>


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
			<section id="contents">
				<form role=form method="post" autocomplete="off" enctype="multipart/form-data">
				
				<label>제목</label>	
				<input type="text" name="title" value="${view.title }"/></br/>
				
				<label>작성자</label>	
				<input type="text" name="userId" value="${view.userId }"/></br/>
				
				
				<label>내용</label>	
				<textarea cols="50" rows="5" name="content">${view.content }</textarea></br/>	
				<script>
				var ckeditor_config = {
					     resize_enaleb : false,
					     enterMode : CKEDITOR.ENTER_BR,
					     shiftEnterMode : CKEDITOR.ENTER_P,
					     filebrowserUploadUrl : "/board/ckUpload"
					   };
					   
	   			CKEDITOR.replace("content", ckeditor_config);
				</script>
				
				<div class="inputArea">
					   <label for="img">이미지</label>
					   <br>
					   <input type="file" id="img" name="file" />
					   <div class="select_img">
					    <img src="${view.img}" class="orgImg"/>
					    <input type="hidden" name="img" value="${view.img}" />
					   </div>
					   
					   <script>
					    $("img").change(function(){
					     if(this.files && this.files[0]) {
					      var reader = new FileReader;
					      reader.onload = function(data) {
					       $(".select_img img").attr("src", data.target.result).width(100);          
					      }
					      reader.readAsDataURL(this.files[0]);
					     }
					    });
					   </script>
					   <%=request.getRealPath("/") %>
					</div>
				
				<br>
				<button type="submit" class="btn btn-dark">수정 완료</button>	
				
				</form>	
			
				</section>

<!-- 			<aside id="aside"> -->
<%-- 				<%@ include file="../include/aside.jsp" %> --%>
<!-- 			</aside> -->
			
		</div>
	</section>
	

	<footer class="py-3 my-4" id="footer_box">
  		<%@ include file="../include/footer.jsp" %>
 
  	</footer>

</div>
</body>
</html>
