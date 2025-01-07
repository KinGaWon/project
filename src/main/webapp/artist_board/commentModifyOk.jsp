<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="project.*"%>
<%
	request.setCharacterEncoding("UTF-8");

	int ano = Integer.parseInt(request.getParameter("ano"));
	int cno = Integer.parseInt(request.getParameter("cno"));
	String content = request.getParameter("commentContent");
	
	if(request.getMethod().equals("GET")){
		response.sendRedirect("view.jsp?ano="+ano);
	}
	
	Connection conn = null;
	PreparedStatement psmt = null;
	
	try{
		conn = DBConn.conn();
		
		String sql = "update comment set content = ? where cno = ?";
		
		psmt = conn.prepareStatement(sql);
		psmt.setString(1,content);
		psmt.setInt(2,cno);
		
		psmt.executeUpdate();
		

		
	}catch(Exception e){
		e.printStackTrace();
		out.print(e.getMessage());
	}finally{
		DBConn.close(psmt, conn);
	}
	response.sendRedirect("view.jsp?ano="+ano);
%>