package kr.or.dw.controller;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.config.CustomEditorConfigurer;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.dw.domain.MemberVO;
import kr.or.dw.handler.ChattingHandler;

@Controller
public class ChatController {
	
	private static final Logger logger = LoggerFactory.getLogger(ChatController.class);
	
	@Inject
	ChattingHandler chattingHandler;
	
	@RequestMapping("/chatting")
	public void chatting(Model model, HttpSession session) {
		
		MemberVO member = (MemberVO) session.getAttribute("member");
		
		session.setMaxInactiveInterval(1800);
		
			logger.info("==================================");
			logger.info("@ChatController, GET Chat / Username : " + member.getUserName());
			model.addAttribute("userid", member.getUserName()); 
			model.addAttribute("session", session);
			System.out.println("session 은 누구냐 : " + session);
			System.out.println("userid의 아이디는 : " + model);
			
	}
		
}
