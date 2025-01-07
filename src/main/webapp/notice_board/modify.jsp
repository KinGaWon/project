<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="project.*" %>
<%
	int nno = Integer.parseInt(request.getParameter("nno"));

	Connection conn = null;
	PreparedStatement psmt = null;
	ResultSet rs = null;
	
	String title = "";
	String content = "";
	String rdate = "";
	int hit = 0;
	
	
	try{
		conn = DBConn.conn();
		
		String sql = "SELECT nno, date_format(n.rdate, '%Y-%m-%d') as rdate, hit, title, content FROM notice_board n INNER JOIN user u ON n.uno = u.uno WHERE nno = ?";
		
		psmt = conn.prepareStatement(sql);
 		psmt.setInt(1,nno);
 		rs = psmt.executeQuery();
 		
 		if(rs.next()){
 			title = rs.getString("title");
 			content = rs.getString("content");
 		}
 		
	}catch(Exception e){
		e.printStackTrace();
		out.print(e.getMessage());
	}finally{
		DBConn.close(rs, psmt, conn);
	}
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>게시글 내용 수정</title>
    <style>
        body, html{
            margin: 0px;
            padding: 0px;
            background-color: #bbc4fd;
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }
        header{
            padding: 10px;
            display: flex;
            justify-content: center;
            align-items: center;
            position: relative;
        }
        h1 a{
            color: black;
            text-decoration: none;
        }
        h1 a:hover{
            color: white;
        }
        .loginBtn{
            position: absolute;
            right: 10px;
            top: 10px;
        }
        .loginBtn a{
            background-color: #6748fe;
            color: white;
            padding: 5px 20px;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            border-radius: 1rem;
        }
        .loginBtn a:hover{
            background-color: aliceblue;
            color: #6748fe;
        }
        nav ul{
            margin: 0px;
            padding: 0px;
            display: flex;
            list-style: none;
            justify-content: center;
        }
        nav a{
            color: #6748fe;
            text-decoration: none;
            padding: 15px;
            display: block;
        }
        nav a:hover{
            color: #6748fe;
            background-color: aliceblue;
        }
        section{
            background-color: white;
            width: 100%;
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
            flex: 1;
            position: relative;
        }
        h3{
            text-align: center;
            color: #6748fe;
        }
        table{
            width: 100%;
            border-collapse: collapse;
            margin: 10px 0;
        }
        th, td {
            padding: 10px;
            border: 1px solid #ccc;
            text-align: left;
        }
        th {
            background-color: #f2f2f2;
        }
        input[type="text"], textarea{
            width: calc(100% - 20px);
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 1rem;
        }
        input:focus, textarea:focus{
            border-color: #6748fe;
            outline: none;
        }
        textarea{
            height: 200px;
            resize: none;
        }
        .contentBtn button{
        	margin: 5px;
            padding: 5px 10px;
            border: none;
            border-radius: 1rem;
            display: inline;
        }
        .contentBtn button:hover{
    	    background-color: #6748fe;
            color: white;
        }
        footer{
            color: white;
            text-align: right;
            padding: 10px;
        }
    </style>
</head>
<body>
    <header>
        <h1><a href="../index.jsp">MUSIC IS LIFE!</a></h1>
        <div class="loginBtn">
<%
			if(session.getAttribute("id") != null){
				String nickname = (String)session.getAttribute("nickname");
%>
        		<strong><%= nickname %></strong>님 반갑습니다.
        		<a href="../logout.jsp">Logout</a>
<%				
			}else{
%>
            <a href="../login.jsp">Login</a>
            <a href="../signUp.jsp">Sign up</a>
<%				
			}
%>
        </div>
    </header>
    <nav>
        <ul>
            <li><a href="list.jsp">공지사항</a></li>
            <li><a href="../music_board/list.jsp">음악 추천 게시판</a></li>
            <li><a href="../artist_board/list.jsp">아티스트 정보 게시판</a></li>
            <li><a href="../secret_board/list.jsp">내가 쓴 비공개 글</a></li>
        </ul>
    </nav>
    <section>
        <h3>내용 수정</h3>
        <form action="modifyOk.jsp" method="post">
       	<input type="hidden" name="nno" value="<%= nno %>">
	        <table>
	            <tr>
	                <th>작성일</th>
	                <td><%= rdate %></td>
	            </tr>
	            <tr>
	                <th>조회수</th>
	                <td><%= hit %></td>
	            </tr>
	            <tr>
	                <th>글 공개 여부</th>
	                <td>
	                    <label><input type="radio" name="open" value="O" checked>공개</label>
	                    <label><input type="radio" name="open" value="S">비공개</label>
	                </td>
	            </tr>
	            <tr>
	                <th>제목</th>
	                <td><input type="text" name="title" value="<%= title %>"></td>
	            </tr>
	            <tr>
	                <td colspan="2">
	                	<textarea name="content"><%= content %></textarea>
	                </td>
	            </tr>
	        </table>
	        <div class="contentBtn">
	            <button>저장</button>
				<button type="button" onclick="location.href='view.jsp?nno=<%= nno %>'">취소</button>
	        </div>
        </form>
    </section>
    <footer>
        &copy; MADE BY GaWonKim
    </footer>
</body>
</html>