package kr.or.dw.dao;

import java.sql.SQLException;
import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.or.dw.domain.BoardReplyVO;

@Repository
public class ReplyDAOImpl implements ReplyDAO{
	
	@Inject
	private SqlSession sql;
	
	private static String namespace = "kr.or.dw.mappers.replyMapper";

	@Override
	public List<BoardReplyVO> list(int bno) throws SQLException {
		
		return sql.selectList(namespace + ".list", bno);
	}

	@Override
	public void write(BoardReplyVO reply) throws SQLException {
		sql.insert(namespace + ".reply", reply);
		
	}

	@Override
	public void replyUdpate(BoardReplyVO vo) throws SQLException {
		sql.update(namespace + ".replyUpdate", vo); 
		
	}

	@Override
	public void replyDelete(BoardReplyVO vo) throws SQLException {
		sql.delete(namespace + ".replyDelete", vo);
		
	}


	@Override
	public BoardReplyVO replySelect(BoardReplyVO vo) throws SQLException {
		
		return sql.selectOne(namespace + ".replySelect", vo);
	}


	
	
	
	
}
