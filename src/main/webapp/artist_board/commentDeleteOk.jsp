<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="project.*"%>
<%
	int cno = Integer.parseInt(request.getParameter("cno"));
	int ano = Integer.parseInt(request.getParameter("ano"));

	if(request.getMethod().equals("Get")){
		response.sendRedirect("view.jsp?ano="+ano);
	}

	Connection conn = null;
	PreparedStatement psmt = null;
	
	try{
		conn= DBConn.conn();
		
		String sql = "DELETE FROM comment WHERE cno = ?";
		
		psmt = conn.prepareStatement(sql);
		psmt.setInt(1,cno);
		
		int result  = psmt.executeUpdate();
		
		if(result > 0){
%>
			<script>
				alert("삭제되었습니다.");
				location.href="view.jsp?ano=<%=ano%>";
			</script>
<%			
		}
	}catch(Exception e){
		e.printStackTrace();
		out.print(e.getMessage());
	}finally{
		DBConn.close(psmt, conn);
		
	}
	
	response.sendRedirect("view.jsp?ano="+ano);
%>