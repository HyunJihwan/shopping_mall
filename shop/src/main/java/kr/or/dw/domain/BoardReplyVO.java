package kr.or.dw.domain;

import java.util.Date;

import lombok.Data;

@Data
public class BoardReplyVO {
	
	private int rno;
	private int bno;
	private String content;
	private String userId;
	private Date regDate;
	
	private String userName;
	private int depth;
	private int parent_no;
	private String deleted;
}
