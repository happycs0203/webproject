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
	BoardDto tmpDto = dao.getBoard(num);
	String storedPass = tmpDto.getPass();
	String paramPass = dto.getPass();
	
	if(!paramPass.equals(storedPass)){
%>
		<script type="text/javascript">
			alert("�Է��Ͻ� ��й�ȣ�� �ùٸ��� �ʽ��ϴ�.");
			history.back();
		</script>
<%
	}
	else{
		dao.updateBoard(dto);
		response.sendRedirect("List.jsp");
	}
%>