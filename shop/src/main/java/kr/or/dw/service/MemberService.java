package kr.or.dw.service;

import java.sql.SQLClientInfoException;
import java.sql.SQLException;
import java.util.Map;

import javax.servlet.http.HttpSession;

import kr.or.dw.domain.MemberVO;

public interface MemberService {

	public void signup(MemberVO vo) throws SQLException;

	public MemberVO signin(MemberVO vo) throws SQLException;

	public void signout(HttpSession session) throws SQLException;

	public String mailCheck(String email) throws SQLException;

	public int getMail(Map<String, String> map) throws SQLException;

	public void modify(MemberVO vo) throws SQLException;

	public void delete(String userId) throws SQLException;

	public MemberVO selectMemberIdCheck(String userId) throws SQLException;

}
