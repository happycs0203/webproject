<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
<script type="text/javascript">
	function fnSetAddress(zipcode, sido, gugun, dong, bunji){
		opener.document.f.zip.value=zipcode;
		opener.document.f.addr1.value=sido +" " + gugun + " " + dong + " " + bunji;
		self.close();
	}
</script>
</head>
<body>
<div style="text-align:center;">
우편번호 찾기<br/><br>
<form action="/JSPApplication/zip.do" method="post">
	동 이름 : <input type="text" name="dong" />&nbsp;&nbsp;<input type="submit" value="검색" />
	<br/><br/>
	<div style="font-size:14px;text-align:left;overflow-y:scroll;height:150px">
		<c:forEach var="dto" items="${ziplist}">
			<a href="zipSearch.jsp" onclick="fnSetAddress('${dto.zipcode}','${dto.sido}', '${dto.gugun}', '${dto.dong}','${dto.bunji}'); return false;">
			${dto.zipcode}&nbsp;&nbsp;${dto.sido}
			&nbsp;&nbsp;${dto.gugun}&nbsp;&nbsp;${dto.dong}&nbsp;&nbsp;
			${dto.bunji}</a><br/>
		</c:forEach>
	</div>
</form>
</div>
</body>
</html>