<%@page import="com.songdroid.bean.board.BoardDto"%>
<%@ page contentType="text/html; charset=EUC-KR"%>
<%
	request.setCharacterEncoding("euc-kr");
%>
<jsp:useBean id="dao" class="com.songdroid.bean.board.BoardDaoImpl" />
<jsp:useBean id="dto" class="com.songdroid.bean.board.BoardDto" />
<jsp:setProperty property="*" name="dto"/>

<%
	int num = Integer.parseInt(request.getParameter("num"));
	String keyField = request.getParameter("keyField");
	String keyWord = request.getParameter("keyWord");
	
	BoardDto Parent = dao.getBoard(num);
	dao.replyUpPos(Parent.getPos());
	
	dto.setPos(Parent.getPos());
	dto.setDepth(Parent.getDepth());
	dao.replyBoard(dto);
	response.sendRedirect("List.jsp");
%>
