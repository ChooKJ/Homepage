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
		// 조회수 증가 쿼리 실행
		Prepared_state = connect.prepareStatement("UPDATE BOARD2 SET HIT = HIT + 1 WHERE NUM = ?");
		Prepared_state.setString(1, num);
		Prepared_state.executeUpdate();
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
<link href="../Main.css" rel="styLesheet" type="text/css">
<title>리뷰 게시판 상세보기</title>
<style type="text/css">
	.btn_align {width: 600px; text-align: right;}
	#map-canvas { width: 600px; height: 600px; margin:0px; padding:0px; }
	section{height:1000px;}
</style>
<script src="https://maps.googleapis.com/maps/api/js?v=3.exp&sensor=false">	</script>
<script type="text/javascript">
	function goUrl(url) {
		location.href=url;
	}
	// 삭제 체크
	function deleteCheck(url) {
		if (confirm('정말 삭제하시겠어요?')) {
			location.href=url;
		}
	}
	
	/*     지도 부분         */
	var zoomControl = 18;
	function plusButton() {
		if(zoomControl < 21) {
			zoomControl = zoomControl + 1;
		}
		initialize();
	}
	function minusButton() {
		if(zoomControl > 15) {
			zoomControl = zoomControl - 1;
		}
		initialize();
	}
	
	function initialize() {
		// 지도의 확대 비율 지정, 지도에서 보여줄 위치
		var mapOptions = { zoom:zoomControl,    
				center:new google.maps.LatLng(parseFloat(<%=result.getString("LATITUDE") %>), parseFloat(<%=result.getString("LONGTITUDE") %>))};
		// 구글 앱 실행
		map = new google.maps.Map(document.getElementById("map-canvas"), mapOptions);
		}
	
	google.maps.event.addDomListener(window, 'load', initialize);
	
	//error 처리
	function printError(error) {
		switch ( error.code) {
		case error.PERMISSION_DENIED:
			msg = "사용자 거부";
			break;
		case error.POSITION_UNAVAILABLE:
			msg = "지리 정보를 얻을 수 없음";
			break;
		case error.TIMEOUT:
			msg = "시간 초과";
			break
		case error.UNKNOWN_ERROR:
			msg = "알 수 없는 오류 발생";
			break
		}
	}
</script>
</head>
<body><%=searchText%>
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
	<table border="1" summary="리뷰 게시판 상세조회">
		<caption>리뷰 게시판 상세조회</caption>
		<colgroup>
			<col width="100" />
			<col width="300" />
			<col width="100" />
			<col width="150" />
		</colgroup>
		<tbody>
			<tr>
				<th align="center"> 제목 </th>
				<td colspan="3">&nbsp; <%=result.getString("SUBJECT") %> </td>
			</tr>
			<tr>
				<th align="center"> 작성자 </th>
				<td colspan="3">&nbsp; <%=result.getString("WRITER") %> </td>
			</tr>
			<tr>
				<th align="center"> 장소 </th>
				<td>&nbsp; <%=result.getString("AREA") %> </td>
				<th align="center"> 기간 </th>
				<td>&nbsp; <%=result.getString("PERIOD") %> </td>
			</tr>
			<tr>
				<th align="center"> 등록 일시 </th>
				<td>&nbsp; <%=result.getString("REG_DATE") %> </td>
				<th align="center"> 조회수 </th>
				<td>&nbsp; <%=result.getInt("HIT") %> </td>
			</tr>
			<tr>
				<td colspan="4">&nbsp; <%=result.getString("CONTENTS") %> </td>
			</tr>
		</tbody>
	</table>
	<p class="btn_align">
		<input type="button" value="목록" onclick="goUrl('boardList2.jsp?pageNum=<%=pageNum%>&amp;searchType=<%=searchType%>&amp;searchText=<%=searchText%>');" />
		<input type="button" value="수정" onclick="goUrl('boardModifyForm2.jsp?num=<%=num%>&amp;pageNum=<%=pageNum%>&amp;searchType=<%=searchType%>&amp;searchText=<%=searchText%>');" />
		<input type="button" value="삭제" onclick="deleteCheck('boardProcess2.jsp?mode=D&amp;num=<%=num%>&amp;pageNum=<%=pageNum%>&amp;searchType=<%=searchType%>&amp;searchText=<%=searchText%>');" />
	</p>
	
	<h2 style="color:gray;">LOCATION</h2>
	<input type="button" id="plusButton" value="expansion" onclick="plusButton()"></input>
	<input type="button" id="minusButton" value="reduction" onclick="minusButton()"></input>
	
	<div id="map-canvas"></div>
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