package kr.co.lsrs.domain;

import lombok.Data;

@Data
public class SmsVO {
	private String phNum;
	private String authNum;
	private String statusCode;
}
