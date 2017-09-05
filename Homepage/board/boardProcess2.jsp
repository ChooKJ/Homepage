<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
	// POST 한글 파라미터 깨짐 처리
	request.setCharacterEncoding("UTF-8");
	// 사용할 객체 초기화
	Connection connect = null;
	PreparedStatement Prepared_state = null;
	// 파라미터
	String mode = request.getParameter("mode");
	String subject = request.getParameter("subject");
	String writer = request.getParameter("writer");
	String contents = request.getParameter("contents");
	String num = request.getParameter("num");
	String pageNum = request.getParameter("pageNum");
	String area = request.getParameter("area");
	String period = request.getParameter("period");
	String latitude = request.getParameter("latitude");
	String longtitude = request.getParameter("longtitude");
	String searchType = request.getParameter("searchType");
	String searchText = request.getParameter("searchText");
	String ip = request.getRemoteAddr();
	
	try {
		// 데이터베이스 객체 생성
		Class.forName("com.mysql.jdbc.Driver");
		connect = DriverManager.getConnection("jdbc:mysql://localhost:3306/12111684", "root", "1234");
		// 처리 (W:등록, M:수정, D:삭제)
		if ("W".equals(mode)) {
			Prepared_state = connect.prepareStatement(
				"INSERT INTO BOARD2 (SUBJECT, WRITER, CONTENTS, IP, HIT, REG_DATE, MOD_DATE, AREA, PERIOD, LATITUDE, LONGTITUDE) "+
				"VALUES (?, ?, ?, ?, 0, NOW(), NOW(), ?, ?, ?, ?)");
			Prepared_state.setString(1, subject);
			Prepared_state.setString(2, writer);
			Prepared_state.setString(3, contents);
			Prepared_state.setString(4, ip);
			Prepared_state.setString(5, area);
			Prepared_state.setString(6, period);
			Prepared_state.setString(7, latitude);
			Prepared_state.setString(8, longtitude);
			Prepared_state.executeUpdate();
	
			response.sendRedirect("boardList2.jsp");
		} else if ("M".equals(mode)) {
			Prepared_state = connect.prepareStatement(
				"UPDATE BOARD2 SET SUBJECT = ?, WRITER = ?, CONTENTS = ?, IP = ?, MOD_DATE = NOW(), AREA = ?, PERIOD = ?, LATITUDE = ?, LONGTITUDE = ?"+
				"WHERE NUM = ?");
			Prepared_state.setString(1, subject);
			Prepared_state.setString(2, writer);
			Prepared_state.setString(3, contents);
			Prepared_state.setString(4, ip);
			Prepared_state.setString(5, area);
			Prepared_state.setString(6, period);
			Prepared_state.setString(7, latitude);
			Prepared_state.setString(8, longtitude);
			Prepared_state.setString(9, num);
			Prepared_state.executeUpdate();
			
			response.sendRedirect(
				"boardView2.jsp?num="+num+"&pageNum="+pageNum+"&searchType="+searchType+"&searchText="+searchText);
		} else if ("D".equals(mode)) {
			Prepared_state = connect.prepareStatement("DELETE FROM BOARD2 WHERE NUM = ?");
			Prepared_state.setString(1, num);
			Prepared_state.executeUpdate();
			
			response.sendRedirect(
				"boardList2.jsp?pageNum="+pageNum+"&searchType="+searchType+"&searchText="+searchText);
		} else {
			response.sendRedirect("boardList2.jsp");
		}

	} catch (Exception e) {
		e.printStackTrace();
	} finally {
		if (Prepared_state != null) Prepared_state.close();
		if (connect != null) connect.close();
	}
%>