package com.jafa.domain;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class BoardVO {

	private Long bno;
	private String title;
	private String content;
	private String writer;
	private String fileName;
	private FileType fileType;
	
	public enum FileType{
		IMAGE, OTHER;
	}
	
}
