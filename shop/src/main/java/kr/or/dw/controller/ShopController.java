package kr.or.dw.controller;

import java.sql.SQLException;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.slf4j.spi.LocationAwareLogger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kr.or.dw.dao.ShopDAO;
import kr.or.dw.domain.GoodsViewVO;
import kr.or.dw.domain.MemberVO;
import kr.or.dw.domain.ReplyListVO;
import kr.or.dw.domain.ReplyVO;
import kr.or.dw.service.ShopService;

@Controller
@RequestMapping("/shop/*")
public class ShopController {
	
	private static final Logger logger = LoggerFactory.getLogger(ShopController.class);

	@Inject
	ShopService shopService;
	
	// 카테고리별 상품 리스트 : 1차 분류
	
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public void getList(@RequestParam("c") int cateCode, @RequestParam("l") int level, Model model) throws SQLException {
		logger.info("get l list");
		
		List<GoodsViewVO> list = null;
		
		list = shopService.list(cateCode);
		
		model.addAttribute("list",list);
	}
	
//	@RequestMapping(value = "/view" , method = RequestMethod.GET)
//	public void getView(@RequestParam("n") int gdsNum, Model model) throws SQLException {
//		
//		logger.info("get view");
//		
//		GoodsViewVO view = shopService.goodsView(gdsNum);
//		model.addAttribute("view" , view);
//	}
	
	
	// 상품조회  ModelAndView 작성
	@RequestMapping(value = "/view", method = RequestMethod.GET)
	public ModelAndView getView(@RequestParam("n") int gdsNum, ModelAndView mnv) throws SQLException {
		
		String url = "/shop/view";
	    logger.info("get view");

	    GoodsViewVO view = shopService.goodsView(gdsNum);
	    
	    mnv.addObject("view", view); // 모델에 데이터 추가
	    mnv.setViewName(url); // 뷰 이름 설정
	    
//	    List<ReplyListVO> reply = shopService.replyList(gdsNum);
//	    mnv.addObject("reply", reply);
	    
	    return mnv;
	}
	
	// 상품 댓글 달기
	
//	@RequestMapping(value = "/view", method = RequestMethod.POST)
//	public String registReply(ReplyVO reply, HttpSession session) throws SQLException {
//		logger.info("regist reply");
//		
//		MemberVO member = (MemberVO)session.getAttribute("member");
//		reply.setUserId(member.getUserId());
//		
//		shopService.registReply(reply);
//		
//		return "redirect:/shop/view?n=" + reply.getGdsNum();
//	}
	
	// 상품댓글달기  ajax
	@ResponseBody
	@RequestMapping(value = "/view/registReply", method = RequestMethod.POST)
	public void registReply(ReplyVO reply, HttpSession session) throws Exception {
	   logger.info("regist reply");
	   
	   System.out.println("등록할건데1");
	   MemberVO member = (MemberVO)session.getAttribute("member");
	   System.out.println("등록할건데2");
	   reply.setUserId(member.getUserId());
	   System.out.println("등록할건데3");
	   shopService.registReply(reply);
	   
	}
	
	// 댓글리스트 ajax
	@ResponseBody
	@RequestMapping(value = "/view/replyList", method = RequestMethod.GET)
	public List<ReplyListVO> getReplyList(@RequestParam("n") int gdsNum) throws SQLException {
		logger.info("get reply list");
		System.out.println("왜 안됨1");
		List<ReplyListVO> reply = shopService.replyList(gdsNum);
		System.out.println("왜 안됨2");
		return reply;
		
	}
	
	

	
	// 상품 소감(댓글) 삭제
	@ResponseBody
	@RequestMapping(value = "/view/deleteReply", method = RequestMethod.POST)
	public int getReplyList(ReplyVO reply,  HttpSession session) throws Exception {
	   logger.info("post delete reply");

	   int result = 0;
	   
	   MemberVO member = (MemberVO)session.getAttribute("member");
	   String userId = shopService.idCheck(reply.getRepNum());
	   
	   System.out.println("위의 유저아이디" + userId);
	   System.out.println("멤버유저아이디 : " + member.getUserId());
	   
	   if(member.getUserId().equals(userId) && !member.getUserId().equals("")) {
	    System.out.println("리절트의 값 " + result);
	    reply.setUserId(member.getUserId());
	    shopService.deleteReply(reply);
	    
	    result = 1;
	  
	   }
	   
	   return result;   
	}

	// 상품 소감 (댓글) 수정
	@ResponseBody
	@RequestMapping(value = "/view/modifyReply", method = RequestMethod.POST)
	public int modifyReply(ReplyVO reply, HttpSession session) throws SQLException {
		logger.info("modify reply");
		
		int result = 0;
		
		MemberVO member = (MemberVO) session.getAttribute("member");
		
		String userId = shopService.idCheck(reply.getRepNum());
		
		System.out.println("위의 유저아이디" + userId);
		System.out.println("멤버유저아이디 : " + member.getUserId());
		
		if(member.getUserId().equals(userId)) {
			reply.setUserId(member.getUserId());
			shopService.modifyReply(reply);
			result = 1;
		}
		return result;
	}

	
	
}