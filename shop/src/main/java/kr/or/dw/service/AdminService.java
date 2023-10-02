package kr.or.dw.service;

import java.sql.SQLException;
import java.util.List;

import kr.or.dw.domain.CategoryVO;
import kr.or.dw.domain.GoodsVO;

public interface AdminService {
	
	// 카테고리 
	List<CategoryVO> category() throws SQLException;
	
	// 상품 등록
	void register(GoodsVO vo) throws SQLException;
	
	// 상품 목록
	List<GoodsVO> goodslist() throws SQLException;

}
