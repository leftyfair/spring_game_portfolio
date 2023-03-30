package com.jafa.controller;

import java.io.File;
import java.io.IOException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.jafa.domain.Category;
import com.jafa.domain.Criteria;
import com.jafa.domain.GameVO;
import com.jafa.domain.GameVO.FileType;
import com.jafa.domain.Pagination;
import com.jafa.repository.GameRepository;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/game")
@Log4j
public class GameController {
	
		@Autowired
		GameRepository gameRepository;
		
		@ModelAttribute("cateList")
		public List<Category> cateList() {
			return gameRepository.getCateList();
		}
		
		@GetMapping("/cate")
		public String home(Model model) {
			model.addAttribute("cateList", gameRepository.getCateList());
			gameRepository.getCateList();
			return "game/cateWrite";
		}
		
		@PostMapping("/addCate")
		public String addCategory(Category category) {
			gameRepository.createCategory(category);
			return "redirect:cate";
		}
	
//		@GetMapping(value =  {"/list/{cid}", "/list"})
//		public String list(@ModelAttribute("cri") Criteria criteria, Model model,
//				@PathVariable(required = false) String cid) {
//			model.addAttribute("game", gameRepository.list(cid));
//			return "game/gameList";
//		}
		
		@GetMapping(value =  {"/list/{cid}", "/list"})
		public String list(@ModelAttribute("cri") Criteria criteria, Model model,
				@PathVariable(required = false) String cid, Category category) {
			criteria.setCategory(category);
			model.addAttribute("game", gameRepository.list(criteria))
				.addAttribute("p", new Pagination(criteria, gameRepository.getTotalCount(criteria)));
			log.info(criteria);
			return "game/gameList";
		}
		
		@GetMapping("/detail")
		public String detail(Model model, Long gno) {
			model.addAttribute("gd", gameRepository.detail(gno));
			return "game/gameDetail";
		}
		
		// 글쓰기폼
		@GetMapping("/write")
		public String writeForm() {
			return "game/gameWrite";
		}

		// 글쓰기처리
		@PostMapping("/write")
		public String write(GameVO vo, 
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
				gameRepository.write(vo); // 데이터 베이스에 저장
				
				// c:/file01_repo/1/호랑이.png
				// 업로드
				uploadPath(vo, multipartFile);
				
			} else { // 첨부파일이 없을때
				gameRepository.write(vo);
			}
			return "redirect:/game/list";
		}
		
		// 삭제
		@PostMapping("/remove")
		public String remove(Long gno) {
			GameVO vo = gameRepository.detail(gno);
			if(vo.getFileName() != null) {
				// 파일 삭제
				File file = new File("c:/file03_repo/" + gno, vo.getFileName());
				File folder = new File("c:/file03_repo/" + gno);
				file.delete();
				folder.delete();
			}
			gameRepository.remove(gno);
			return "redirect:/game/list";
		}
		
		
		// 수정폼
		@GetMapping("/modify")
		public String modifyForm(Long gno, Model model) {
			GameVO vo = gameRepository.detail(gno);
			model.addAttribute("b", vo);
			return "game/gameModify";
		}
		
		// 수정처리
		@PostMapping("/modify")
		public String modify(GameVO vo, RedirectAttributes rttr, 
				@RequestParam(defaultValue = "false") Boolean delChk,
				@RequestParam("attachFile") MultipartFile multipartFile) {
			System.out.println(delChk);
			if(delChk) {
				// 파일 삭제 및 내용 변경
				// 파일 삭제
				GameVO detail = gameRepository.detail(vo.getGno()); // vo는 신규파일 detail 기존파일
				File file = new File("c:/file03_repo/" + detail.getGno() + "/" + detail.getFileName());
				File folder = new File("c:/file03_repo/" + detail.getGno());
				file.delete();
				folder.delete();
				
				// modify 호출
				gameRepository.modify(vo);
			} else {
				
				if(!multipartFile.isEmpty()) { // 이미지 및 내용 변경
					
					// 기존 파일 삭제
					GameVO detail = gameRepository.detail(vo.getGno()); // vo는 신규파일 detail 기존파일
					File file = new File("c:/file03_repo/" + detail.getGno() + "/" + detail.getFileName());
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
					gameRepository.modify(vo);
				} else { // 내용만 변경
					// modifyOnlyContent 호출
					gameRepository.modifyOnlyContent(vo);
				}
			}
			return "redirect:/game/list";
		}

		public void uploadPath(GameVO vo, MultipartFile multipartFile) {
		String fileName = multipartFile.getOriginalFilename();
		File uploadPath = new File("c:/file03_repo/"+vo.getGno());
		
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
