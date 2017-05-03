<%@page import="com.songdroid.bean.board.BoardDto"%>
<%@ page contentType="text/html; charset=EUC-KR"%>
<html>
<head><title>JSPBoard</title>
<link href="style.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
	function fnList(){
		document.list.submit();
	}
</script>
</head>
<body>
<jsp:useBean id="dao" class="com.songdroid.bean.board.BoardDaoImpl" />
<%
	int num = Integer.parseInt(request.getParameter("num"));
	String keyField = request.getParameter("keyField");
	String keyWord = request.getParameter("keyWord");
	
	BoardDto dto = dao.getBoard(num);
	String name = dto.getName();
	String email = dto.getEmail();
	String homePage = dto.getHomepage();
	String subject = dto.getSubject();
	String regdate = dto.getRegdate();
	String content = dto.getContent().replace("\n", "<br/>");
	String ip = dto.getIp();
	int count = dto.getCount();
%>
<br><br>
<table align=center width=70% border=0 cellspacing=3 cellpadding=0>
 <tr>
  <td bgcolor=9CA2EE height=25 align=center class=m>글읽기</td>
 </tr>
 <tr>
  <td colspan=2>
   <table border=0 cellpadding=3 cellspacing=0 width=100%> 
    <tr> 
	 <td align=center bgcolor=#dddddd width=10%> 이 름 </td>
	 <td bgcolor=#ffffe8><%=name%></td>
	 <td align=center bgcolor=#dddddd width=10%> 등록날짜 </td>
	 <td bgcolor=#ffffe8><%=regdate%></td>
	</tr>
    <tr>
	 <td align=center bgcolor=#dddddd width=10%> 메 일 </td>
	 <td bgcolor=#ffffe8 ><%=email %></td> 
	 <td align=center bgcolor=#dddddd width=10%> 홈페이지 </td>
	 <td bgcolor=#ffffe8 ><a href="http://<%=homePage%>" target="_new">http://<%=homePage%></a></td> 
	</tr>
    <tr> 
     <td align=center bgcolor=#dddddd> 제 목</td>
     <td bgcolor=#ffffe8 colspan=3><%=subject%></td>
   </tr>
   <tr> 
    <td colspan=4><%=content%></td>
   </tr>
   <tr>
    <td colspan=4 align=right>
     <%=ip%>로 부터 글을 남기셨습니다./  조회수 : <%=count%> 
    </td>
   </tr>
   </table>
  </td>
 </tr>
 <tr>
  <td align=center colspan=2> 
	<hr size=1>
	[ <a href="List.jsp" onclick="fnList(); return false;">목 록</a> | 
	<a href="Update.jsp?num=<%=num%>">수 정</a> |
	<a href="Reply.jsp?num=<%=num%>&keyField=<%=keyField%>&keyWord=<%=keyWord%>">답 변</a> |
	<a href="Delete.jsp?num=<%=num%>">삭 제</a> ]<br>
  </td>
 </tr>
</table>
<form name="list" action="List.jsp" method="post">
	<input type="hidden" name="keyField" value="<%=keyField%>" /> 
	<input type="hidden" name="keyWord" value="<%=keyWord%>" /> 
</form>
</body>
</html>
