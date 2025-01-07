<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="project.*"%>
<%
	int ms_cno = Integer.parseInt(request.getParameter("ms_cno"));
	int mno = Integer.parseInt(request.getParameter("mno"));

	if(request.getMethod().equals("Get")){
		response.sendRedirect("view.jsp?mno="+mno);
	}

	Connection conn = null;
	PreparedStatement psmt = null;
	
	try{
		conn= DBConn.conn();
		
		String sql = "DELETE FROM ms_comment WHERE ms_cno = ?";
		
		psmt = conn.prepareStatement(sql);
		psmt.setInt(1,ms_cno);
		
		int result  = psmt.executeUpdate();
		
		if(result > 0){
%>
			<script>
				alert("삭제되었습니다.");
				location.href="view.jsp?mno=<%=mno%>";
			</script>
<%			
		}
	}catch(Exception e){
		e.printStackTrace();
		out.print(e.getMessage());
	}finally{
		DBConn.close(psmt, conn);
		
	}
	
	response.sendRedirect("view.jsp?mno="+mno);
%>