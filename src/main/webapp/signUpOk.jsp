<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="project.*" %>
<%
	if(request.getMethod().equals("GET")){
%>
	<script>
		alert("잘못된 접근입니다.");
		location.href="signUp.jsp";
	</script>
<%		
	}else{
		request.setCharacterEncoding("UTF-8");
		
		String id = request.getParameter("id");
		String password = request.getParameter("password");
		String name = request.getParameter("name");
		String email = request.getParameter("email");
		String nickname = request.getParameter("nickname");
		
		
		Connection conn = null;
		PreparedStatement psmt = null;
		
		try{
			conn = DBConn.conn();
			
			String sql = "INSERT INTO user(id,password,name,email,nickname) values (?, ?, ?, ?, ?)";
			
			psmt = conn.prepareStatement(sql);
			psmt.setString(1,id);
			psmt.setString(2,password);
			psmt.setString(3,name);
			psmt.setString(4,email);
			psmt.setString(5,nickname);
			
			int result = psmt.executeUpdate();
			
			if(result > 0){
%>
				<script>
					alert("환영합니다! 회원가입이 되셨습니다.");
					location.href="login.jsp";
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
		alert("회원가입이 실패하였습니다.");
		location.href="signUp.jsp";
	</script>