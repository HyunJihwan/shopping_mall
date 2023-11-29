<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시물 작성</title>
</head>
<body>
<script src="/resources/jquery/jquery-3.3.1.min.js"></script>
<link rel="stylesheet" href="/resources/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet"
	href="/resources/bootstrap/css/bootstrap-theme.min.css">
<script src="/resources/bootstrap/js/bootstrap.min.js"></script>
<script src="/resources/ckeditor/ckeditor.js"></script>
<div id="nav">
	<%@ include file="../include/nav.jsp" %>
</div>

<form method="post" id="form">

<label>제목</label>
<input type="text" name="title" id="title"/><br />

<label>작성자</label>
<input type="text" name="userId"  value="${member.userId }" readonly /><br />

<label>내용</label>
<textarea cols="50" rows="5" name="content"></textarea><br />
<script>
var ckeditor_config = {
	     resize_enaleb : false,
	     enterMode : CKEDITOR.ENTER_BR,
	     shiftEnterMode : CKEDITOR.ENTER_P,
	     filebrowserUploadUrl : "/board/ckUpload"
	   };
	   
	   CKEDITOR.replace("content", ckeditor_config);
</script>

<button type="submit" id="sb">작성</button>

</form>

</body>

<script>
$("#sb").on('click', function(event) {
	
    if($("#title").val() === "")) {
        alert("제목을 입력해주세요");
        event.preventDefault(); 
    } else {
        // 제목이 비어있지 않으면 폼 서브밋
        $("#form").submit();
    }
});
	
	
	
	
</script>
</html>