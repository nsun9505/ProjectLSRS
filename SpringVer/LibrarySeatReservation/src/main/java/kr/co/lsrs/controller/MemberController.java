package kr.co.lsrs.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
public class MemberController {
	@GetMapping("/loginPage")
	public void loginInput(String error, String logout, Model model) {
		if(error != null)
			model.addAttribute("error", "아이디와 비밀번호를 확인하십시오.");
		
		if(logout != null)
			model.addAttribute("logout", "로그아웃되었습니다.");
	}
}
