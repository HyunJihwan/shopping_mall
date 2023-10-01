package kr.or.dw.service;

import java.sql.SQLClientInfoException;
import java.sql.SQLException;

import kr.or.dw.domain.MemberVO;

public interface MemberService {

	public void signup(MemberVO vo) throws SQLException;

}
