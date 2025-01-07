<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="project.*"%>
<%
	String method = request.getMethod();
	if(method.equals("GET") || session.getAttribute("uno") == null){
%>
		<script>
			alert("잘못된 접근입니다.");
			location.href="list.jsp";
		</script>
<%		
	}else{
		request.setCharacterEncoding("UTF-8");
		
		int uno = (Integer)session.getAttribute("uno");
		String title = request.getParameter("title");
		String content = request.getParameter("content");
		String open = request.getParameter("open");
		String link = request.getParameter("link");
		
		Connection conn = null;
		PreparedStatement psmt = null;
		
		try{
			conn = DBConn.conn();
			
			String sql = "INSERT INTO music_board(uno, title, content, open, link) values (?, ?, ?, ?, ?)";
			
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1,uno);
			psmt.setString(2,title);
			psmt.setString(3,content);
			psmt.setString(4,open);
			psmt.setString(5, link);
			
			int result = psmt.executeUpdate();
			
			if(result > 0){
%>
				<script>
					alert("등록이 완료되었습니다.")
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
	alert("등록 실패했습니다.");
	location.href="list.jsp";
</script>