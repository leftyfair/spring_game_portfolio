package com.jafa.service;

import java.util.List;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.jafa.domain.AuthVO;
import com.jafa.domain.MemberDTO;
import com.jafa.domain.MemberType;
import com.jafa.domain.MemberVO;
import com.jafa.repository.AuthRepository;
import com.jafa.repository.MemberRepository;

@Service
public class MemberService {
	@Autowired
	MemberRepository memberRepository;
	
	@Autowired
	AuthRepository authRepository; 
	
	@Autowired
	PasswordEncoder passwordEncoder;
	
	// 회원가입
	@Transactional
	public void join(@Valid MemberDTO dto) {
		String encodedPassword = passwordEncoder.encode(dto.getPassword());
		dto.setPassword(encodedPassword);
		memberRepository.save(dto);
		AuthVO authVO = AuthVO.builder()
				.memberId(dto.getMemberId())
				.memberType(MemberType.ROLE_ASSOCIATE_MEMBER)
				.ordinal(MemberType.ROLE_ASSOCIATE_MEMBER.ordinal())
				.build();
		authRepository.save(authVO);
	}

	@Transactional
	public void updateMemberType(AuthVO authVO) {
		String memberId = authVO.getMemberId(); // 변경할 회원 아이디
		MemberType memberType = authVO.getMemberType(); // 변경할 회원 등급
		
		// 회원의 기존 등급 정보를 삭제
		authRepository.remove(memberId);
		
		// 변경할 등급부터 모든 등급에 대해 AuthVO를 생성하고 저장
		MemberType[] types = MemberType.values();
		for(int i=memberType.ordinal(); i<types.length;i++) {
			AuthVO vo = AuthVO.builder()
				.memberId(memberId)
				.memberType(types[i])
				.ordinal(types[i].ordinal())
				.build();
			authRepository.save(vo);
		}
	}

	public List<MemberVO> memberList(){
		return memberRepository.memberList();
	}

	@Transactional
	public void updateMemberType(String memberId, MemberType memberType) {
		AuthVO authVO = authRepository.findByMemberId(memberId);
		if(authVO != null) {
			authVO.setMemberType(memberType);
			authRepository.save(authVO);
		}
	}
}
