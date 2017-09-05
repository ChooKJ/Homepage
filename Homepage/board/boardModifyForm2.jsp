<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
	// 사용할 객체 초기화
	Connection connect = null;
	PreparedStatement Prepared_state = null;
	ResultSet result = null;
	// 파라미터
	String num = request.getParameter("num");
	String pageNum = request.getParameter("pageNum");
	String searchType = request.getParameter("searchType");
	String searchText = request.getParameter("searchText");
	try {
		// 데이터베이스 객체 생성
		Class.forName("com.mysql.jdbc.Driver");
		connect = DriverManager.getConnection(
			"jdbc:mysql://localhost:3306/12111684", "root", "1234");
		// 게시물 상세 조회 쿼리 실행 
		Prepared_state = connect.prepareStatement(
			"SELECT NUM, SUBJECT, CONTENTS, WRITER, HIT, REG_DATE, AREA, PERIOD, LATITUDE, LONGTITUDE FROM BOARD2 "+ 
			"WHERE NUM = ?");
		Prepared_state.setString(1, num);
		result = Prepared_state.executeQuery();
		result.next();
%>
<!DOCTYPE HTML>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"></meta>
<title>리뷰 게시판 수정 폼</title>
<link href="../Main.css" rel="styLesheet" type="text/css">
<script type="text/javascript" src="<%=request.getContextPath()%>/ckeditor/ckeditor.js"></script>
<style type="text/css">
	p {width: 600px; text-align: right;}
	th {background-color: gray;}
</style>
<script type="text/javascript">
	function goUrl(url) {
		location.href=url;
	}
	// 수정 폼 체크
	function boardModifyCheck() {
		var modify_form = document.boardModifyForm;
		if (modify_form.subject.value == '') {
			alert('제목을 입력하세요.');
			modify_form.subject.focus();
			return false;
		}
		if (modify_form.writer.value == '') {
			alert('작성자을 입력하세요.');
			modify_form.writer.focus();
			return false;
		}
		if (modify_form.area.value == '') {
			alert('지역을 입력하세요.');
			modify_form.area.focus();
			return false;
		}
		if (modify_form.period.value == '') {
			alert('기간을 입력해주세요.');
			modify_form.period.focus();
			return false;
		}
		if (modify_form.latitude.value == '') {
			alert('위도를 입력해주세요.');
			modify_form.latitude.focus();
			return false;
		}
		if (modify_form.longtitude.value == '') {
			alert('경도를 입력해주세요.');
			modify_form.longtitude.focus();
			return false;
		}
		return true;
	}
	
	function searchMap(){
		window.open("https://www.google.co.kr/maps/", "MsgWindow", "width=800, height=800");
	}
</script>

</head>
<body>
	<header>
		<div id="head">
			<ul id="list">
				<li><a href="../Main.html" target="_self">Home</a></li>
				<li><a href="../Login.html" id = "LogInMenu" target="_self" onclick="log()">로그인</a></li>
				<li><a href="../SignUp.html" target="_self"> 회원가입 </a></li>
			</ul>
		</div>
		<h1>더 플레이시스</h1>
	</header>

	<script type="text/javascript">
		function callsubMenu(menu){
			document.getElementById(menu).style.visibility = "visible";
		}
		function outsubMenu(menu){
			document.getElementById(menu).style.visibility = "hidden";
		}
		
		if(localStorage.getItem("LogInState") == 1)
			document.getElementById("LogInMenu").innerHTML = "로그아웃";
		else
			document.getElementById("LogInMenu").innerHTML = "로그인";
		
		function log(){
			if(localStorage.getItem("LogInState") == 1){
				document.getElementById("LogInMenu".innerHTML = "로그인")
				localStorage.setItem("LogInState", 0);
			}
		}
		
	</script>

	<nav>
		<table border="1" id="nav">
			<tr>
				<th class="mainMenu"><a target="_self" href="../category\introduce.html"> About The Places</a></th>
				<th class="mainMenu" onmouseover="callsubMenu('sub1');"  onmouseout="outsubMenu('sub1');"><a target="_self" href="boardList.jsp"> 전체 보기 </a>
					<table class="subMenu" id="sub1">
							<tr>
								<td><a href="../category/sightseeing.jsp"> 관광지 </a></td>
								<td><a href="../category/restaurant.jsp"> 맛집 </a></td>
								<td><a href="../category/festival.jsp"> 축제 / 행사 </a></td>
							</tr>
					</table>
				</th>
				<th class="mainMenu"><a target="_self" href="../category\sightseeing.jsp"> 관광지 </a></th>
				<th class="mainMenu"><a target="_self" href="../category\restaurant.jsp"> 맛집 </a></th>
				<th class="mainMenu"><a target="_self" href="../category\festival.jsp"> 축제 / 행사 </a></th>
				<th class="mainMenu"><a target="_self" href="boardList2.jsp"> 리뷰 </a></th>
				<th class="mainMenu"><a target="_self" href="../category\event.html"> 이벤트 </a></th>
			</tr>
		</table>	
	</nav>
	<section>
	<form name="boardModifyForm" action="boardProcess2.jsp" method="post" onsubmit="return boardModifyCheck();">
	<input type="hidden" name="mode" value="M" />
	<input type="hidden" name="num" value="<%=num %>" />
	<input type="hidden" name="pageNum" value="<%=pageNum %>" />
	<input type="hidden" name="searchType" value="<%=searchType %>" />
	<input type="hidden" name="searchText" value="<%=searchText %>" />
	<table border="1" summary="리뷰 게시판 수정 폼">
		<caption>리뷰 게시판 수정 폼</caption>
		<colgroup>
			<col width="100" />
			<col width="100" />
			<col width="100" />
			<col width="100" />
			<col width="100" />
		</colgroup>
		<tbody>
			<tr>
				<th align="center">제목</th>
				<td colspan="5"><input type="text" name="subject" size="80" maxlength="100" value="<%=result.getString("SUBJECT") %>" /></td>
			</tr>
			<tr>
				<th align="center">작성자</th>
				<td colspan="5"><input type="text" name="writer" maxlength="20" value="<%=result.getString("WRITER") %>" /></td>
			</tr>
			<tr>
				<th align="center"> 장소 </th>
				<td><input type="text" name="area" maxlength="20" value="<%=result.getString("AREA") %>" /></td>
				<th align="center"> 위도 </th>
				<td><input type="text" name="latitude" maxlength="20" value="<%=result.getString("LATITUDE") %>" /></td>
				<th align="center"> 경도 </th>
				<td><input type="text" name="longtitude" maxlength="20" value="<%=result.getString("LONGTITUDE") %>" /></td>
			</tr>
			<tr>
				<th align="center"> 기간 </th>
				<td colspan="5"><input type="text" name="period" maxlength="20" value="<%=result.getString("PERIOD") %>" /></td>
			</tr>
			<tr>
				<td colspan="6">
					<textarea name="contents" cols="80" rows="10"><%=result.getString("CONTENTS") %></textarea>
					<script>
					CKEDITOR.replace('contents');
					</script>
				</td>
			</tr>
		</tbody>
	</table>
	<input type="button" value="지도 검색" onclick="searchMap()"></input>
	<p>
		<input type="button" value="목록" onclick="goUrl('boardList2.jsp?pageNum=<%=pageNum%>&amp;searchType=<%=searchType%>&amp;searchText=<%=searchText%>');" />
		<input type="submit" value="글수정" />
	</p>
	</form>
	</section>
	
	<footer>Copyright (c) 더 플레이시스 </footer>	
</body>
</html>
<%
	} catch (Exception e) {
		e.printStackTrace();
	} finally {
		if (result != null) result.close();
		if (Prepared_state != null) Prepared_state.close();
		if (connect != null) connect.close();
	}
%>