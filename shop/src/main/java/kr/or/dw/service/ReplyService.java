package kr.or.dw.service;

import java.sql.SQLException;
import java.util.List;

import kr.or.dw.domain.BoardReplyVO;

public interface ReplyService {
	
	// 댓글 목록
	List<BoardReplyVO> list(int bno) throws SQLException;
	
	// 댓글 추가
	void wrtie(BoardReplyVO reply) throws SQLException;

	void replyUpdate(BoardReplyVO vo) throws SQLException;
	
	// 댓글 삭제
	void replyDelete(BoardReplyVO vo) throws SQLException;
	
	BoardReplyVO replySelect(BoardReplyVO vo) throws SQLException;


	
	
	
	
	
	
}
