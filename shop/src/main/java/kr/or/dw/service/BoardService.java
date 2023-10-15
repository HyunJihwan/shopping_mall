package kr.or.dw.service;

import java.sql.SQLException;
import java.util.List;

import kr.or.dw.command.Criteria;
import kr.or.dw.command.SearchCriteria;
import kr.or.dw.domain.BoardReplyVO;
import kr.or.dw.domain.BoardVO;

public interface BoardService {
	
	// 게시판 리스트

	List<BoardVO> list(Criteria cri) throws SQLException;

	void write(BoardVO vo) throws SQLException;
	
	// 게시글 상세 조회
	BoardVO view(int bno) throws SQLException;
	
	// 게시글 수정
	void modify(BoardVO board) throws SQLException;
	
	// 게시글 삭제
	void delete(int bno) throws SQLException;

	BoardVO getBoard(int bno) throws SQLException;

	int listCount()throws SQLException;

	List<BoardVO> listSearch(SearchCriteria scri) throws SQLException;
	
	int countSearch(SearchCriteria scri) throws SQLException;

	



}
