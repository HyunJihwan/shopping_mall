package kr.or.dw.dao;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.sun.mail.imap.protocol.Namespaces.Namespace;

import kr.or.dw.command.Criteria;
import kr.or.dw.command.SearchCriteria;
import kr.or.dw.domain.BoardVO;

@Repository
public class BoardDAOImpl implements BoardDAO {
	
	@Inject
	private SqlSession sql;
	
	private static String namespace = "kr.or.dw.mappers.boardMapper";

	@Override
	public List<BoardVO> list(Criteria cri) throws SQLException {
		
		return sql.selectList(namespace + ".list", cri);
	}

	@Override
	public void write(BoardVO vo) throws SQLException {
		String userId = vo.getUserId().trim();
		vo.setUserId(userId);
		sql.insert(namespace + ".write", vo);
		
	}

	@Override
	public BoardVO view(int bno) throws SQLException {
		
		return sql.selectOne(namespace + ".view", bno);
	}

	@Override
	public void modify(BoardVO board) throws SQLException {
		
		sql.update(namespace + ".modify", board);
		
	}

	@Override
	public void delete(int bno) throws SQLException {
		sql.delete(namespace + ".delete", bno);
		
	}

	@Override
	public BoardVO getBoard(int bno) throws SQLException {
		
		return sql.selectOne(namespace + ".getBoard",bno);
	}

	@Override
	public int listCount() throws SQLException {
		
		return sql.selectOne(namespace + ".listCount");
	}

	
	
}
