package com.jafa.domain;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class MemberDTO { // 이용자가 입력한 값이랑 일치해야함 
	private String memberId;
	private String memberName;
	private String password; // 비밀번호
	private String confirmPassword; // 비밀번호 확인
	private String email;
	private String phoneNumber;
}
