package kr.or.dw.service;

import java.sql.SQLException;
import java.util.List;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.dw.dao.BoardDAO;
import kr.or.dw.domain.BoardVO;

@Service
public class BoardServiceImpl implements BoardService {
	
	@Autowired
	BoardDAO boardDAO;

	@Override
	public List<BoardVO> list() throws SQLException {
		
		return boardDAO.list();
	}

	@Override
	public void write(BoardVO vo) throws SQLException {
		boardDAO.write(vo);
		
	}

	@Override
	public BoardVO view(int bno) throws SQLException {
		
		return boardDAO.view(bno);
	}

	@Override
	public void modify(BoardVO board) throws SQLException {
		boardDAO.modify(board);
		
	}

	@Override
	public void delete(int bno) throws SQLException {
		boardDAO.delete(bno);
		
	}

	@Override
	public BoardVO getBoard(int bno) throws SQLException {
		return boardDAO.getBoard(bno);
		 
	}

	
	
}
