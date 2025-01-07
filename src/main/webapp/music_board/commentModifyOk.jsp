<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="project.*"%>
<%
	request.setCharacterEncoding("UTF-8");

	int mno = Integer.parseInt(request.getParameter("mno"));
	int ms_cno = Integer.parseInt(request.getParameter("ms_cno"));
	String content = request.getParameter("commentContent");
	
	if(request.getMethod().equals("GET")){
		response.sendRedirect("view.jsp?mno="+mno);
	}
	
	Connection conn = null;
	PreparedStatement psmt = null;
	
	try{
		conn = DBConn.conn();
		
		String sql = "update ms_comment set content = ? where ms_cno = ?";
		
		psmt = conn.prepareStatement(sql);
		psmt.setString(1,content);
		psmt.setInt(2,ms_cno);
		
		psmt.executeUpdate();
		

		
	}catch(Exception e){
		e.printStackTrace();
		out.print(e.getMessage());
	}finally{
		DBConn.close(psmt, conn);
	}
	response.sendRedirect("view.jsp?mno="+mno);
%>