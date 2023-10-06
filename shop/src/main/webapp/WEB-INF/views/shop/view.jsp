<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
	<title>지환 Home</title>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>

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
		
		footer#footer { margin-top:100px; border-radius:50px 50px 0 0; }
		footer#footer div#footer_box { padding:0 20px; }
		
	</style>
	<style>
   section#content ul li { display:inline-block; margin:10px; }
   section#content div.goodsThumb img { width:200px; height:200px; }
   section#content div.goodsName { padding:10px 0; text-align:center; }
   section#content div.goodsName a { color:#000; }
</style>

<style>
   div.goods div.goodsImg { float:left; width:350px; }
   div.goods div.goodsImg img { width:350px; height:auto; }
   
   div.goods div.goodsInfo { float:right; width:330px; font-size:22px; }
   div.goods div.goodsInfo p { margin:0 0 20px 0; }
   div.goods div.goodsInfo p span { display:inline-block; width:100px; margin-right:15px; }
   
   div.goods div.goodsInfo p.cartStock input { font-size:22px; width:50px; padding:5px; margin:0; border:1px solid #eee; }
   div.goods div.goodsInfo p.cartStock button { font-size:26px; border:none; background:none; }
   div.goods div.goodsInfo p.addToCart { text-align:right; }
    div.goods div.goodsInfo p.addToCart button { font-size:22px; padding:5px 10px; border:1px solid #eee; background:none; }
   div.goods div.gdsDes { font-size:18px; clear:both; padding-top:30px; }
</style>
	
</head>
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
					<form role="form" method="post">
						<input type="hidden" name="gdsNum" value="${view.gdsNum}" />
					</form>

					<div class="goods">
						<div class="goodsImg">
							<img src="${view.gdsImg}">
						</div>

						<div class="goodsInfo">
							<p class="gdsName">
								<span>상품명 ${view.gdsName}
							</p>

							<p class="cateName">
								<span>카테고리 ${view.cateName}
							</p>

							<p class="gdsPrice">
								<span>가격 <fmt:formatNumber pattern="###,###,###"
										value="${view.gdsPrice}" /> 원 
							</p>

							<p class="gdsStock">
								<span>재고 <fmt:formatNumber pattern="###,###,###"
										value="${view.gdsStock}" /> EA 
							</p>

							<p class="cartStock">
							   <span>구입 수량 
							   <button type="button" class="plus">+</button>
							   <input type="number" class="numBox" min="1" max="${view.gdsStock}" value="1" readonly="readonly"/>
							   <button type="button" class="minus">-</button>
							   
							   <script>
							    $(".plus").click(function(){
							     var num = $(".numBox").val();
							     var plusNum = Number(num) + 1;
							     
							     if(plusNum >= ${view.gdsStock}) {
							      $(".numBox").val(num);
							     } else {
							      $(".numBox").val(plusNum);            
							     }
							    });
							    
							    $(".minus").click(function(){
							     var num = $(".numBox").val();
							     var minusNum = Number(num) - 1;
							     
							     if(minusNum <= 0) {
							      $(".numBox").val(num);
							     } else {
							      $(".numBox").val(minusNum);            
							     }
							    });
							   </script>
							   
							</p>	
						

							<p class="addToCart">
								<button type="button">카트에 담기</button>
							</p>
						</div>

						<div class="gdsDes">${view.gdsDes}</div>
					</div>
					
					<div id="reply">

					   <c:if test="${member == null }">
					    <p>소감을 남기시려면 <a href="/member/signin">로그인</a>해주세요</p>
					   </c:if>
					   
					   <c:if test="${member != null}">
					   <section class="replyForm">
					    <form role="form" method="post" autocomplete="off">
					    <input type="hidden" name="gdsNum" value="${view.gdsNum}">
					     <div class="input_area">
					      <textarea name="repCon" id="repCon"></textarea>
					     </div>
					     
					     <div class="input_area">
					      <button type="submit" id="reply_btn">소감 남기기</button>
					     </div>
					     
					    </form>
					   </section>
					   </c:if>
					   
					   <section class="replyList">
					    <ol>
					     <li>댓글 목록</li>
					       </ol>    
					   </section>
					   <section class="replyList">
						   <ol>
						   <c:forEach items="${reply}" var="reply">
						
						    <li>
						        <div class="userInfo">
						         <span class="userName">${reply.userName} 
						         <span class="date"><fmt:formatDate value="${reply.repDate}" pattern="yyyy-MM-dd" /> 
						        </div>
						        <div class="replyContent">${reply.repCon}</div>
						      </li>
						     </c:forEach>
						    </ol>    
						</section>
					   
					</div>
					
				</section>
			
			<aside id="aside">
				<%@ include file="../include/aside.jsp" %>
			</aside>
			
		</div>
	</section>
	
	<footer id="footer">
		<div id="footer_box">
			<%@ include file="../include/footer.jsp" %>
		</div>
	</footer>
</div>
</body>
<script>

$("#reply_btn").on("click", function() {
    alert("댓글 등록완료");
});


//     $(document).ready(function () {
//         $("#reply_btn").click(function () {
//             var gdsNum = ${view.gdsNum};
//             var repCon = $("#repCon").val();
            
//             $.ajax({
//                 type: "POST",
//                 url: "shop/view",
//                 data: {
//                     gdsNum: gdsNum,
//                     repCon: repCon
//                 },
//                 success: function (response) {
//                     if (response === "Success") {
//                         alert("소감이 성공적으로 제출되었습니다.");
//                         // 소감 제출 후 추가 작업을 수행할 수 있습니다.
//                         // 예를 들어, 화면 갱신 또는 추가 데이터 가져오기 등
//                     } else if (response === "Unauthorized") {
//                         alert("로그인 후 소감을 남길 수 있습니다.");
//                     } else {
//                         alert("소감 제출 중 오류가 발생했습니다.");
//                     }
//                 },
//                 error: function () {
//                     alert("서버와의 통신 중 오류가 발생했습니다.");
//                 }
//             });
//         });
//     });
</script>


</html>
