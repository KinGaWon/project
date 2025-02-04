<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="project.*" %>
<%
	String methodType = request.getMethod();
	String id = "";
	String password = "";
	if(methodType.equals("GET")){
%>
	<script>
		alert("잘못된 접근입니다");
		location.href="login.jsp";
	</script>
<%		
	}else{
		id = request.getParameter("id");
		password = request.getParameter("password");
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		try{
			conn = DBConn.conn();
			
			String sql = "SELECT * FROM user WHERE id = ? AND password = ?";
			psmt = conn.prepareStatement(sql);
			psmt.setString(1,id);
			psmt.setString(2,password);
			
			rs = psmt.executeQuery();
			
			if(rs.next()){
				id = rs.getString("id");
				int uno = rs.getInt("uno");
				String nickname = rs.getString("nickname");
				String authorization = rs.getString("authorization");
				String state = rs.getString("state");
			
				session.setAttribute("id", id);
				session.setAttribute("uno", uno);
				session.setAttribute("nickname", nickname);
				session.setAttribute("authorization", authorization);
				session.setAttribute("state", state);
%>
			<script>
				location.href = "<%= request.getContextPath()%>/index.jsp";
			</script>
<%						
			}
			
			
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			DBConn.close(rs, psmt, conn);
		}
		
		
	}
%>
	<script>
		alert("로그인에 실패했습니다.");
		location.href = "login.jsp";
	</script>

