package kr.or.dw.service;

import java.sql.SQLException;
import java.util.List;

import kr.or.dw.domain.GoodsViewVO;
import kr.or.dw.domain.ReplyListVO;
import kr.or.dw.domain.ReplyVO;

public interface ShopService {

	List<GoodsViewVO> list(int cateCode) throws SQLException;

	GoodsViewVO goodsView(int gdsNum) throws SQLException;

	void registReply(ReplyVO reply) throws SQLException;

	List<ReplyListVO> replyList(int gdsNum) throws SQLException;

	String idCheck(int repNum) throws SQLException;
	
	void deleteReply(ReplyVO reply) throws SQLException;


	

}
