package kr.or.dw.service;

import java.sql.SQLException;
import java.util.List;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.dw.command.Criteria;
import kr.or.dw.command.SearchCriteria;
import kr.or.dw.dao.BoardDAO;
import kr.or.dw.domain.BoardVO;
import kr.or.dw.domain.LikeVO;

@Service
public class BoardServiceImpl implements BoardService {
	
	@Autowired
	BoardDAO boardDAO;

	@Override
	public List<BoardVO> list(Criteria cri) throws SQLException {
		
		return boardDAO.list(cri);
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

	@Override
	public int listCount() throws SQLException {
		
		return boardDAO.listCount();
	}

	@Override
	public List<BoardVO> listSearch(SearchCriteria scri) throws SQLException {
		
		return boardDAO.listSearch(scri);
	}

	@Override
	public int countSearch(SearchCriteria scri) throws SQLException {
		// TODO Auto-generated method stub
		return boardDAO.countSearch(scri);
	}

	@Override
	public void viewCnt(int bno) throws SQLException {
		boardDAO.viewCnt(bno);
		
	}

//	@Override
//	public void selectLike(LikeVO like) throws SQLException {
//		boardDAO.selectLike(like);
//		
//	}

	@Override
	public int likeChk(int bno, String userId) throws SQLException {
		
		return boardDAO.likeChk(bno,userId);
	}

	@Override
	public int likeUp(LikeVO like) throws SQLException {
		
		return boardDAO.likeUp(like);
	}
	
	@Override
	public int likeDown(LikeVO like) throws SQLException {
		// TODO Auto-generated method stub
		return boardDAO.likeDown(like);
	}

	

	
	


	
	
}
