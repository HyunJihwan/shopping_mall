package kr.or.dw.service;

import java.sql.SQLException;
import java.util.List;

import kr.or.dw.domain.CartListVO;
import kr.or.dw.domain.CartVO;
import kr.or.dw.domain.GoodsViewVO;
import kr.or.dw.domain.OrderDetailVO;
import kr.or.dw.domain.OrderListVO;
import kr.or.dw.domain.OrderVO;
import kr.or.dw.domain.ReplyListVO;
import kr.or.dw.domain.ReplyVO;

public interface ShopService {

	List<GoodsViewVO> list(int cateCode) throws SQLException;

	GoodsViewVO goodsView(int gdsNum) throws SQLException;
	
	// 댓글 달기
	void registReply(ReplyVO reply) throws SQLException;
	
	// 댓글 목록
	List<ReplyListVO> replyList(int gdsNum) throws SQLException;

	// 댓글 삭제
	void deleteReply(ReplyVO reply) throws SQLException;
	
	// 아이디 체크 
	String idCheck(int repNum) throws SQLException;
	
	// 댓글 수정
	void modifyReply(ReplyVO reply) throws SQLException;
	
	// 상품 담기
	void addCart(CartVO cart) throws SQLException;
	
	// 상품 조회
	List<CartListVO> cartList(String userId) throws SQLException;
	
	// 상품 삭제
	void deleteCart(CartVO cart) throws SQLException;
	
	// 주문
	void orderInfo(OrderVO order) throws SQLException;
	
	// 주문 상세
	void orderInfo_Details(OrderDetailVO orderDetail) throws SQLException;
	
	// 카트 비우기
	void cartAllDelete(String userId) throws SQLException;
	
	// 주문 목록
	List<OrderVO> orderList(OrderVO order) throws SQLException;
	
	// 주문 상세
	List<OrderListVO> orderView(OrderVO order) throws SQLException;


	

}
