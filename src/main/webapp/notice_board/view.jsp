<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="project.*" %>

<%
	int nno = Integer.parseInt(request.getParameter("nno"));

	Connection conn = null;
	PreparedStatement psmt = null;
	ResultSet rs = null;
	
	PreparedStatement psmtHit = null;
	
	PreparedStatement psmtComment = null;
	ResultSet rsComment = null;
	
	String rdate = "";
	String nickname = "";
	int hit = 0;
	String title = "";
	String content = "";
	
	List<Comment> commentList = new ArrayList<Comment>();
	
	try{
		conn = DBConn.conn();
		
		//조회수
		String sqlHit = "UPDATE notice_board SET hit = hit+1 WHERE nno = ?";
		
		psmtHit = conn.prepareStatement(sqlHit);
		psmtHit.setInt(1,nno);
		psmtHit.executeUpdate();
		
		//상세 데이터
		String sql ="SELECT nno, date_format(n.rdate, '%Y-%m-%d') as rdate, nickname, hit, title, content FROM notice_board n INNER JOIN user u ON n.uno = u.uno WHERE nno = ?";

		psmt = conn.prepareStatement(sql);
		psmt.setInt(1,nno);
		
		rs = psmt.executeQuery();
		
		if(rs.next()){
			rdate = rs.getString("rdate");
			nickname = rs.getString("nickname");
			hit = rs.getInt("hit");
			title = rs.getString("title");
			content = rs.getString("content");
		}
	}catch(Exception e){
		e.printStackTrace();
		out.print(e.getMessage());
	}finally{
		DBConn.close(psmtHit, null);
		DBConn.close(rsComment, psmtComment, null);
		DBConn.close(rs, psmt, conn);
	}
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>게시글 상세 내용</title>
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
            border: 1px solid white;
        }
        td {
        text-align: left;
        }
        th {
            background-color: #f2f2f2;
            border-radius: 1rem;
            text-align: center;
        }
        button {
            margin: 5px;
            padding: 5px 10px;
            border: none;
            border-radius: 1rem;
        }
        button:hover {
            background-color: #6748fe;
            color: white;
        }
        .contentBtn{
            display: flex;
            justify-content: flex-end;
        }
        .contentBtn button{
        	margin: 5px;
            padding: 5px 10px;
            border: none;
            border-radius: 1rem;
        }
        .contentBtn button:hover{
    	    background-color: #6748fe;
            color: white;
        }
        #commentContent {
            width: calc(100% - 130px);
            padding: 5px;
            border-radius: 1rem;
            border: 1px solid #ccc;
            margin-right: 10px;
        }
        #commentContent:focus{
            border-color: #6748fe;
            outline: none;
        }
        .commentBtn{
            display: inline;
        }
        .commentBtn button{
        	margin: 5px;
            padding: 5px 10px;
            border: none;
            border-radius: 1rem;
        }
        .commentBtn button:hover{
    	    background-color: #6748fe;
            color: white;
        }
        #commentAction{
            display: flex;
            justify-content: flex-end;
        }
        #commentAction button{
        	margin: 5px;
            padding: 8px 10px;
            border: none;
            border-radius: 1rem;
        }
        #commentAction button:hover{
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
				nickname = (String)session.getAttribute("nickname");
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
        <h3>상세 내용</h3>
        <table>
            <tr>
                <th style="width: 30%;">작성일</th>
                <td><%= rdate %></td>
            </tr>
            <tr>
                <th style="width: 30%;">조회수</th>
                <td><%= hit %></td>
            </tr>
            <tr>
                <th style="width: 30%;">제목</th>
                <td><%= title %></td>
            </tr>
            <tr>
            	<th colspan="2">내용</th>
            </tr>
            <tr>
            	<td colspan="2"><%= content.replace("\n","<br>") %></td>
            </tr>
        </table>
<%
		// 관리자만 글 수정, 삭제 버튼 보이기
		if(session.getAttribute("authorization") != null && session.getAttribute("authorization").equals("A")){
%>
	        <div class="contentBtn">
	             <button onclick="location.href='modify.jsp?nno=<%= nno %>'">수정</button>
	             <button onclick="document.deleteForm.submit();">삭제</button>
	             <form name="deleteForm" action="deleteOk.jsp" method="post">
	             	<input type="hidden" name="nno" value="<%= nno %>">
	             </form>
	        </div>
<%			
		}
%>
    </section>
    <footer>
        &copy; MADE BY GaWonKim
    </footer>
</body>
</html>