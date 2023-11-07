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
        }
        .input-group {
            margin-top: 10px;
        }
    </style>
</head>
<body>
   <div class="container">
	<div class="col-6">
		<label><b>채팅방</b></label>
	</div>
	<div>
		<div id="msgArea" class="col">
		
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

//전송 버튼 누르는 이벤트
$("#button-send").on("click", function(e) {
    sendMessage();
    $('#msg').val('');
});

var firstConnection = true; // 처음 연결 여부를 나타내는 변수

var sock = new SockJS('http://localhost:8080/ChattingHandler');
sock.onmessage = onMessage;
sock.onopen = onOpen;
sock.onclose = onClose;

function sendMessage() {
    sock.send($("#msg").val());
}

// 서버에서 메시지를 받았을 때
function onMessage(msg) {
    if (firstConnection) {
        firstConnection = false; // 첫 연결 메시지 무시
        return;
    }

    var data = msg.data;
    var sessionId = null;
    var message = null;
    var arr = data.split(":");

    for (var i = 0; i < arr.length; i++) {
        console.log('arr[' + i + ']: ' + arr[i]);
    }

    var cur_session = '${member.userName}';
    console.log("cur_session : " + cur_session);
    sessionId = arr[0];
    message = arr[1];

    var str = "<div class='col-6'>";
    if (sessionId == cur_session) {
        str += "<div class='alert alert-secondary'>";
    } else {
        str += "<div class='alert alert-warning'>";
    }
    str += "<b>" + sessionId + " : " + message + "</b>";
    str += "</div></div>";

    $("#msgArea").append(str);
}

// 채팅창에 들어왔을 때
function onOpen(evt) {
    firstConnection = false; // 연결 시 처음 연결 메시지 무시
    var user = '${member.userName}';
    var str = user + "님이 입장하셨습니다.";
    $("#msgArea").append(str);
}

// 채팅창에서 나갔을 때
function onClose(evt) {
    var user = '${member.userName}';
    var str = user + " 님이 퇴장하셨습니다.";
    $("#msgArea").append(str);
}


</script>

</html>