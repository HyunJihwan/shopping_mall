package kr.or.dw.controller;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.sql.SQLException;
import java.text.DecimalFormat;
import java.util.Calendar;
import java.util.List;

import javax.inject.Inject;
import javax.net.ssl.HttpsURLConnection;
import javax.servlet.http.HttpSession;

import org.apache.xerces.util.URI.MalformedURIException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.slf4j.spi.LocationAwareLogger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kr.or.dw.dao.ShopDAO;
import kr.or.dw.domain.CartListVO;
import kr.or.dw.domain.CartVO;
import kr.or.dw.domain.GoodsViewVO;
import kr.or.dw.domain.MemberVO;
import kr.or.dw.domain.OrderDetailVO;
import kr.or.dw.domain.OrderListVO;
import kr.or.dw.domain.OrderVO;
import kr.or.dw.domain.PaymentVO;
import kr.or.dw.domain.ReplyListVO;
import kr.or.dw.domain.ReplyVO;
import kr.or.dw.kakaopay.ApproveResponse;
import kr.or.dw.kakaopay.ReadyResponse;
import kr.or.dw.service.KakaoPayServiceImpl;
import kr.or.dw.service.ShopService;
import lombok.Setter;

@Controller
@RequestMapping("/shop/*")
public class ShopController {
	
	private static final Logger logger = LoggerFactory.getLogger(ShopController.class);

	@Inject
	ShopService shopService;
	
	@Autowired
	private KakaoPayServiceImpl KakaoPayServiceImpl;
	
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

	// 카트 담기
	@ResponseBody
	@RequestMapping(value = "/view/addCart", method = RequestMethod.POST)
	public int addCart(CartVO cart,HttpSession session) throws SQLException {
		logger.info("post cart insert");
		int result = 0;
		System.out.println("클릭이또안되네하");
		MemberVO member = (MemberVO) session.getAttribute("member");
		
		if(member != null && !member.getUserId().equals("")) {			
			System.out.println("2클릭이또안되네하2");
			cart.setUserId(member.getUserId());
			shopService.addCart(cart);
			result = 1;
		}
		
		return result;
		
	}
	
	// 카트 목록
	@RequestMapping(value = "/cartList", method = RequestMethod.GET)
	public ModelAndView getCartList(HttpSession session,ModelAndView mnv) throws SQLException {
		logger.info("get cart list");
		String url = "/shop/cartList";
		
		
		MemberVO member = (MemberVO) session.getAttribute("member");
		String userId = member.getUserId();
		
		List<CartListVO> cartList = shopService.cartList(userId);
		
		mnv.setViewName(url);
		mnv.addObject("cartList" , cartList);
		
		return mnv;
	}
	
	//카트 삭제
	@ResponseBody
	@RequestMapping(value = "/deleteCart" , method = RequestMethod.POST)
	public int deleteCart(HttpSession session, @RequestParam(value = "chbox[]") List<String> chArr, CartVO cart) throws SQLException {
		logger.info("delete Cart");
		
		MemberVO member = (MemberVO) session.getAttribute("member");
		String userId = member.getUserId();
		
		int result = 0;
		int cartNum = 0;
		
		if(member != null) {
			cart.setUserId(member.getUserId());
			
			for(String i : chArr) {
				cartNum = Integer.parseInt(i);
				cart.setCartNum(cartNum);
				shopService.deleteCart(cart);
			}
			result = 1;
			
		}
		return result;
		
	}
	
	// 주문
	@RequestMapping(value ="/cartList", method = RequestMethod.POST)
	public String order(HttpSession session, OrderVO order, OrderDetailVO orderDetail) throws SQLException {
		logger.info("order");
		
		MemberVO member = (MemberVO) session.getAttribute("member");
		String userId = member.getUserId();
		
		Calendar cal = Calendar.getInstance();
		int year = cal.get(Calendar.YEAR);
		String ym = year + new DecimalFormat("00").format(cal.get(Calendar.MONTH) + 1);
		String ymd = ym + new DecimalFormat("00").format(cal.get(Calendar.DATE));
		String subNum = "";
		
		for(int i=1; i <= 6; i++) {
			subNum += (int)(Math.random() * 10);
		}
		
		String orderId = ymd + "_" + subNum;
		order.setOrderId(orderId);
		order.setUserId(userId);
		
		shopService.orderInfo(order);
		
		orderDetail.setOrderId(orderId);
		shopService.orderInfo_Details(orderDetail);
		
		shopService.cartAllDelete(userId);
		
		return "redirect:/shop/orderList";
	}
	
	
	@GetMapping("kakaopay")
	@ResponseBody
	public String kakaopay() {
		try {
			// 보내는 부분
			URL address = new URL("https://kapi.kakao.com/v1/payment/ready");
			HttpURLConnection connection = (HttpURLConnection) address.openConnection(); // 서버연결
			connection.setRequestMethod("POST");
			connection.setRequestProperty("Authorization", "KakaoAK 8ab01abeaaa82b02965e64d421cc028d"); // 어드민 키
			connection.setRequestProperty("Content-type", "application/x-www-form-urlencoded;charset=utf-8");
			connection.setDoOutput(true); // 서버한테 전달할게 있는지 없는지
			String parameter = "cid=TC0ONETIME" // 가맹점 코드
					+ "&partner_order_id=partner_order_id" // 가맹점 주문번호
					+ "&partner_user_id=partner_user_id" // 가맹점 회원 id
					+ "&item_name=초코파이" // 상품명
					+ "&quantity=1" // 상품 수량
					+ "&total_amount=2200" // 총 금액
					+ "&vat_amount=200" // 부가세
					+ "&tax_free_amount=0" // 상품 비과세 금액
					+ "&approval_url=http://localhost:8080/" // 결제 성공 시
					+ "&fail_url=http://localhost:8080/" // 결제 실패 시
					+ "&cancel_url=http://localhost:8080/"; // 결제 취소 시
			OutputStream send = connection.getOutputStream(); // 이제 뭔가를 를 줄 수 있다.
			DataOutputStream dataSend = new DataOutputStream(send); // 이제 데이터를 줄 수 있다.
			dataSend.writeBytes(parameter); // OutputStream은 데이터를 바이트 형식으로 주고 받기로 약속되어 있다. (형변환)
			dataSend.close(); // flush가 자동으로 호출이 되고 닫는다. (보내고 비우고 닫다)
			
			System.out.println(parameter);
			int result = connection.getResponseCode(); // 전송 잘 됐나 안됐나 번호를 받는다.
			InputStream receive; // 받다
			
			if(result == 200) {
				receive = connection.getInputStream();
			}else {
				receive = connection.getErrorStream(); 
			}
			// 읽는 부분
			InputStreamReader read = new InputStreamReader(receive); // 받은걸 읽는다.
			BufferedReader change = new BufferedReader(read); // 바이트를 읽기 위해 형변환 버퍼리더는 실제로 형변환을 위해 존제하는 클레스는 아니다.
			// 받는 부분
			return change.readLine(); // 문자열로 형변환을 알아서 해주고 찍어낸다 그리고 본인은 비워진다.
			
		} catch (MalformedURLException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return "";
	}
	
// 카카오페이 결제.
//	@ResponseBody
//	@GetMapping("/kakopay")
//	public ReadyResponse payReady(ApproveResponse ap, OrderVO order, PaymentVO pay, int totalAmount, HttpSession session,Model model) throws SQLException {
//		
//		MemberVO member = (MemberVO) session.getAttribute("member");
//		String userId = member.getUserId();
//		
//		List<CartListVO> cartList = shopService.cartList(userId);
//		
//		ReadyResponse readyResponse = KakaoPayServiceImpl.payReady(ap.getItem_name(),ap.getQuantity(),userId, totalAmount);
//		logger.info("결제 고유번호: " + readyResponse.getTid());
//		logger.info("결제 요청 url : " + readyResponse.getNext_redirect_pc_url());
//		
//		return readyResponse;
//	}
	
	
	
	
	// 주문 목록
	@RequestMapping(value = "/orderList", method = RequestMethod.GET)
	public ModelAndView getOrderList(ModelAndView mnv,HttpSession session, OrderVO order) throws SQLException {
		logger.info("get order list");
		
		String url = "/shop/orderList";
		
		MemberVO member = (MemberVO) session.getAttribute("member");
		String userId = member.getUserId();
		
		order.setUserId(userId);
		
		List<OrderVO> orderList = shopService.orderList(order);
		mnv.setViewName(url);
		mnv.addObject("orderList", orderList);
		
		return mnv;
	}
	
	// 주문 상세 정보
	@RequestMapping(value ="/orderView", method = RequestMethod.GET)
	public ModelAndView getOrderList(HttpSession session, @RequestParam("n") String orderId, OrderVO order, ModelAndView mnv ) throws SQLException {
		
		logger.info("get order view");
		String url = "/shop/orderView";
		
		MemberVO member = (MemberVO) session.getAttribute("member");
		String userId = member.getUserId();
		
		order.setUserId(userId);
		order.setOrderId(orderId);
		
		List<OrderListVO> orderView = shopService.orderView(order);
		System.out.println("나는오더 뷰 " + orderView);
		
		mnv.setViewName(url);
		mnv.addObject("orderView", orderView);
		
		return mnv;
		
		
	}
	
	
}
