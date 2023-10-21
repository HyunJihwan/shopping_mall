package kr.or.dw.domain;

import lombok.Data;

@Data
public class LikeVO {
	
	private int bno;
	private int like_no;
	private String userId;
	private int cnt;
	private int heart;
}
