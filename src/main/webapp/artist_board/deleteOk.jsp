<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="project.*"%>
<%
	int ano = Integer.parseInt(request.getParameter("ano"));

	if(request.getMethod().equals("GET")){
%>
		<script>
		alert("잘못된 접근입니다.");
		location.href="view.jsp?ano=<%= ano %>";
		</script>
<%
	}else{
		Connection conn = null;
		PreparedStatement psmt = null;
		
		PreparedStatement psmtComment = null;
		
		try{
			conn = DBConn.conn();
			
			String sqlComment = "DELETE FROM comment WHERE ano = ?";
			
			psmtComment = conn.prepareStatement(sqlComment);
			psmtComment.setInt(1, ano);
			
			psmtComment.executeUpdate();
			
			String sql = "DELETE FROM artist_board WHERE ano = ?";
			
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, ano);
			
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
	location.href="view.jsp?ano=<%= ano %>";
</script>