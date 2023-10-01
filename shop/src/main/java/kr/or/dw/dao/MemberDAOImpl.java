package kr.or.dw.dao;

import java.sql.SQLException;

import javax.inject.Inject;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import kr.or.dw.domain.MemberVO;

@Repository
public class MemberDAOImpl implements MemberDAO {
	
	@Inject
	private SqlSession sql;
	
	//매퍼
	private static String namespace = "kr.or.dw.mappers.memberMapper";
	
	@Override
	public void signup(MemberVO vo) throws SQLException {
		sql.insert(namespace + ".signup",vo);
	}
	
	
	
}
