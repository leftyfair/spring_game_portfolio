package com.jafa.repository;

import static org.junit.Assert.*;

import java.util.ArrayList;
import java.util.List;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import com.jafa.AppTest;
import com.jafa.domain.GameVO;

public class GameRepositoryTest extends AppTest{

	@Autowired
	GameRepository gameRepository;
	
	@Test
	public void test() {
		GameVO vo = GameVO.builder()
				.gno((long) 1)
				.title("test")
				.content("contest")
				.price(20000)
				.volSize("150g")
				.developer("rockstar")
				.build();
		gameRepository.write(vo);
//		gameRepository.list();
		
				
				
	}

}
