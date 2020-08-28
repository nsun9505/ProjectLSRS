package kr.co.lsrs.mapper;

import org.apache.ibatis.annotations.Select;

public interface TestMapper {
	@Select("SELECT sysdate FROM dual")
	public String getTime();
	
	public String getTime2();
	
	public String getLibrary();
}
