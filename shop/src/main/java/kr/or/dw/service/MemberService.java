package kr.or.dw.service;

import java.sql.SQLClientInfoException;
import java.sql.SQLException;

import javax.servlet.http.HttpSession;

import kr.or.dw.domain.MemberVO;

public interface MemberService {

	public void signup(MemberVO vo) throws SQLException;

	public MemberVO signin(MemberVO vo) throws SQLException;

	public void signout(HttpSession session) throws SQLException;

}
