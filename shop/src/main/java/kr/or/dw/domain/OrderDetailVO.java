package kr.or.dw.domain;

import lombok.Data;

@Data
public class OrderDetailVO {
	
	private int orederDetailsNum;
	private String orderId;
	private int gdsNum;
	private int cartStock;
	
	
}
