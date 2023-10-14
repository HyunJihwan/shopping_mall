package kr.or.dw.domain;

import java.util.Date;

import lombok.Data;

@Data
public class BoardVO {
	
	private int bno;
	private String title;
	private String content;
	private String userId;
	private Date regDate;
	private int viewCnt;
	
	private String userName;
	private int rownum;
}
