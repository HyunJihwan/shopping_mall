package kr.or.dw.security;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import kr.or.dw.domain.MemberVO;

public class User implements UserDetails{
	
	private MemberVO member;
	public User(MemberVO member) {
		this.member = member;
	}
	
	@Override
	public Collection<? extends GrantedAuthority> getAuthorities() {	// 권한 찾아오기
		List<GrantedAuthority> roles = new ArrayList<GrantedAuthority>();
		roles.add(new SimpleGrantedAuthority(member.getAuthority()));
		return roles;
	}

	@Override
	public String getPassword() {	// 비밀번호 찾아오기
		
		return member.getUserPass();
	}

	@Override
	public String getUsername() {	// 아이디 찾아오기
		return member.getUserId();
	}

	@Override
	public boolean isAccountNonExpired() {	// 기간제 계정의 경우 기간만료 여부
		return true;
	}

	

	@Override
	public boolean isCredentialsNonExpired() {	// 인증정보 만료 여부
		return true;
	}

	
	
	public MemberVO getMemberVO() {
		return this.member;
	}
}
