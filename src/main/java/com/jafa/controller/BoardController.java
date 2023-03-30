package com.jafa.controller;

import java.io.File;
import java.io.IOException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.jafa.domain.BoardVO;
import com.jafa.domain.BoardVO.FileType;
import com.jafa.repository.BoardRepository;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/board")
@Log4j
public class BoardController {
	
	@Autowired
	private BoardRepository repository;
	
	// 목록
	@GetMapping("/list")
	public String list(Model model) {
		model.addAttribute("list", repository.list());
		return "board/list";
	}
	
	// 상세
	@GetMapping("/detail")
	public String detail(Model model, Long bno) {
		model.addAttribute("b", repository.detail(bno));
		return "board/detail";
	}
	
	// 글쓰기폼
	@GetMapping("/write")
	public void writeForm() {
		
	}

	// 글쓰기처리
	@PostMapping("/write")
	public String write(BoardVO vo, 
			@RequestParam("attachFile") MultipartFile multipartFile, RedirectAttributes rttr) {
		
		if(!multipartFile.isEmpty()) { // 첨부파일이 있을때
			String fileName = multipartFile.getOriginalFilename(); // 첨부파일 이름
			vo.setFileName(fileName); 
			// 파일타입 결정 : IMAGE, OTHER
			if (multipartFile.getContentType().startsWith("image")) { // 이미지 파일일 때
				vo.setFileType(FileType.IMAGE);
			} else { // 이미지파일이 아닐때
				vo.setFileType(FileType.OTHER);
			}
			repository.write(vo); // 데이터 베이스에 저장
			
			// c:/file01_repo/1/호랑이.png
			// 업로드
			uploadPath(vo, multipartFile);
			
		} else { // 첨부파일이 없을때
			repository.write(vo);
		}
		return "redirect:/board/list";
	}

	// 삭제
	@PostMapping("/remove")
	public String remove(Long bno) {
		BoardVO vo = repository.detail(bno);
		if(vo.getFileName() != null) {
			// 파일 삭제
			File file = new File("c:/file01_repo/" + bno, vo.getFileName());
			File folder = new File("c:/file01_repo/" + bno);
			file.delete();
			folder.delete();
		}
		repository.remove(bno);
		return "redirect:/board/list";
	}

	// 수정폼
	@GetMapping("/modify")
	public void modifyForm(Long bno, Model model) {
		BoardVO vo = repository.detail(bno);
		model.addAttribute("b", vo);
	}
	
	// 수정처리
	@PostMapping("/modify")
	public String modify(BoardVO vo, RedirectAttributes rttr, 
			@RequestParam(defaultValue = "false") Boolean delChk,
			@RequestParam("attachFile") MultipartFile multipartFile) {
		System.out.println(delChk);
		if(delChk) {
			// 파일 삭제 및 내용 변경
			// 파일 삭제
			BoardVO detail = repository.detail(vo.getBno()); // vo는 신규파일 detail 기존파일
			File file = new File("c:/file01_repo/" + detail.getBno() + "/" + detail.getFileName());
			File folder = new File("c:/file01_repo/" + detail.getBno());
			file.delete();
			folder.delete();
			
			// modify 호출
			repository.modify(vo);
		} else {
			
			if(!multipartFile.isEmpty()) { // 이미지 및 내용 변경
				
				// 기존 파일 삭제
				BoardVO detail = repository.detail(vo.getBno()); // vo는 신규파일 detail 기존파일
				File file = new File("c:/file01_repo/" + detail.getBno() + "/" + detail.getFileName());
				file.delete();
				
				// 새로운 파일 업로드
				String fileName = multipartFile.getOriginalFilename(); // 첨부파일 이름
				vo.setFileName(fileName); 
				
				// 파일타입 결정 : IMAGE, OTHER
				if (multipartFile.getContentType().startsWith("image")) { // 이미지 파일일 때
					vo.setFileType(FileType.IMAGE);
				} else { // 이미지파일이 아닐때
					vo.setFileType(FileType.OTHER);
				}
				
				uploadPath(detail, multipartFile);
				
				// modify 호출
				repository.modify(vo);
			} else { // 내용만 변경
				// modifyOnlyContent 호출
				repository.modifyOnlyContent(vo);
			}
		}
		return "redirect:/board/list";
	}
	
	public void uploadPath(BoardVO vo, MultipartFile multipartFile) {
		String fileName = multipartFile.getOriginalFilename();
		File uploadPath = new File("c:/file01_repo/"+vo.getBno());
		
		if (!uploadPath.exists()) { // 업로드 패스 생성
			uploadPath.mkdirs(); 
		}
		// 업로드 파일경로 지정
		File uploadFile = new File(uploadPath,fileName);
		try {
			multipartFile.transferTo(uploadFile); // 파일 업로드
		} catch (IllegalStateException | IOException e) {
			e.printStackTrace();
		}
	}
	
}



