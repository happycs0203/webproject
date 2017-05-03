<%@ page contentType="text/html; charset=EUC-KR"%>
<%
	request.setCharacterEncoding("euc-kr");
%>
<jsp:useBean id="dao" class="com.songdroid.bean.board.BoardDaoImpl" />
<jsp:useBean id="dto" class="com.songdroid.bean.board.BoardDto" />
<jsp:setProperty property="*" name="dto"/>
<%
	// 파라미터를 받아옴
	// DTO로 포장
	dao.insertBoard(dto);
	response.sendRedirect("List.jsp");
%>
