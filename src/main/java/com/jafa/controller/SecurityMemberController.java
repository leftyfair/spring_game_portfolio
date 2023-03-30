package com.jafa.controller;

import java.util.List;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.Errors;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.jafa.domain.AuthList;
import com.jafa.domain.AuthListDTO;
import com.jafa.domain.AuthVO;
import com.jafa.domain.MemberDTO;
import com.jafa.domain.MemberType;
import com.jafa.domain.MemberVO;
import com.jafa.service.MemberService;
import com.jafa.validation.MemberDTOValidator;

import lombok.extern.log4j.Log4j;

@Log4j
@Controller
@RequestMapping("/member")
public class SecurityMemberController {

	@Autowired
	MemberService memberService; 
	
	@GetMapping("/all")
	public void doAll() {
		log.info("모두 접근 허용");
	}
	
	@GetMapping("/member")
	public void doMember() {
		log.info("로그인한 사용자만 접근 가능");
	}

	@GetMapping("/accessError")
	public void accessError() {
		log.info("접근이 거부됨.");
		// member/accessError.jsp 생성
	}
	
	@RequestMapping("/login")
	public String login(Authentication authentication, RedirectAttributes rttr) {
		log.info("로그인 페이지");
		if(authentication!=null && authentication.isAuthenticated()) {
			rttr.addFlashAttribute("loginOn", "이미 로그인한 상태입니다.");
			return "redirect:/";
		}
		return "/member/login";
	}
	
//	@PostMapping("/join")
//	public String join(MemberVO vo, Errors errors,
//			RedirectAttributes rttr) {
//		if(errors.hasErrors()) {
//			return "/member/join";
//		}
//		memberService.join(vo);
//		log.info(vo);
//		return "redirect:/";
//	}
	
	// 회원가입 처리
	@PostMapping("/join")
	public String join(@Valid MemberDTO dto, Errors errors,
			RedirectAttributes rttr) {
		if(errors.hasErrors()) {
			return "/member/join";
		}
		log.info(dto);
		memberService.join(dto);
		return "redirect:/";
	}
	
	@InitBinder
	protected void initBinder(WebDataBinder binder) {
		binder.setValidator(new MemberDTOValidator());
	}
	
	// 회원가입폼
	@GetMapping("/join")
	public void joinForm() {
		
	}
	
	//회원가입처리
//	@PostMapping("/join")
//	public String join(@RequestParam("attachFile") MultipartFile[] multipartFiles,MemberVO vo,RedirectAttributes rttr 
//			) {
//		System.out.println(vo);
//		System.out.println(multipartFiles);
//		for(MultipartFile m : multipartFiles) {
//			System.out.println(m.getOriginalFilename());
//		}
//		memberService.join(vo);
//		return "redirect:/";
//	}
	
	@PostMapping("/save")
	public String doAdmin(@ModelAttribute("authList") AuthList authList, RedirectAttributes rttr) {
	    List<AuthVO> authVOList = authList.getAuthList();
	    for (AuthVO auth : authVOList) {
	        memberService.updateMemberType(auth.getMemberId(), auth.getMemberType());
	    }
	    rttr.addFlashAttribute("updateMember", "등급변경");
	    return "redirect:admin";
	}
	
	// 관리자 페이지에서 회원목록 조회 
	@PreAuthorize("hasAnyRole('ROLE_REGULAR_MEMBER','ROLE_ASSOCIATE_MEMBER')")
	@GetMapping("/admin")
	public void doAdmin(Model model) {
		log.info("관리자만 접근가능");
		List<MemberVO> memberList = memberService.memberList();
		model.addAttribute("list", memberList);
		model.addAttribute("mType", MemberType.values());
	}
	
	// 회원등급변경
	@PreAuthorize("hasAnyRole('ROLE_REGULAR_MEMBER','ROLE_ASSOCIATE_MEMBER')")
	@PostMapping("/upadteMemberType")
	public String updateMemberType(AuthListDTO authListDTO, RedirectAttributes rttr) {
		log.info(authListDTO.getAuthList());
		List<AuthVO> authList = authListDTO.getAuthList();
		for(AuthVO vo : authList) {
			if(vo.getMemberId()!=null&&vo.getMemberType()!=null){
				memberService.updateMemberType(vo);
			}
		}
		rttr.addFlashAttribute("updateMember", "등급변경");
		return "redirect:/member/admin";
	}
	
}
