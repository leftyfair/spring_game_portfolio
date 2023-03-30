package com.jafa.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jafa.domain.Criteria;
import com.jafa.domain.ReplyVO;
import com.jafa.repository.ReplyRepository;

@Service
public class ReplyServiceImpl implements ReplyService {

	@Autowired
	ReplyRepository replyRepository;
	
	@Override
	public int register(ReplyVO vo) {
		return replyRepository.insert(vo);
	}

	@Override
	public ReplyVO get(Long rno) {
		return replyRepository.read(rno);
	}

	@Override
	public int modify(ReplyVO reply) {
		return replyRepository.update(reply);
	}

	@Override
	public int remove(Long rno) {
		return replyRepository.delete(rno);
	}
	
	@Override
	public List<ReplyVO> getList(Criteria cri, Long bno) {
		return replyRepository.getListWithPaging(cri, bno);
	}

}
