<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="project.*"%>
<%
	if(request.getMethod().equals("GET")){
%>
	<script>
		alert("잘못된 접근입니다.");
		location.href="list.jsp";
	</script>	
<%		
	}else {
		request.setCharacterEncoding("UTF-8");
		
		int mno = Integer.parseInt(request.getParameter("mno"));
		String title = request.getParameter("title");
		String content= request.getParameter("content");
		String open = request.getParameter("open");
		String link = request.getParameter("link");
		
		Connection conn = null;
		PreparedStatement psmt = null;
		
		try{
			conn = DBConn.conn();
			
			String sql = "UPDATE music_board SET title = ?, content = ?, open = ?, link = ? WHERE mno = ?";
			
			psmt = conn.prepareStatement(sql);
			psmt.setString(1,title);
			psmt.setString(2,content);
			psmt.setString(3,open);
			psmt.setString(4,link);
			psmt.setInt(5,mno);
			
			int result = psmt.executeUpdate();
			
			if(result > 0){
%>
				<script>
					alert("수정되었습니다.");
					location.href="view.jsp?mno=<%=mno%>";
				</script>
<%
			}
			
		}catch(Exception e){
			e.printStackTrace();
			out.print(e.getMessage());
		}finally{
			DBConn.close(psmt,conn);
		}
		
	}
%>
<script>
	alert("수정 실패했습니다.");
	location.href="list.jsp";
</script>