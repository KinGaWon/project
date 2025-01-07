<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="project.*"%>
<%
	int nno = Integer.parseInt(request.getParameter("nno"));

	if(request.getMethod().equals("GET")){
%>
		<script>
		alert("잘못된 접근입니다.");
		location.href="view.jsp?nno=<%= nno %>";
		</script>
<%
	}else{
		Connection conn = null;
		PreparedStatement psmt = null;
		
		try{
			conn = DBConn.conn();
			
			String sql = "DELETE FROM notice_board WHERE nno = ?";
			
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, nno);
			
			int result = psmt.executeUpdate();
			
			if(result > 0){
%>
				<script>
				alert("삭제되었습니다.");
				location.href="list.jsp";
				</script>
<%			
			}
			
		}catch(Exception e){
			e.printStackTrace();
			out.print(e.getMessage());
		}finally{
			DBConn.close(psmt, conn);
		}
	}
%>
<script>
	alert("삭제 실패했습니다.");
	location.href="view.jsp?nno=<%= nno %>";
</script>