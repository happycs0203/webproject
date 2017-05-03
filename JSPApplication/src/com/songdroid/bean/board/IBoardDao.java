package com.songdroid.bean.board;

import java.util.Vector;

public interface IBoardDao {
	// List.jsp에 사용
	public Vector getBoardList(String keyField, String keyWord);
	
	// 글쓰기 기능
	public void insertBoard(BoardDto dto);
	
	// 글보기 기능
	public BoardDto getBoard(int num);
	
	// 글수정 기능
	public void updateBoard(BoardDto dto);
	
	// 글삭제 기능
	public void deleteBoard(int num);
	
	// 글답변 기능
	public void replyBoard(BoardDto dto);
}
