package kr.or.dw.service;

import java.sql.SQLException;
import java.util.List;

import kr.or.dw.domain.CategoryVO;
import kr.or.dw.domain.GoodsVO;
import kr.or.dw.domain.GoodsViewVO;
import kr.or.dw.domain.OrderListVO;
import kr.or.dw.domain.OrderVO;

public interface AdminService {
	
	// 카테고리 
	List<CategoryVO> category() throws SQLException;
	
	// 상품 등록
	void register(GoodsVO vo) throws SQLException;
	
	// 상품 목록
	List<GoodsViewVO> goodslist() throws SQLException;
	
	// 상품 조회
	GoodsViewVO goodsView(int gdsNum) throws SQLException;
	
	// 상품 수정
	void goodsModify(GoodsVO vo) throws SQLException;
	
	// 상품 삭제
	void goodsDelete(int gdsNum) throws SQLException;
	
	// 주문 목록
	List<OrderVO> orderList() throws SQLException;
	
	// 특정 주문 목록
	List<OrderListVO> orderView(OrderVO order) throws SQLException;
	
	// 주문 상세변경
	void delivery(OrderVO order) throws SQLException;

}
