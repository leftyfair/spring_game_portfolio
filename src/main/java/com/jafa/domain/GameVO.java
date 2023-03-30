package com.jafa.domain;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class GameVO {
	private Long gno;
	private String cid;
	private String title;
	private String content;
	private int price;
	private String volSize;
	private String developer;
	private String fileName;
	private FileType fileType;
	private Category category;
	
	public enum FileType{
		IMAGE, OTHER;
	}
	
}
