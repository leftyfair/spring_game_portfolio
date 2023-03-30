package com.jafa.repository;

import java.util.List;

import com.jafa.domain.Category;
import com.jafa.domain.Criteria;
import com.jafa.domain.GameVO;

public interface GameRepository {

	// 목록
	List<GameVO> list(Criteria criteria);
	
	// 게시판 카테고리
	List<Category> getCateList();
	
	// 글쓰기
	void write(GameVO vo);

	// 상세
	GameVO detail(Long gno);
	
	// 삭제
	void remove(Long gno);

	// 수정
	void modify(GameVO vo);
	
	void modifyOnlyContent(GameVO vo);

	int getTotalCount(Criteria criteria);
	
	// 카테고리
	void createCategory(Category category);

	void updateCategory(Category category);

	void deleteCategory(String cid);
	
	
}
