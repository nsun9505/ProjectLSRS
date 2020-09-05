package kr.co.lsrs.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.log4j.Log4j;

@RequestMapping("/user")
@Controller
@Log4j
public class UserController {
	@GetMapping("/login")
	public void loginInput(String error, String logout, Model model) {
		if(error != null)
			model.addAttribute("error", "아이디와 비밀번호를 확인하십시오.");
		
		if(logout != null)
			model.addAttribute("logout", "로그아웃되었습니다.");
	}
	
	@GetMapping("/register")
	public String getRegister() {
		return "user/register";
	}
	
	@PostMapping("/register")
	public String register() {
		log.info("register : post");
		return "redirect:/user/login";
	}
	
	@GetMapping("/admin")
	public String adminPage() {
		return "user/admin";
	}
}
