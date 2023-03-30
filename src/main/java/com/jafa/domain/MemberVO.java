package com.jafa.domain;

import java.io.Serializable;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class MemberVO implements Serializable {
	private Long mno; 
	private String memberId; 
	private String memberName; 
	private String password; 
	private String email;
	private String phoneNumber;
	private boolean enabled;
	private List<AuthVO> authList;
}
