<%@page import="com.songdroid.bean.board.BoardDto"%>
<%@page import="java.util.Vector"%>
<%@ page contentType="text/html;charset=euc-kr" %>
<HTML>
<link href="style.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
	function check(){
		if(document.search.keyWord.value == ""){
			alert("검색어를 입력하세요.");
			document.search.keyWord.focus();
			return;
		}
		document.search.submit();
	}
	
	function fnList(){
		document.list.action = "List.jsp";
		document.list.submit();
	}
	
	function fnRead(num){
		document.read.num.value = num;
		document.read.submit();
	}
</script>
<BODY>
<center><br>
<h2>JSP Board</h2>
<jsp:useBean id="dao" class="com.songdroid.bean.board.BoardDaoImpl" />
<%!
	String keyWord="", keyField="";
	
	//페이징을 위한 변수 선언
	int totalRecord = 0; // 전체 글의 갯수
	int numPerPage = 5;	 // 한 페이지당 보여질 글의 갯수
	int pagePerBlock = 3; // 한 블럭당 묶여질 페이지 수
	int totalPage = 0; // 전체 페이지 수
	int totalBlock = 0; // 전체 블럭 수
	int nowPage = 0; // 현재 보여질 페이지
	int nowBlock = 0; // 현재 보여질 블럭
	int beginPerPage = 0; // 각 페이지의 시작 글번호
%>
<%
	request.setCharacterEncoding("euc-kr");

	if(request.getParameter("keyWord") != null){
		keyField = request.getParameter("keyField");
		keyWord = request.getParameter("keyWord");
	}
	
	if(request.getParameter("reload") != null){
		if(request.getParameter("reload").equals("true")){
			keyWord = "";
		}
	}
	
	Vector v = dao.getBoardList(keyField, keyWord);
	
	// 페이징 처리 부분
	totalRecord = v.size();
	totalPage = (int)Math.ceil((double)totalRecord/numPerPage);
	totalBlock = (int)Math.ceil((double)totalPage/pagePerBlock);
	
	if(request.getParameter("nowPage") != null)
		nowPage = Integer.parseInt(request.getParameter("nowPage"));
	
	if(request.getParameter("nowBlock") != null)
		nowBlock = Integer.parseInt(request.getParameter("nowBlock"));
	
	beginPerPage = nowPage * numPerPage;
%>
<table align=center border=0 width=80%>
<tr>
	<td align=left>Total : <%=totalRecord%> Articles(
		<font color=red> <%=nowPage+1%> / <%=totalPage%> Pages </font>)
	</td>
</tr>
</table>

<table align=center width=80% border=0 cellspacing=0 cellpadding=3>
<tr>
	<td align=center colspan=2>
		<table border=0 width=100% cellpadding=2 cellspacing=0>
			<tr align=center bgcolor=#D0D0D0 height=120%>
				<td> 번호 </td>
				<td> 제목 </td>
				<td> 이름 </td>
				<td> 날짜 </td>
				<td> 조회수 </td>
			</tr>
		<%
			if(v.isEmpty()){
		%>
			<tr>
				<td colspan="5">등록된 글이 없습니다.</td>
			</tr>
		<%
			}
			else{
				for(int cnt=beginPerPage; cnt<(beginPerPage + numPerPage); cnt++){
					if(cnt == totalRecord){
						break;
					}
					
					BoardDto dto = (BoardDto)v.get(cnt);	
					int num = dto.getNum();
					String subject = dto.getSubject();
					String name = dto.getName();
					String regdate = dto.getRegdate();
					int count = dto.getCount();
					String email = dto.getEmail();
					int depth = dto.getDepth();
		%>
			<tr>
				<td align="center"><%=num%></td>
				<td><%=dao.useDepth(depth)%><a href="Read.jsp" onclick="fnRead('<%=num%>'); return false;"><%=subject%></a></td>
				<td align="center"><a href="mailto:<%=email%>"><%=name%></a></td>
				<td align="center"><%=regdate %></td>
				<td align="center"><%=count %></td>
			</tr>
		<%
				}
			}
		%>
		</table>
	</td>
</tr>
<tr>
	<td><BR><BR></td>
</tr>
<tr>
	<td align="left">Go to Page	
	<%
		if(totalRecord > 0){
			if(nowBlock > 0){
	%>
	<a href="List.jsp?nowBlock=<%=nowBlock-1%>&nowPage=<%=(nowBlock-1)*pagePerBlock%>">이전 <%=pagePerBlock%>개</a>:::
	<%
			}
		}
	%>
	
	<%
		for(int cnt=0; cnt<pagePerBlock; cnt++){
	%>
			<a href="List.jsp?nowBlock=<%=nowBlock%>&nowPage=<%=(nowBlock*pagePerBlock)+cnt%>">
			<%=(nowBlock * pagePerBlock) + 1 + cnt%>
			</a>
	<%
			if(((nowBlock*pagePerBlock)+1+cnt) == totalRecord){
				break;
			}
		}
	%>
	<%
		if(totalBlock > nowBlock+1){
	%>
	::: <a href="List.jsp?nowBlock=<%=nowBlock+1%>&nowPage=<%=(nowBlock+1)*pagePerBlock%>">다음 <%=pagePerBlock%>개</a>
	<%
		}
	%>
	</td>
	<td align=right>
		<a href="Post.jsp">[글쓰기]</a>
		<a href="List.jsp" onclick="fnList(); return false;">[처음으로]</a>
	</td>
</tr>
</table>
<BR>
<form action="List.jsp" name="search" method="post">
	<table border=0 width=527 align=center cellpadding=4 cellspacing=0>
	<tr>
		<td align=center valign=bottom>
			<select name="keyField" size="1">
				<option value="name"> 이름
				<option value="subject"> 제목
				<option value="content"> 내용
			</select>

			<input type="text" size="16" name="keyWord" >
			<input type="button" value="찾기" onClick="check()">
			<input type="hidden" name="page" value= "0">
		</td>
	</tr>
	</table>
</form>
</center>	
<form name="list" method="post">
	<input type="hidden" name="reload" value="true" />
</form>

<form name="read" method="post" action="Read.jsp">
	<input type="hidden" name="num">
	<input type="hidden" name="keyField" value="<%=keyField%>" />
	<input type="hidden" name="keyWord" value="<%=keyWord%>" />
</form>
</BODY>
</HTML>