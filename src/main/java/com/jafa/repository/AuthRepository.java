package com.jafa.repository;

import org.apache.ibatis.exceptions.TooManyResultsException;

import com.jafa.domain.AuthVO;

public interface AuthRepository {
	// 회원등급
	void save(AuthVO vo);
	
	void remove(String memberId);

//	AuthVO findByMemberId(String memberId);
	
	AuthVO findByMemberId(String memberId) throws TooManyResultsException;
}
