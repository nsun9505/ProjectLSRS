package kr.co.lsrs.domain;

import lombok.Data;

@Data
public class AuthVO {
	private Integer libraryId;
	private String userId;
	private Integer authId;
}
