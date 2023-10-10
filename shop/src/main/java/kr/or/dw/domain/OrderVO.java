package kr.or.dw.domain;

import lombok.Data;

@Data
public class OrderVO {
	
	private String orderId;
	private String userId;
	private String orderRec;
	private String userAddr1;
	private String userAddr2;
	private String userAddr3;
	private String orderPhon;
	private int amount;
	private String orderDate;
	
	
}
