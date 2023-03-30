package com.jafa.repository;

import java.util.List;

import com.jafa.domain.BoardVO;

public interface BoardRepository {

	// 목록
	List<BoardVO> list();
	
	// 글쓰기
	void write(BoardVO vo);

	// 상세
	BoardVO detail(Long bno);
	
	// 삭제
	void remove(Long bno);

	// 수정
	void modify(BoardVO vo);
	
	void modifyOnlyContent(BoardVO vo);
}
