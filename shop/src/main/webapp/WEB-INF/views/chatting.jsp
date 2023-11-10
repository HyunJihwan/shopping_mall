<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<head>
    <meta charset="UTF-8">
     <title>채팅방</title>
    <script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
        body {
            background-color: #f2f2f2;
            margin: 0;
            padding: 0;
        }
        .container {
            max-width: 800px;
            margin: 0 auto;
            padding: 20px;
            background-color: #fff;
            border: 1px solid #ddd;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
        }
        .chat-box {
            border: 1px solid #ddd;
            padding: 10px;
            margin: 10px 0;
            border-radius: 5px;
            height: 400px; /* 채팅 박스 높이 조정 */
            overflow-y: scroll; /* 스크롤 추가 */
        }
        .input-group {
            margin-top: 10px;
        }
        /* 버튼 스타일 추가 */
        #button-send {
            background-color: #007BFF;
            color: white;
            border: none;
        }
    </style>
</head>
<body>
   <div class="container">
	<div class="col-6">
		<label><b>채팅방</b></label>
	</div>
	<div>
		<input type="hidden" value="${member.userName }">
		<div id="msgArea" class="chat-box"> <!-- 클래스 변경 -->
		
		</div>
		<div class="col-6">
		<div class="input-group mb-3">
			<input type="text" id="msg" class="form-control" aria-label="Recipient's username" aria-describedby="button-addon2">
			<div class="input-group-append">
				<button class="btn btn-outline-secondary" type="button" id="button-send">전송</button>
			</div>
		</div>
		</div>
	</div>
	<div class="col-6">
	</div>
</div>
</body>
<script type="text/javascript">

///전송 버튼 누르는 이벤트
$("#button-send").on("click", function(e) {
	sendMessage();
	$('#msg').val('')
});

let sock = new SockJS('http://172.30.1.37:8080/chatting');
sock.onmessage = onMessage;
sock.onclose = onClose;
sock.onopen = onOpen;

function sendMessage() {
	sock.send($("#msg").val());
}
//서버에서 메시지를 받았을 때
function onMessage(msg) {
	
	var data = msg.data;
	var sessionId = null; //데이터를 보낸 사람
	var message = null;
	
	var arr = data.split(":");
	
	for(var i=0; i<arr.length; i++){
		console.log('arr[' + i + ']: ' + arr[i]);
	}
	
	var cur_session = '${userid}'; //현재 세션에 로그인 한 사람
	console.log("cur_session : " + cur_session);
	
	sessionId = arr[0];
	message = arr[1];
	
    //로그인 한 클라이언트와 타 클라이언트를 분류하기 위함
	if(sessionId == cur_session){
		
		var str = "<div class='col-6'>";
		str += "<div class='alert alert-secondary'>";
		str += "<b>" + sessionId + " : " + message + "</b>";
		str += "</div></div>";
		
		$("#msgArea").append(str);
	}
	else{
		
		var str = "<div class='col-6'>";
		str += "<div class='alert alert-warning'>";
		str += "<b>" + sessionId + " : " + message + "</b>";
		str += "</div></div>";
		
		$("#msgArea").append(str);
	}
	
}
//채팅창에서 나갔을 때
function onClose(evt) {
	
	var userout = '${member.userName}';
	var str = userout + "님이 퇴장하셨습니다.";
	
	$("#msgArea").append(str);
}

//채팅창에 들어왔을 때
function onOpen(evt) {
	
	var userin = '${member.userName}';
	var str = userin + "님이 입장하셨습니다.";
	
	$("#msgArea").append(str);
}

</script>

</html>