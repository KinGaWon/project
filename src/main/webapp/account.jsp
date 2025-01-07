<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="project.*" %>
<%
	if(session.getAttribute("id") == null){
%>
		<script>
			alert("로그인 후 사용 가능합니다.")
			location.href="index.jsp";
		</script>
<%
	}else{
		
//		int uno = Integer.parseInt(session.getAttribute("uno"));
		int uno = 0;
		if(session.getAttribute("uno") != null)
		{
			uno = (int)session.getAttribute("uno");
		}
		
		if( uno < 1 ){	%>
		<script>
			alert("로그인 정보가 올바르지 않습니다")
			location.href="index.jsp";
		</script>	
<%		}
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		String state = "";
		
		try{
			conn = DBConn.conn();
			
			String sql = "SELECT uno, state FROM user WHERE uno = ?";
			
			psmt = conn.prepareStatement(sql);
	 		psmt.setInt(1,uno);
	 		
	 		rs = psmt.executeQuery();
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>계정 설정</title>
    <style>
        body, html{
            margin: 0px;
            padding: 0px;
            background-color: #bbc4fd;

        }
        a:link, a:visited {
            text-decoration: none;
            color: #6748fe;
        }
        .loginForm{
            background-color: white;
            border-radius: 1rem;
            text-align: center;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            padding: 20px;
            width: 90%;
            max-width: 400px;
            position: fixed;
        }
        h2{
            text-align: center;
            color: #6748fe;
        }
        .input{
            background-color: white;
            border-radius: 1rem;
            border-style: dashed;
            border-color: #bbc4fd;
            padding: 10px;
            margin: 8px;
            width: 250px;
        }
        button{
        	background-color: #6748fe;
            color: white;
            padding: 8px 15px;
            border: none;
            border-radius: 1rem;
        }
        button:hover{
        	background-color: aliceblue;
            color: #6748fe;
        }
        .inputBtn{
            background-color: #6748fe;
            color: white;
            border-radius: 1rem;
            border-style: none;
            padding: 10px;
            margin: 8px;
            width: 250px;
        }
        .inputBtn:hover{
            background-color: #bbc4fd;
            color: #6748fe;
        }
        span{
            font-size: smaller;
        }
    </style>
</head>
<body>
    <div class="loginForm">
    	<h2>계정 설정</h2>
    	<strong><%= session.getAttribute("nickname") %></strong>님<br><br>
        <form action="accountOk.jsp" method="post">
        <input type="hidden" name="uno" value="<%= uno %>">
                <label><input type="radio" name="state" value="E" checked>활성화</label>
                <label><input type="radio" name="state" value="D">비활성화</label><br><br>
                <button>저장</button>
		</form>
        <a href="index.jsp" style="font-size: small">홈으로 돌아가기</a>
    </div>
</body>
</html>
<%
		}catch(Exception e){
			e.printStackTrace();
			out.print(e.getMessage());
		}finally{
			DBConn.close(rs, psmt, conn);
		}
	}
%>
