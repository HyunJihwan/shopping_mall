package kr.or.dw.domain;

import java.util.Date;

import lombok.Data;

@Data
public class CartVO {
	
	private int cartNum;
	private String userId;
	private int gdsNum;
	private int cartStock;
	private Date addDate;
	
}
