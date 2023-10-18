package kr.or.dw.service;

import java.sql.SQLException;
import java.util.Map;
import java.util.Random;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import kr.or.dw.dao.MemberDAO;
import kr.or.dw.domain.MemberVO;

@Service
public class MemberServiceImpl implements MemberService {
	
	@Autowired
	MemberDAO memberDAO;
	
	@Autowired
	private JavaMailSender mailSender;
	private int authNumber;
	
	public void makeRandomNumber() {
		
		Random random = new Random();
		int checkNum = random.nextInt(888888) + 111111;
		System.out.println("인증번호 : " + checkNum);
		authNumber = checkNum;
		
	}
	
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

	@Override
	public String mailCheck(String email) throws SQLException {
		makeRandomNumber();
		/* 이메일 보내기 */
        String setFrom = "lsi6930@naver.com";
        String toMail = email;
        String title = "회원가입 인증 이메일 입니다.";
        String content = 
                "홈페이지를 방문해주셔서 감사합니다." +
                "<br><br>" + 
                "인증 번호는 " + authNumber + "입니다." + 
                "<br>" + 
                "해당 인증번호를 인증번호 확인란에 기입하여 주세요.";
        
        try {
            
            MimeMessage message = mailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(message, true, "utf-8");
            helper.setFrom(setFrom);
            helper.setTo(toMail);
            helper.setSubject(title);
            helper.setText(content,true);
            mailSender.send(message);
            
        }catch(Exception e) {
            e.printStackTrace();
        }
        
        return Integer.toString(authNumber);
	 
	}

	@Override
	public int getMail(Map<String, String> map) throws SQLException {
		int num = memberDAO.getMail(map);
		return num;
	}

	@Override
	public void modify(MemberVO vo) throws SQLException {
		memberDAO.modfiy(vo);
		
	}

	@Override
	public void delete(String userId) throws SQLException {
		memberDAO.delete(userId);
		
	}

	@Override
	public MemberVO selectMemberIdCheck(String userId) throws SQLException {
		
		return memberDAO.selectMemberIdCheck(userId);
	}

}
