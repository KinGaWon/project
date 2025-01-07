<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="project.*"%>
<%
	request.setCharacterEncoding("UTF-8");

	int mno = Integer.parseInt(request.getParameter("mno"));
	if(request.getMethod().equals("GET")){
%>
		<script>
			alert("잘못된 접근입니다.");
			location.href="view.jsp?mno=<%= mno %>";
		</script>
<%		
	}else{
		int uno = (Integer)session.getAttribute("uno");
		String content = request.getParameter("commentContent");
		
		Connection conn = null;
		PreparedStatement psmt = null;
		
		try{
			conn = DBConn.conn();
			
			String sql = "insert into ms_comment(uno, mno, content)values(?, ?, ?)";
			
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1,uno);
			psmt.setInt(2,mno);
			psmt.setString(3,content);
			
			
			int result = psmt.executeUpdate();
			
			
		}catch(Exception e){
			e.printStackTrace();
			out.print(e.getMessage());
		}finally{
			DBConn.close(psmt, conn);
		}
		
		response.sendRedirect("view.jsp?mno="+mno);
	}
%>
<script>
	alert("등록이 실패하였습니다.");
	location.href="view.jsp?mno=<%= mno %>";
</script>