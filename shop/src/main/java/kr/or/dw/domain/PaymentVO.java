package kr.or.dw.domain;

import java.util.Date;

import lombok.Data;

@Data
public class PaymentVO {
	
	private Integer pay_code;
	private Long oder_code;
	private String pay_method;
	private Date pay_date;
	private int pay_tot_price;
	private int pay_rest_price;
	private String pay_nobank_user;
	private String pay_nobank;
	
}
