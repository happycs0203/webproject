<%@ page contentType="text/html; charset=EUC-KR"%>
<%
	request.setCharacterEncoding("euc-kr");
%>
<jsp:useBean id="dao" class="com.songdroid.bean.board.BoardDaoImpl" />
<jsp:useBean id="dto" class="com.songdroid.bean.board.BoardDto" />
<jsp:setProperty property="*" name="dto"/>
<%
	// �Ķ���͸� �޾ƿ�
	// DTO�� ����
	dao.insertBoard(dto);
	response.sendRedirect("List.jsp");
%>
