<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
	<title>관리자 페이지</title>
	<script src="/resources/jquery/jquery-3.3.1.min.js"></script>
	<link rel="stylesheet" href="/resources/bootstrap/css/bootstrap.min.css">
	<link rel="stylesheet" href="/resources/bootstrap/css/bootstrap-theme.min.css">
	<script src="/resources/bootstrap/js/bootstrap.min.js"></script>
</head>
<body>
<style>
   body { font-family:'맑은 고딕', verdana; padding:0; margin:0; }
   ul { padding:0; margin:0; list-style:none;  }

   div#root { width:90%; margin:0 auto; }
   
   header#header { font-size:60px; padding:20px 0; }
   header#header h1 a { color:#000; font-weight:bold; }
   
   nav#nav { padding:10px; text-align:right; }
   nav#nav ul li { display:inline-block; margin-left:10px; }

     section#container { padding:20px 0; border-top:2px solid #eee; border-bottom:2px solid #eee; }
   section#container::after { content:""; display:block; clear:both; }
   aside { float:left; width:200px; }
   div#container_box { float:right; width:calc(100% - 200px - 20px); }
   
   aside ul li { text-align:center; margin-bottom:10px; }
      aside ul li a { display:block; width:100%; padding:10px 0;}
   aside ul li a:hover { background:#eee; }
   
   footer#footer { background:#f9f9f9; padding:20px; }
   footer#footer ul li { display:inline-block; margin-right:10px; }
</style>

<div id="root">
	<header id="header">
		<div id="header_box">
			<%@ include file="include/header.jsp" %>
		</div>
	</header>
	
	<nav id="nav">
		<div id="nav_box">
			<%@ include file="include/nav.jsp" %>
		</div>
	</nav>
	
	<section id="container">
			<aside>
				<%@ include file="include/aside.jsp" %>
			</aside>
			<div id="container_box">
			본문 영역
		</div>
	</section>
	
<!-- 	<footer id="footer"> -->
<!-- 		<div id="footer_box"> -->
<%-- 			<%@ include file="include/footer.jsp" %> --%>
<!-- 		</div> -->
<!-- 	</footer> -->


		<footer class="py-3 my-4" id="footer_box">
			<%@ include file="include/footer.jsp"%>

		</footer>

	</div>
</body>
</html>
