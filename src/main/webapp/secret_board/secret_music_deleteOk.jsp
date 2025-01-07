<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="project.*"%>
<%
	int mno = Integer.parseInt(request.getParameter("mno"));

	if(request.getMethod().equals("GET")){
%>
		<script>
		alert("잘못된 접근입니다.");
		location.href="secret_music_view.jsp?mno=<%= mno %>";
		</script>
<%
	}else{
		Connection conn = null;
		PreparedStatement psmt = null;
		
		PreparedStatement psmtComment = null;
		
		try{
			conn = DBConn.conn();
			
			String sqlComment = "DELETE FROM ms_comment WHERE mno = ?";
			
			psmtComment = conn.prepareStatement(sqlComment);
			psmtComment.setInt(1, mno);
			
			psmtComment.executeUpdate();
			
			String sql = "DELETE FROM music_board WHERE mno = ?";
			
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, mno);
			
			int result = psmt.executeUpdate();
			
			if(result > 0){
%>
				<script>
				alert("삭제되었습니다.");
				location.href="secret_music.jsp";
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
	location.href="secret_music_view.jsp?mno=<%= mno %>";
</script>