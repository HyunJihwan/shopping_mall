package kr.or.dw.service;

import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.dw.dao.ReplyDAO;
import kr.or.dw.domain.BoardReplyVO;

@Service
public class ReplyServiceImpl implements ReplyService {
	
	@Autowired
	private ReplyDAO replyDAO;
	
	@Override
	public List<BoardReplyVO> list(int bno) throws SQLException {
		
		return replyDAO.list(bno);
	}

	@Override
	public void wrtie(BoardReplyVO reply) throws SQLException {
		replyDAO.write(reply);
		
	}

	@Override
	public void replyUpdate(BoardReplyVO vo) throws SQLException {
		replyDAO.replyUdpate(vo);
		
	}

	@Override
	public void replyDelete(BoardReplyVO vo) throws SQLException {
		replyDAO.replyDelete(vo);
		
	}
	

	@Override
	public BoardReplyVO replySelect(BoardReplyVO vo) throws SQLException {
		
		return replyDAO.replySelect(vo);
	}


	

	
	


		
	
}
