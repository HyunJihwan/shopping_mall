package kr.or.dw.service;

import java.sql.SQLException;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.dw.dao.MemberDAO;
import kr.or.dw.domain.MemberVO;

@Service
public class MemberServiceImpl implements MemberService {
	
	@Autowired
	MemberDAO memberDAO;
	
	@Override
	public void signup(MemberVO vo) throws SQLException {
		
		memberDAO.signup(vo);
		
	}

	@Override
	public MemberVO signin(MemberVO vo) throws SQLException {
		
		return memberDAO.signin(vo);
	}

	@Override
	public void signout(HttpSession session) throws SQLException {
		session.invalidate();
	}

}
