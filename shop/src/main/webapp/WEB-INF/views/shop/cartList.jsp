<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
	<title>지환 Home</title>
	<script src="/resources/jquery/jquery-3.3.1.min.js"></script>
<link rel="stylesheet" href="/resources/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet"
	href="/resources/bootstrap/css/bootstrap-theme.min.css">
<script src="/resources/bootstrap/js/bootstrap.min.js"></script>
<script src="/resources/ckeditor/ckeditor.js"></script>
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
   /*
   section#content ul li { display:inline-block; margin:10px; }
   section#content div.goodsThumb img { width:200px; height:200px; }
   section#content div.goodsName { padding:10px 0; text-align:center; }
   section#content div.goodsName a { color:#000; }
   */
   section#content ul li {
    margin: 10px 0; border-bottom:1px solid #999;
}

section#content ul li img {
    width: 200px;
    height: 200px;
}

section#content ul li::after {
    content: "";
    display: block;
    clear: both;
}

section#content div.thumb {
    float: left;
    width: 250px;
}

section#content div.gdsInfo {
    float: right;
    width: calc(100% - 320px);
    font-size: 20px;
    line-height: 2;
}

section#content div.gdsInfo span {
    display: inline-block;
    width: 100px;
    font-weight: bold;
    margin-right: 10px;
}

section#content div.gdsInfo .delete {
    text-align: right;
}

section#content div.gdsInfo .delete button {
    font-size: 15px;
    padding: 5px 10px;
    border: 1px solid #eee;
    background: #eee;
    color: #333; /* 버튼 텍스트 색상 추가 */
    cursor: pointer;
    transition: background-color 0.3s, color 0.3s; /* 버튼 텍스트 색상 전환 효과 추가 */
}

section#content div.gdsInfo .delete button:hover {
    background: #333;
    color: #eee;
}

.allCheck { float:left; width:200px; }
.allCheck input { width:16px; height:16px; }
.allCheck label { margin-left:10px; }
.delBtn { float:right; width:300px; text-align:right; }
.delBtn button { font-size:15px; padding:5px 10px; border:1px solid #eee; background:#eee;}

.checkBox { float:left; width:30px; }
.checkBox input { width:16px; height:16px; }

.listResult { padding:20px; background:#eee; }
.listResult .sum { float:left; width:45%; font-size:22px; }

.listResult .orderOpne { float:right; width:45%; text-align:right; }
.listResult .orderOpne button { font-size:18px; padding:5px 10px; border:1px solid #999; background:#fff;}
.listResult::after { content:""; display:block; clear:both; }

.orderInfo { border:5px solid #eee; padding:20px; display: none; }
.orderInfo .inputArea { margin:10px 0; }
.orderInfo .inputArea label { display:inline-block; width:120px; margin-right:10px; }
.orderInfo .inputArea input { font-size:14px; padding:5px; }
#userAddr2, #userAddr3 { width:250px; }

.orderInfo .inputArea:last-child { margin-top:30px; }
.orderInfo .inputArea button { font-size:20px; border:2px solid #ccc; padding:5px 10px; background:#fff; margin-right:20px;}

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
				  <ul>
			   <li>
			    <div class="allCheck">
			     <input type="checkbox" name="allCheck" id="allCheck" /><label for="allCheck">모두 선택</label>   
		</div>
    
    <script>
		$("#allCheck").on("click",function(){
			var chk = $("#allCheck").prop("checked");
			if(chk){
				$(".chBox").prop("checked",true);
			}else{
				$(".chBox").prop("checked",false);
			}
		})
    </script>
    
    
    <div class="delBtn">
     <button type="button" class="selectDel_btn">선택 삭제</button>   
    </div>
    
    <script>
		$(".selectDel_btn").click(function(){
			var confirm_val = confirm("정말 삭제하시겠습니까?");

			if(confirm_val){
				var checkArr = new Array();

				$("input[class='chBox']:checked").each(function(){
					checkArr.push($(this).attr("data-cartNum"));
				});

				$.ajax({
					url : "/shop/deleteCart",
					type : "post",
					data : { chbox : checkArr },
					success : function(result){
						if(result == 1){
						alert("삭제를 성공하였습니다!");
						location.href = "/shop/cartList";
						}else{
							alert("삭제를 실패했습니다!");
						}
					}

				});
			}

		});

    </script>
    
   </li>
   
  
   <c:set var="sum" value="0"/>
   
   <c:forEach items="${cartList}" var="cartList" varStatus="status">
    <c:if test="${status.first}">
   <li>
    <div class="checkBox">
     <input type="checkbox" name="chBox" class="chBox" data-cartNum="${cartList.cartNum}" />
    </div>
   	
   	<script>
		$(".chBox").on("click",function(){
			$("#allCheck").prop("checked",false);
		})
   	</script>
   	
    <div class="thumb">
     <img src="${cartList.gdsThumbImg}" />
    </div>
    <div class="gdsInfo">
     
		
	
     <p>
      <span style="width: 100%;">상품명 : ${cartList.gdsName}<br />
      <span style="width: 100%;">개당 가격 : <fmt:formatNumber pattern="###,###,###" value="${cartList.gdsPrice}" /> 원<br />
      <span style="width: 100%;">구입 수량 : ${cartList.cartStock} 개<br />
      <span style="width: 100%;">최종 가격 :  <fmt:formatNumber pattern="###,###,###" value="${cartList.gdsPrice * cartList.cartStock}" /> 원
     </p>
    
   
     <div class="delete">
      <button type="button" class="delete_${cartList.cartNum }_btn" data-cartNum="${cartList.cartNum}">삭제</button>
     	<script>
     	$(".delete_${cartList.cartNum}_btn").click(function(){
     	   var confirm_val = confirm("단일 상품을 삭제하시겠습니까?");
     	   
     	   if(confirm_val) {
     	    var checkArr = new Array();
     	    
     	    checkArr.push($(this).attr("data-cartNum"));
     	               
     	    $.ajax({
     	     url : "/shop/deleteCart",
     	     type : "post",
     	     data : { chbox : checkArr },
     	     success : function(result){
     	      if(result == 1) {     
     	       location.href = "/shop/cartList";
     	      } else {
     	       alert("삭제 실패");
     	      }
     	     }
     	    });
     	   } 
     	  });
     	</script>
     
     </div>
    </div>     
   </li>
   <c:set var="sum" value="${sum + (cartList.gdsPrice * cartList.cartStock)}"/>
   </c:if>
   </c:forEach>
   
   <div class="listReuslt">
   		<div class="sum" style="font-size: 20px; font: bolder;">
   		<strong>
   			총 합계 : <fmt:formatNumber pattern="###,###,###" value="${sum }"/> 원
   		</strong>
   		</div>
   		<div class="orderOpen">
   			<button type="button" class="orderOpen_btn btn btn-primary">주문 정보 입력</button>	<!-- 주문 정보 입력창 -->
   		<script>
		$(".orderOpen_btn").on("click",function(){
			$(".orderInfo").slideDown();
			$(".orderOpen_btn").slideUp();
		});
     </script>
   		
   		</div>	
   </div>
   
   <div class="orderInfo">
   <form role="form" method="post" autocomplete="off">
      
    <input type="hidden" name="amount" value="${sum}" />
      
    <div class="inputArea">
     <label for="">수령인</label>
     <input type="text" name="orderRec" id="orderRec" required="required" />
    </div>
    
    <div class="inputArea">
     <label for="orderPhon">수령인 연락처</label>
     <input type="text" name="orderPhon" id="orderPhon" required="required" />
    </div>
    
    <div class="inputArea">
    	<p>
    	<input type="text" id="sample3_postcode" placeholder="우편번호">
		<input type="button" onclick="sample3_execDaumPostcode()" value="우편번호 찾기"><br>
		</p>
		<p>
		<input type="text" id="sample3_address"  name="userAddr1" placeholder="주소"><br>
		<input type="text" id="sample3_detailAddress" name="userAddr2" placeholder="상세주소">
		<input type="text" id="sample3_extraAddress" name="userAddr3" placeholder="참고항목">
		</p>
		
		<div id="wrap" style="display:none;border:1px solid;width:500px;height:300px;margin:5px 0;position:relative">
		<img src="//t1.daumcdn.net/postcode/resource/images/close.png" id="btnFoldWrap" style="cursor:pointer;position:absolute;right:0px;top:-1px;z-index:1" onclick="foldDaumPostcode()" alt="접기 버튼">
		</div>

<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    // 우편번호 찾기 찾기 화면을 넣을 element
    var element_wrap = document.getElementById('wrap');

    function foldDaumPostcode() {
        // iframe을 넣은 element를 안보이게 한다.
        element_wrap.style.display = 'none';
    }

    function sample3_execDaumPostcode() {
        // 현재 scroll 위치를 저장해놓는다.
        var currentScroll = Math.max(document.body.scrollTop, document.documentElement.scrollTop);
        new daum.Postcode({
            oncomplete: function(data) {
                // 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 조합된 참고항목을 해당 필드에 넣는다.
                    document.getElementById("sample3_extraAddress").value = extraAddr;
                
                } else {
                    document.getElementById("sample3_extraAddress").value = '';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('sample3_postcode').value = data.zonecode;
                document.getElementById("sample3_address").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("sample3_detailAddress").focus();

                // iframe을 넣은 element를 안보이게 한다.
                // (autoClose:false 기능을 이용한다면, 아래 코드를 제거해야 화면에서 사라지지 않는다.)
                element_wrap.style.display = 'none';

                // 우편번호 찾기 화면이 보이기 이전으로 scroll 위치를 되돌린다.
                document.body.scrollTop = currentScroll;
            },
            // 우편번호 찾기 화면 크기가 조정되었을때 실행할 코드를 작성하는 부분. iframe을 넣은 element의 높이값을 조정한다.
            onresize : function(size) {
                element_wrap.style.height = size.height+'px';
            },
            width : '100%',
            height : '100%'
        }).embed(element_wrap);

        // iframe을 넣은 element를 보이게 한다.
        element_wrap.style.display = 'block';
    }
</script>
    </div>
    
    
    <div class="inputArea">
     <button type="submit" class="order_btn">주문</button>
     <button type="button" class="cancel_btn">취소</button>   
     
     <script>
		$(".cancel_btn").on("click", function(){
			$(".orderInfo").slideUp();
			$(".orderOpen_btn").slideDown();
		});
     </script>
     
    </div>
   </form>   
</div>
   
</ul>
	</section>
			
			
			<aside id="aside">
				<%@ include file="../include/aside.jsp" %>
			</aside>
			
		</div>
	</section>
	
	
	
<!-- 	<footer id="footer"> -->
<!-- 		<div id="footer_box"> -->
<%-- 			<%@ include file="../include/footer.jsp" %> --%>
<!-- 		</div> -->
<!-- 	</footer> -->
	 <footer class="py-3 my-4" id="footer_box">
  		<%@ include file="../include/footer.jsp" %>
 
  	</footer>

</div>
</body>
</html>
