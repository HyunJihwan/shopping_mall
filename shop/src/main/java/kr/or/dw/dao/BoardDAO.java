package kr.or.dw.dao;

import java.sql.SQLException;
import java.util.List;

import kr.or.dw.domain.BoardVO;

public interface BoardDAO {
	
	
	List<BoardVO> list() throws SQLException;

	void write(BoardVO vo) throws SQLException;
	
	// 게시글 상세 조회
	BoardVO view(int bno) throws SQLException;
	
	// 게시글 수정
	void modify(BoardVO board) throws SQLException;
	
	// 게시글 삭제
	void delete(int bno) throws SQLException;
	
	// 
	BoardVO getBoard(int bno) throws SQLException;
	
	

}
