package kr.co.lsrs.domain;

import java.util.List;

import lombok.Data;

@Data
public class UserVO {
	private String userid;
	private String userpw;
	private String username;
	private String phnum;
	private String addr;
	private boolean enabled;
	
	private List<AuthVO> authList;
}
