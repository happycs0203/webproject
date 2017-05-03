package com.songdroid.bean.board;

import java.util.Vector;

public interface IBoardDao {
	// List.jsp�� ���
	public Vector getBoardList(String keyField, String keyWord);
	
	// �۾��� ���
	public void insertBoard(BoardDto dto);
	
	// �ۺ��� ���
	public BoardDto getBoard(int num);
	
	// �ۼ��� ���
	public void updateBoard(BoardDto dto);
	
	// �ۻ��� ���
	public void deleteBoard(int num);
	
	// �۴亯 ���
	public void replyBoard(BoardDto dto);
}
