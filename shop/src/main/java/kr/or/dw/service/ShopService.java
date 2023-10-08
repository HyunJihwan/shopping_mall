package kr.or.dw.service;

import java.sql.SQLException;
import java.util.List;

import kr.or.dw.domain.GoodsViewVO;
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


	

}