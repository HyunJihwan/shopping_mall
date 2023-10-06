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
//	public void getView(@RequestParam("n") int gdsNum, Model model) {
//		
//		logger.info("get view");
//		
//		GoodsViewVO view = shopService.goodsView(gdsNum);
//		model.addAttribute("view" , view);
//	}
	
	// 상품조회 
	@RequestMapping(value = "/view", method = RequestMethod.GET)
	public ModelAndView getView(@RequestParam("n") int gdsNum, ModelAndView mnv) throws SQLException {
		
		String url = "/shop/view";
	    logger.info("get view");

	    GoodsViewVO view = shopService.goodsView(gdsNum);

	    mnv.addObject("view", view); // 모델에 데이터 추가
	    mnv.setViewName(url); // 뷰 이름 설정
	    
	    List<ReplyListVO> reply = shopService.replyList(gdsNum);
	    mnv.addObject("reply", reply);
	    
	    return mnv;
	}
	
	@RequestMapping(value = "/view", method = RequestMethod.POST)
	public String registReply(ReplyVO reply, HttpSession session) throws SQLException {
		logger.info("regist reply");
		
		MemberVO member = (MemberVO)session.getAttribute("member");
		reply.setUserId(member.getUserId());
		
		shopService.registReply(reply);
		
		return "redirect:/shop/view?n=" + reply.getGdsNum();
	}
	
//	@RequestMapping(value = "/view", method = RequestMethod.POST)
//	public ResponseEntity<String> registReply(@RequestBody ReplyVO reply, HttpSession session)  {
//	    logger.info("regist reply");
//
//	    MemberVO member = (MemberVO) session.getAttribute("member");
//	    reply.setUserId(member.getUserId());
//
//	    try {
//	        shopService.registReply(reply);
//	        if (reply.getUserId() != null) {
//	            return new ResponseEntity<>("Success", HttpStatus.OK);
//	        } else {
//	            return new ResponseEntity<>("Error", HttpStatus.INTERNAL_SERVER_ERROR);
//	        }
//	    } catch (SQLException e) {
//	        // 예외 처리를 원하는 대로 수행하세요.
//	    }
//		return null;
//	}


	
	
	
}
