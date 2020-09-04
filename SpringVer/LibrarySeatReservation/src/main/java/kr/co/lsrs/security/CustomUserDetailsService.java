package kr.co.lsrs.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.InternalAuthenticationServiceException;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import kr.co.lsrs.domain.UserVO;
import kr.co.lsrs.mapper.UserMapper;
import kr.co.lsrs.security.domain.CustomUser;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
public class CustomUserDetailsService implements UserDetailsService{
	@Setter(onMethod_ = @Autowired)
	private UserMapper userMapper;

	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException{
		log.warn("Load User by UserName : " + username);
		
		UserVO vo = userMapper.read(username);
		
		log.warn("queried by user mapper : " + vo);
		
		if(vo == null) {
			throw new UsernameNotFoundException("Not Found User");
		}
		
		return new CustomUser(vo);
	}
	
	
}
