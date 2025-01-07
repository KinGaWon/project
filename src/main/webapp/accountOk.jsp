<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="project.*"%>
<%
	if(request.getMethod().equals("GET")){
%>
		<script>
			alert("잘못된 접근입니다.");
			location.href="index.jsp";
		</script>	
<%
	}else{
		request.setCharacterEncoding("UTF-8");
		
		int uno = Integer.parseInt(request.getParameter("uno"));
		String state = request.getParameter("state");
		
		Connection conn = null;
		PreparedStatement psmt = null;
		
		try{
			conn = DBConn.conn();
			
			String sql = "UPDATE project.user SET state = ? WHERE uno = ?";
			
			psmt = conn.prepareStatement(sql);
			psmt.setString(1,state);
			psmt.setInt(2,uno);
			
			int result = psmt.executeUpdate();
			
			if(result > 0){
				if(state.equals("E")){
%>
					<script>
						alert("계정이 활성화 되었습니다.");
						location.href="index.jsp";
					</script>
<%
				}else{
%>
					<script>
						alert("계정이 비활성화 되었습니다.");
						location.href="logout.jsp";
					</script>
<%
				}
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
	alert("변경 실패했습니다.");
	location.href="index.jsp";
</script>