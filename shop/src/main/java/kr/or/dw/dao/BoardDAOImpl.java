package kr.or.dw.dao;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.sun.mail.imap.protocol.Namespaces.Namespace;

import kr.or.dw.command.Criteria;
import kr.or.dw.command.SearchCriteria;
import kr.or.dw.domain.BoardVO;
import kr.or.dw.domain.LikeVO;

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

	@Override
	public List<BoardVO> listSearch(SearchCriteria scri) throws SQLException {
		
		return sql.selectList(namespace + ".listSearch", scri);
	}

	@Override
	public int countSearch(SearchCriteria scri) throws SQLException {
		return sql.selectOne(namespace + ".countSearch", scri);
	}

	@Override
	public void viewCnt(int bno) throws SQLException {
		sql.update(namespace + ".viewCnt", bno);
		
	}

//	@Override
//	public void selectLike(LikeVO like) throws SQLException {
//		sql.selectOne(namespace + ".selectLike", like);
//		
//	}

	@Override
	public int likeChk(int bno, String userId) throws SQLException {
		Map<String, Object> dataMap = new HashMap<>();
		dataMap.put("bno", bno);
		dataMap.put("userId", userId);
		
		return sql.selectOne(namespace + ".likeChk" ,dataMap);

	}

	@Override
	public int likeUp(LikeVO like) throws SQLException {
		// TODO Auto-generated method stub
		return sql.insert(namespace + ".likeUp" ,like);
	}

	@Override
	public int likeDown(LikeVO like) throws SQLException {
		// TODO Auto-generated method stub
		return sql.delete(namespace + ".likeDown", like);
	}

	



	
	
}
