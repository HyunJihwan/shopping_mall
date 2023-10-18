package kr.or.dw.dao;

import java.sql.SQLException;
import java.util.List;

import kr.or.dw.command.Criteria;
import kr.or.dw.command.SearchCriteria;
import kr.or.dw.domain.BoardVO;

public interface BoardDAO {
	
	
	List<BoardVO> list(Criteria cri) throws SQLException;

	void write(BoardVO vo) throws SQLException;
	
	// 게시글 상세 조회
	BoardVO view(int bno) throws SQLException;
	
	// 게시글 수정
	void modify(BoardVO board) throws SQLException;
	
	// 게시글 삭제
	void delete(int bno) throws SQLException;
	
	// 
	BoardVO getBoard(int bno) throws SQLException;

	int listCount() throws SQLException;
	
	// 게시판 페이지네이션 
	List<BoardVO> listSearch(SearchCriteria scri) throws SQLException;
	
	// 갯수
	int countSearch(SearchCriteria scri) throws SQLException;

	void viewCnt(int bno) throws SQLException;
	
	

	

}
