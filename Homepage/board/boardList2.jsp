<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
	// 사용할 객체 초기화
	Connection connect = null;
	PreparedStatement Prepared_state = null;
	ResultSet result = null;
	int pagenum_temp = 1;
	int list_count = 10;
	int page_per_block = 10;
	String whereSQL = "";
	// 파라미터
	String pageNum = request.getParameter("pageNum");
	String searchType = request.getParameter("searchType");
	String searchText = request.getParameter("searchText");
	// 파라미터 초기화
	if (searchText == null) {
		searchType = "";
		searchText = "";
	}
	if (pageNum != null) {
		pagenum_temp = Integer.parseInt(pageNum);
	}
	// 한글파라미터 처리
	String searchTextUTF8 = new String(searchText.getBytes("ISO-8859-1"), "UTF-8");
	// 데이터베이스 커넥션 및 질의문 실행
	// 검색어 쿼리문 생성
	if (!"".equals(searchText)) {
		if ("ALL".equals(searchType)) {
			whereSQL = " WHERE SUBJECT LIKE CONCAT('%',?,'%') OR WRITER LIKE CONCAT('%',?,'%') OR CONTENTS LIKE CONCAT('%',?,'%') OR AREA LIKE CONCAT('%',?,'%') OR PERIOD LIKE CONCAT('%',?,'%') ";
		} else if ("SUBJECT".equals(searchType)) {
			whereSQL = " WHERE SUBJECT LIKE CONCAT('%',?,'%') ";
		} else if ("WRITER".equals(searchType)) {
			whereSQL = " WHERE WRITER LIKE CONCAT('%',?,'%') ";
		} else if ("CONTENTS".equals(searchType)) {
			whereSQL = " WHERE CONTENTS LIKE CONCAT('%',?,'%') ";
		} else if ("AREA".equals(searchType)) {
			whereSQL = " WHERE AREA LIKE CONCAT('%',?,'%') ";
		} else if ("PERIOD".equals(searchType)) {
			whereSQL = " WHERE PERIOD LIKE CONCAT('%',?,'%') ";
		}
	}
	try {
		Class.forName("com.mysql.jdbc.Driver");
		connect = DriverManager.getConnection(
			"jdbc:mysql://localhost:3306/12111684", "root", "1234");
		// 게시물의 총 수를 얻는 쿼리 실행
		Prepared_state = connect.prepareStatement("SELECT COUNT(NUM) AS TOTAL FROM BOARD2" + whereSQL);
		if (!"".equals(whereSQL)) {
			if ("ALL".equals(searchType)) {
				Prepared_state.setString(1, searchTextUTF8);
				Prepared_state.setString(2, searchTextUTF8);
				Prepared_state.setString(3, searchTextUTF8);
				Prepared_state.setString(4, searchTextUTF8);
				Prepared_state.setString(5, searchTextUTF8);
			} else {
				Prepared_state.setString(1, searchTextUTF8);
			}
		}
		result = Prepared_state.executeQuery();
		result.next();
		int total_count = result.getInt("TOTAL");
		// 게시물 목록을 얻는 쿼리 실행
		Prepared_state = connect.prepareStatement("SELECT NUM, SUBJECT, WRITER, AREA, PERIOD, REG_DATE, HIT FROM BOARD2 "+whereSQL+" ORDER BY NUM DESC LIMIT ?, ?");
		if (!"".equals(whereSQL)) {
			// 전체검색일시
			if ("ALL".equals(searchType)) {
				Prepared_state.setString(1, searchTextUTF8);
				Prepared_state.setString(2, searchTextUTF8);
				Prepared_state.setString(3, searchTextUTF8);
				Prepared_state.setString(4, searchTextUTF8);
				Prepared_state.setString(5, searchTextUTF8);
				Prepared_state.setInt(6, list_count * (pagenum_temp-1));
				Prepared_state.setInt(7, list_count);			
			} else {
				Prepared_state.setString(1, searchTextUTF8);
				Prepared_state.setInt(2, list_count * (pagenum_temp-1));
				Prepared_state.setInt(3, list_count);			
			}
		} else {	
			Prepared_state.setInt(1, list_count * (pagenum_temp-1));
			Prepared_state.setInt(2, list_count);
		}
		result = Prepared_state.executeQuery();
%>
<!DOCTYPE HTML>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"></meta>
<title>리뷰 게시판 목록</title>
<link href="../Main.css" rel="styLesheet" type="text/css">
<style type="text/css">
	p {width: 600px; text-align: right;}
</style>
<script type="text/javascript">
	function goUrl(url) {
		location.href=url;
	}
	// 검색 폼 체크
	function searchCheck() {
		var search_form = document.searchForm;
		if (search_form.searchText.value == '') {
			alert('검색어를 입력하세요.');
			search_form.searchText.focus();
			return false;
		}
		return true;
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
	<form name="searchForm" action="boardList2.jsp" method="get" onsubmit="return searchCheck();" >
	<p>
		<select name="searchType">
			<option value="ALL" selected="selected">전체검색</option>
			<option value="SUBJECT" <%if ("SUBJECT".equals(searchType)) out.print("selected=\"selected\""); %>>제목</option>
			<option value="WRITER" <%if ("WRITER".equals(searchType)) out.print("selected=\"selected\""); %>>작성자</option>
			<option value="AREA" <%if ("AREA".equals(searchType)) out.print("selected=\"selected\""); %>>장소</option>
			<option value="PERIOD" <%if ("PERIOD".equals(searchType)) out.print("selected=\"selected\""); %>>기간</option>
			<option value="CONTENTS" <%if ("CONTENTS".equals(searchType)) out.print("selected=\"selected\""); %>>내용</option>
		</select>
		<input type="text" name="searchText" value="<%=searchTextUTF8%>" />
		<input type="submit" value="검색" />
	</p>
	</form>
	<table border="1" summary="리뷰 게시판 목록">
		<caption>리뷰 게시판 목록</caption>
		<colgroup>
			<col width="50" />
			<col width="200" />
			<col width="80" />
			<col width="100" />
			<col width="70" />
			<col width="100" />
			<col width="60" />
		</colgroup>
		<thead>
			<tr>
				<th>번호</th>
				<th>제목</th>
				<th>작성자</th>
				<th>장소</th>
				<th>기간</th>
				<th>등록 일시</th>
				<th>조회수</th>
			</tr>
		</thead>
		<tbody>
			<%
			if (total_count == 0) {
			%>
			<tr>
				<td align="center" colspan="7">등록된 게시물이 없습니다.</td>
			</tr>
			<%
			} else {
				int i = 0;
				while (result.next()) {
					i++;
			%>
			<tr>
				<td align="center"><%=total_count - i + 1 - (pagenum_temp - 1) * list_count %></td>
				<td>&nbsp;<a href="boardView2.jsp?num=<%=result.getInt("NUM")%>&amp;pageNum=<%=pagenum_temp%>&amp;searchType=<%=searchType%>&amp;searchText=<%=searchText%>"><%=result.getString("SUBJECT") %></a></td>
				<td align="center"><%=result.getString("WRITER") %></td>
				<td align="center"><%=result.getString("AREA") %></td>
				<td align="center"><%=result.getString("PERIOD") %></td>
				<td align="center"><%=result.getString("REG_DATE").substring(0, 10) %></td>
				<td align="center"><%=result.getInt("HIT") %></td>
			</tr>
			<%
				}
			}
			%>
		</tbody>
		<tfoot>
			<tr>
				<td align="center" colspan="7">
				<%
				// 페이지 네비게이터
				if(total_count > 0) {
					int totalNumOfPage = (total_count % list_count == 0) ? 
							total_count / list_count :
							total_count / list_count + 1;
					
					int totalNumOfBlock = (totalNumOfPage % page_per_block == 0) ?
							totalNumOfPage / page_per_block :
							totalNumOfPage / page_per_block + 1;
					
					int currentBlock = (pagenum_temp % page_per_block == 0) ? 
							pagenum_temp / page_per_block :
							pagenum_temp / page_per_block + 1;
					
					int startPage = (currentBlock - 1) * page_per_block + 1;
					int endPage = startPage + page_per_block - 1;
					
					if(endPage > totalNumOfPage)
						endPage = totalNumOfPage;
					boolean isNext = false;
					boolean isPrev = false;
					if(currentBlock < totalNumOfBlock)
						isNext = true;
					if(currentBlock > 1)
						isPrev = true;
					if(totalNumOfBlock == 1){
						isNext = false;
						isPrev = false;
					}
					StringBuffer strBuffer = new StringBuffer();
					if(pagenum_temp > 1){
						strBuffer.append("<a href=\"").append("boardList2.jsp?pageNum=1&amp;searchType="+searchType+"&amp;searchText="+searchText);
						strBuffer.append("\" title=\"<<\"><<</a>&nbsp;");
					}
					if (isPrev) {
						int goPrevPage = startPage - page_per_block;			
						strBuffer.append("&nbsp;&nbsp;<a href=\"").append("boardList2.jsp?pageNum="+goPrevPage+"&amp;searchType="+searchType+"&amp;searchText="+searchText);
						strBuffer.append("\" title=\"<\"><</a>");
					} else {
						
					}
					for (int i = startPage; i <= endPage; i++) {
						if (i == pagenum_temp) {
							strBuffer.append("<a href=\"#\"><strong>").append(i).append("</strong></a>&nbsp;&nbsp;");
						} else {
							strBuffer.append("<a href=\"").append("boardList2.jsp?pageNum="+i+"&amp;searchType="+searchType+"&amp;searchText="+searchText);
							strBuffer.append("\" title=\""+i+"\">").append(i).append("</a>&nbsp;&nbsp;");
						}
					}
					if (isNext) {
						int goNextPage = startPage + page_per_block;
	
						strBuffer.append("<a href=\"").append("boardList2.jsp?pageNum="+goNextPage+"&amp;searchType="+searchType+"&amp;searchText="+searchText);
						strBuffer.append("\" title=\">\">></a>");
					} else {
						
					}
					if(totalNumOfPage > pagenum_temp){
						strBuffer.append("&nbsp;&nbsp;<a href=\"").append("boardList2.jsp?pageNum="+totalNumOfPage+"&amp;searchType="+searchType+"&amp;searchText="+searchText);
						strBuffer.append("\" title=\">>\">>></a>");
					}
					out.print(strBuffer.toString());
				}
				%>
				</td>
			</tr>
		</tfoot>
	</table>
	<p>
		<input type="button" value="목록" onclick="goUrl('boardList2.jsp');" />
		<input type="button" value="글쓰기" onclick="goUrl('boardWriteForm2.jsp');" />
	</p>
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