<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 리스트?</title>
<script src='https://code.jquery.com/jquery-3.3.1.min.js'></script>
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
   section#content ul li { display:inline-block; margin:5px; }
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
		
			<section id="content">	
			<div class="search">
   <select name="searchType">
    <option value="n"<c:out value="${scri.searchType == null ? 'selected' : ''}"/>>-----</option>
    <option value="t"<c:out value="${scri.searchType eq 't' ? 'selected' : ''}"/>>제목</option>
    <option value="c"<c:out value="${scri.searchType eq 'c' ? 'selected' : ''}"/>>내용</option>
    <option value="w"<c:out value="${scri.searchType eq 'w' ? 'selected' : ''}"/>>작성자</option>
    <option value="tc"<c:out value="${scri.searchType eq 'tc' ? 'selected' : ''}"/>>제목+내용</option>
   </select>
   
   <input type="text" name="keyword" id="keywordInput" value="${scri.keyword}"/>

   <button id="searchBtn">검색</button>
   
   <script>
   $(function(){
    $('#searchBtn').click(function() {
     self.location = "listSearch"
       + '${pageMaker.makeQuery(1)}'
       + "&searchType="
       + $("select option:selected").val()
       + "&keyword="
       + encodeURIComponent($('#keywordInput').val());
      });
   });     
   </script>
</div>
					<table class="table table-hover">
						<thead>
							<tr>
								<th>번호</th>
								<th>제목</th>
								<th>작성일</th>
								<th>작성자</th>
								<th>조회수</th>
								<th>좋아요 수</th>
							</tr>
							</thead>
							<c:if test="${member != null}">
							<tr>
							<a href="/board/write">글 작성</a>
							</tr>
							</c:if>
						
						
						<tbody>
							<c:forEach items="${searchList}" var="list">
								<tr>
									<td>${list.bno}</td>
									<td><a href="/board/view?bno=${list.bno}">${list.title}</a>
									</td>
									<td><fmt:formatDate value="${list.regDate}"
											pattern="yyyy-MM-dd" /></td>
									<td>${list.userName}</td>
									<td>${list.viewCnt}</td>
									<td>${list.cnt }</td>
								</tr>
							</c:forEach>
						</tbody>

					</table>
					
					<div class="col-md-offset-1">
					   <ul class="pagination">
					    <c:if test="${pageMaker.prev}">
					     <li><a href="listSearch${pageMaker.makeSearch(pageMaker.startPage - 1)}">이전</a></li>
					    </c:if>   
					    
					    <c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="idx">
					     <li <c:out value="${pageMaker.cri.page == idx ? 'class=active' : ''}"/>>
					     <a href="listSearch${pageMaker.makeSearch(idx)}">${idx}</a></li>
					    </c:forEach>
					      
					    <c:if test="${pageMaker.next && pageMaker.endPage > 0}">
					     <li><a href="listSearch${pageMaker.makeSearch(pageMaker.endPage + 1)}">다음</a></li>
					    </c:if>   
					   </ul>
					</div>
					
					
					
								
				</section>
			
<!-- 			<aside id="aside"> -->
<%-- 				<%@ include file="../include/aside.jsp" %> --%>
<!-- 			</aside> -->
			
		</div>
	</section>
	
<div class="modal" id="myModal" tabindex="-1" role="dialog">
  <div class="modal-dialog" role="documnet">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">Modal title</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <p>Modal body text goes here.</p>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary">Save changes</button>
      </div>
    </div>
  </div>
</div>

<script>
$(document).ready(function(){
	console.log("스크립트 실행");
	var result = "${result}";
	console.log(" reuslt : " + result);

	checkModal(result);

	function checkModal(result){

		if (result === ''){
			console.log(1);
			return;
		}

			$(".modal-body").html(
				"게시글 " + result + " 번이 등록되었습니다!");
		
		$("#myModal").modal("show");
	}	
});
</script>

	

	<footer class="py-3 my-4" id="footer_box">
  		<%@ include file="../include/footer.jsp" %>
 
  	</footer>

</div>
</body>
</html>
