package kr.or.dw.dao;

import java.sql.SQLException;
import java.util.List;

import kr.or.dw.domain.BoardReplyVO;

public interface ReplyDAO {
	
	// 댓글 리스트
	List<BoardReplyVO> list(int bno) throws SQLException;
	
	// 댓글 구현
	void write(BoardReplyVO reply) throws SQLException;
	

	
	
	
}
