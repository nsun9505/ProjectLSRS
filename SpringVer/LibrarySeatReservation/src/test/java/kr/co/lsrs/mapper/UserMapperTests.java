package kr.co.lsrs.mapper;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import kr.co.lsrs.domain.UserVO;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"file:src/main/webapp/WEB-INF/spring/root-context.xml"})
@Log4j
public class UserMapperTests {
	@Setter(onMethod_ = @Autowired)
	private UserMapper mapper;
	
	@Test
	public void testRead() {
		UserVO vo = mapper.read("test");
		log.info(vo + "\n");
		vo.getAuthList().forEach(authVo -> log.info(authVo.getLibraryId() + " " + authVo.getUserId() + " " + authVo.getAuthId() + "\n"));
	}
}
