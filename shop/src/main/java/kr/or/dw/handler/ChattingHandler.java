package kr.or.dw.handler;

import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;


public class ChattingHandler extends TextWebSocketHandler{
		
	private static final Logger logger = LoggerFactory.getLogger(ChattingHandler.class);
	
	private List<WebSocketSession> sessionList = new ArrayList<WebSocketSession>();
	
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		System.out.println("진입1");
		logger.info("#ChattingHandler, afterConnectionEstablished");
		sessionList.add(session);
		
		logger.info(session.getPrincipal().getName() + "님이 입장하셨습니다.");
	}
	
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		
		logger.info("#ChattingHandler, handleMessage");
		logger.info(session.getId() + ": " + message);
		
		for(WebSocketSession s : sessionList) {
			s.sendMessage(new TextMessage(session.getPrincipal().getName() + ":" + message.getPayload()));
		}
	}
	
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		
		logger.info("#ChattingHandler, afterConnectionClosed");

		sessionList.remove(session);
		
		logger.info(session.getPrincipal().getName() + "님이 퇴장하셨습니다.");
	}
	
	
}