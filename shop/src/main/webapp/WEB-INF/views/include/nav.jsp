<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<ul>
<c:if test="${member == null}">
   <li>
    <a href="/member/signin">로그인</a>
   </li>
   <li>
    <a href="/member/signup">회원가입</a>
   </li>
</c:if>

<!-- <li> -->
<!-- 	<a href="/board/list">게시판</a> -->
<!-- </li> -->
<li>
	<a href="/board/listSearch">게시판</a>
</li>

<c:if test="${member != null }">
<li>
	<button type="button" id="chatting" class="btn btn-primary">채 팅</button>
</li>
</c:if>


<c:if test="${member != null}">
	
	<c:if test="${member.verify == 9}">
<li>
   <a href="/admin/index">관리자 화면</a>   
</li>   
</c:if>
   <li>
    ${member.userName}님 환영합니다.
   </li>
   <li>
   	<a href="/shop/cartList">카트 리스트</a>
   </li>
   <li>
   	<a href="/shop/orderList">주문 리스트</a>
   </li>
   <li>
    <a href="/member/modify">회원정보 수정</a>
   </li>
   <li>
    <a href="/member/signout">로그아웃</a>
   </li>
</c:if>
</ul>

<script>
$(document).ready(function() {
    // 페이지 로드 후 실행할 코드
    $("#chatting").click(function() {
        OpenWindow("/chatting", "채 팅 방 임", 600, 600);
    });
});

	
	function OpenWindow(UrlStr, WinTitle, WinWidth, WinHeight){
		winleft = (screen.width - WinWidth) / 2;
		wintop = (screen.height - WinHeight) / 2;
		var win = window.open(UrlStr, WinTitle, "scrollbars=yes,width=" + WinWidth+", "
								+ "height=" + WinHeight + ",top="+ wintop + ",left="
								+ winleft + ",resizable=yes,status=yes");
		win.focus();
		return win;
	};

	</script>		