package kr.or.dw.controller;

import java.io.PrintWriter;
import java.sql.SQLClientInfoException;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.collections.map.HashedMap;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.dw.domain.CartListVO;
import kr.or.dw.domain.MemberVO;
import kr.or.dw.service.MemberService;

@Controller
@RequestMapping("/member/*")
public class MemberController {
	
	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);
	
	@Inject
	MemberService memberService;
	
	@Autowired
	private JavaMailSender mailSender;
	
	@Autowired
	BCryptPasswordEncoder passEncoder;
	    
	// 회원 가입 get
	@RequestMapping(value = "/signup", method = RequestMethod.GET)
	public void getSignup() throws Exception {
		logger.info("get signup");
	}
	
	
	// 회원 가입 post
	@RequestMapping(value = "/signup", method = RequestMethod.POST)
	public String postSignup(MemberVO vo, String domainselect, HttpServletResponse res) throws Exception {
	 logger.info("post signup");
	 
	 vo.setEmail(vo.getEmail() + domainselect);
	 String inputPass = vo.getUserPass();
	 String pass = passEncoder.encode(inputPass);
	 vo.setUserPass(pass);

	 memberService.signup(vo);
	 
	 res.setContentType("text/html; charset=utf-8");
     PrintWriter out = res.getWriter();
     out.println("<script>");
     out.println("alert('회원가입이 정상적으로 되었습니다.');");
     out.println("</script>");
	 
	 return "redirect:/";
	 
	}
	
	// 로그인  get
	@RequestMapping(value = "/signin", method = RequestMethod.GET)
	public void getSignin() throws Exception {
	   logger.info("get signin");
	}

	// 로그인 post
	@RequestMapping(value = "/signin", method = RequestMethod.POST)
	public String postSignin(MemberVO vo, HttpServletRequest req, RedirectAttributes rttr) throws Exception {
	   logger.info("post signin");
	     
	   MemberVO login = memberService.signin(vo);    
	   HttpSession session = req.getSession();
	   
	   boolean passMatch = passEncoder.matches(vo.getUserPass(), login.getUserPass());
	   
	   if(login != null && passMatch) {
	    session.setAttribute("member", login);
	   } else {
	    session.setAttribute("member", null);
	    rttr.addFlashAttribute("msg", false);
	    return "redirect:/member/signin";
	   }    
	   
	   return "redirect:/";
	}
	    
	// 로그아웃
	@RequestMapping(value = "/signout", method = RequestMethod.GET)
	public String signout(HttpSession session) throws Exception {
	   logger.info("get logout");
	   
	   memberService.signout(session);
	     
	   return "redirect:/";
	}
	
	@RequestMapping(value = "/mailCheck", method = RequestMethod.GET)
	@ResponseBody
	public String mailCheck(String email) throws SQLException {
		return memberService.mailCheck(email);
	}
	
	
	@ResponseBody
	@RequestMapping(value = "/mailChecked" ,method = RequestMethod.GET)
	public String mail(String email, String userName) throws SQLException {
		
		Map<String, String> map = new HashMap<>();
		
		
		map.put("email", email);
		map.put("userName", userName);
		System.out.println(email);
		System.out.println(userName);
		
		
		int num = memberService.getMail(map);
		
		return Integer.toString(num);
	}
	
	// 회원 정보 수정창
	@GetMapping(value= "/modify")
	public void getModify() {
		logger.info("get modify");
	
	}
	
	// 회원정보 수정 포슽
	@RequestMapping(value = "/modify", method = RequestMethod.POST)
	public String postModify(MemberVO vo, HttpSession session) throws SQLException {
	    logger.info("post modify");

	    // Encode the new password
	    String encodedPassword = passEncoder.encode(vo.getUserPass());
	    vo.setUserPass(encodedPassword);

	    // Call the modify method
	    memberService.modify(vo);

	    // Invalidate the session
	    session.invalidate();

	    // Check if the password is not null and matches
	    if (vo.getUserPass() != null && passEncoder.matches(vo.getUserPass(), encodedPassword)) {
	        session.setAttribute("member", vo);
	    }

	    return "redirect:/";
	}
	
	@GetMapping(value="/delete")
	public void getDelete(String userId) {
		
	}
	
	@RequestMapping(value="/delete", method = RequestMethod.POST)
	public String postDelete(String userId) throws SQLException {
		logger.info("post member delete");
		
		memberService.delete(userId);
		
		return "redirect:/";
	}
	
}
