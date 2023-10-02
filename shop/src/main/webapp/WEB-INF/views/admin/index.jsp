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
		<div id="container_box">
			본문 영역
		</div>
	</section>
	
	<footer id="footer">
		<div id="footer_box">
			<%@ include file="include/footer.jsp" %>
		</div>
	</footer>
</div>
</body>
</html>
