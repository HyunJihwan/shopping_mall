package kr.or.dw.controller;

import java.io.PrintWriter;

import javax.inject.Inject;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;



import kr.or.dw.domain.MemberVO;
import kr.or.dw.service.MemberService;

@Controller
@RequestMapping("/member/*")
public class MemberController {
	
	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);
	
	@Inject
	MemberService memberService;

	@Autowired
	BCryptPasswordEncoder passEncoder;
	    
	// 회원 가입 get
	@RequestMapping(value = "/signup", method = RequestMethod.GET)
	public void getSignup() throws Exception {
		logger.info("get signup");
	}
	
	
	// 회원 가입  post
	@RequestMapping(value = "/signup", method = RequestMethod.POST)
	public String postSignup(MemberVO vo, Model model) throws Exception {
	   logger.info("post signup");
	    
	   String inputPass = vo.getUserPass();
	   String pass = passEncoder.encode(inputPass);
	   vo.setUserPass(pass);

	   memberService.signup(vo);
	   
	   // 회원가입 성공 메시지를 모델에 추가
	   model.addAttribute("message", "회원가입이 정상적으로 되었습니다.");
	   
	   return "redirect:/";
	}

	
}
