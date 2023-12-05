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
<style>
        /* 스타일 추가 */
        body {
            font-family: Arial, sans-serif;

            margin: 0;
            padding: 100px;
        }

        label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }

        input[type="text"],
        textarea {
            width: calc(100% - 12px);
            padding: 6px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 3px;
            font-size: 14px;
        }

        button {
            padding: 8px 16px;
            background-color: #007bff;
            color: #fff;
            border: none;
            border-radius: 3px;
            cursor: pointer;
            font-size: 16px;
        }

        button:hover {
            background-color: #0056b3;
        }

        .inputArea {
            margin-bottom: 20px;
        }

        .select_img img {
            max-width: 300px;
            height: auto;
            margin-top: 10px;
            display: block;
        }
    </style>


<div id="nav">
	<%@ include file="../include/nav.jsp" %>
</div>

<form method="post" id="form" autocomplete="off" enctype="multipart/form-data">


<label>제목</label>
<input type="text" name="title" id="title"/><br />

<label>작성자</label>
<input type="text" name="userId"  value="${member.userId }" readonly /><br />

<label>내용</label>
<textarea cols="50" rows="5" name="content" id="content"></textarea><br />
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
						<label for="img">이미지</label> <input type="file" id="img"
							name="file" />
						<div class="select_img">
							<img src="" / class="orgImg">
						</div>

						<script>
					    $("#img").change(function(){
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


<button type="submit" id="sb">작성</button>

</form>

</body>

<script>
$("#sb").on('click', function(event) {
    var title = $("#title").val();
    var content = $("#content").val();

    if (title === "") {
        alert("제목을 입력해주세요");
        event.preventDefault();
    } else {
        // 제목과 내용이 모두 비어있지 않으면 폼 서브밋
        $("#form").submit();
    }
});
	
	
	
	
</script>
</html>