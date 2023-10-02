package kr.or.dw.dao;

import java.sql.SQLClientInfoException;
import java.sql.SQLException;

import javax.servlet.http.HttpSession;

import kr.or.dw.domain.MemberVO;

public interface MemberDAO  {

	void signup(MemberVO vo) throws SQLException;

	MemberVO signin(MemberVO vo) throws SQLException;


}
