<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="project.*" %>
<%
	request.setCharacterEncoding("UTF-8");
	
	Connection conn = null;
	PreparedStatement psmtNotice = null;
	ResultSet rsNotice = null;
	
	PreparedStatement psmtHitM = null;
	PreparedStatement psmtHitA = null;
	
	PreparedStatement psmtMusic = null;
	ResultSet rsMusic = null;
	
	PreparedStatement psmtArtist = null;
	ResultSet rsArtist = null;
	
	int nno = 0;
	int mno = 0;
	int ano = 0;
	String nickname = "";
	String title = "";
	String rdate = "";
	int hit = 0;
	
	try{
		conn = DBConn.conn();
		
		//조회수 증가
		String sqlHitM = "UPDATE music_board SET hit = hit+1 WHERE mno = ?";
		
		psmtHitM = conn.prepareStatement(sqlHitM);
		psmtHitM.setInt(1,mno);
		psmtHitM.executeUpdate();
		
		String sqlHitA = "UPDATE artist_board SET hit = hit+1 WHERE ano = ?";
		psmtHitA = conn.prepareStatement(sqlHitA);
		psmtHitA.setInt(1,ano);
		psmtHitA.executeUpdate();
		
		// notice board 목록
		String sqlNotice = "SELECT nno, title, date_format(n.rdate, '%Y-%m-%d') as rdate FROM notice_board n INNER JOIN user u ON n.uno = u.uno WHERE open = 'O' order by n.rdate desc limit 0, 2";
		psmtNotice = conn.prepareStatement(sqlNotice);
		rsNotice = psmtNotice.executeQuery();
		
		// music board 목록
		String sqlMusic = "SELECT mno, nickname, title, date_format(m.rdate, '%Y-%m-%d') as rdate, hit FROM music_board m INNER JOIN user u ON m.uno = u.uno WHERE open = 'O' AND u.state = 'E' order by m.hit desc limit 0, 3";
		psmtMusic = conn.prepareStatement(sqlMusic);
		rsMusic = psmtMusic.executeQuery();
		
		// artist board 목록
		String sqlArtist = "SELECT ano, nickname, title, date_format(a.rdate, '%Y-%m-%d') as rdate, hit FROM artist_board a INNER JOIN user u ON a.uno = u.uno WHERE open = 'O' AND u.state = 'E' order by a.hit desc limit 0, 3";
		psmtArtist = conn.prepareStatement(sqlArtist);
		rsArtist = psmtArtist.executeQuery();
		
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>main</title>
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
        h3 a{
            color: #6748fe;
            text-decoration: none;
        }
        h3 a:hover{
            color: #bbc4fd;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }
        th, td {
            padding: 10px;
            text-align: left;
        }
        th {
            background-color: #f2f2f2;
            border-radius: 1rem;
        }
        tr:hover {
            background-color: #f9f9f9;
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
        <h1><a href="index.jsp">MUSIC IS LIFE!</a></h1>
        <div class="loginBtn">
<%
			if(session.getAttribute("id") != null){
				nickname = (String)session.getAttribute("nickname");
%>
        		<strong><%= nickname %></strong>님 반갑습니다.
        		<a href="logout.jsp">Logout</a>
        		<a href="account.jsp">계정 설정</a>
<%				
			}else{
%>
            <a href="login.jsp">Login</a>
            <a href="signUp.jsp">Sign up</a>
<%				
			}
%>
        
        </div>
    </header>
    <nav>
        <ul>
            <li><a href="notice_board/list.jsp">공지사항</a></li>
            <li><a href="music_board/list.jsp">음악 추천 게시판</a></li>
            <li><a href="artist_board/list.jsp">아티스트 정보 게시판</a></li>
            <li><a href="secret_board/list.jsp">내가 쓴 비공개 글</a></li>
        </ul>
    </nav>
    <section>
        <h3><a href="notice_board/list.jsp">공지사항</a></h3>
        <table>
            <thead>
                <tr>
                    <th>제목</th>
                    <th>작성일</th>
                </tr>
            </thead>
            <tbody>
<%
				while(rsNotice.next()){
					nno = rsNotice.getInt("nno");
					title = rsNotice.getString("title");
					rdate = rsNotice.getString("rdate");
%>
	                <tr onclick="location.href='notice_board/view.jsp?nno=<%= nno %>'">
	                    <td><%= title %></td>
	                    <td><%= rdate %></td>
	                </tr>
<%
				}
%>
            </tbody>
        </table>
        <h3><a href="music_board/list.jsp">음악 추천 게시판</a></h3>
        <table>
            <thead>
                <tr>
                    <th>닉네임</th>
                    <th>제목</th>
                    <th>작성일</th>
                    <th>조회수</th>
                </tr>
            </thead>
            <tbody>
<%
				while(rsMusic.next()){
					mno = rsMusic.getInt("mno");
					nickname = rsMusic.getNString("nickname");
					title = rsMusic.getString("title");
					rdate = rsMusic.getString("rdate");
					hit = rsMusic.getInt("hit");
%>
	                <tr onclick="location.href='music_board/view.jsp?mno=<%= mno %>'">
	                    <td><%= nickname %></td>
	                    <td><%= title %></td>
	                    <td><%= rdate %></td>
	                    <td><%= hit %></td>
	                </tr>
<%
				}
%>
            </tbody>
        </table>
        <h3><a href="artist_board/list.jsp">아티스트 정보 게시판</a></h3>
        <table>
            <thead>
                <tr >
                    <th>닉네임</th>
                    <th>제목</th>
                    <th>작성일</th>
                    <th>조회수</th>
                </tr>
            </thead>
            <tbody>
<%
				while(rsArtist.next()){
					ano = rsArtist.getInt("ano");
					nickname = rsArtist.getNString("nickname");
					title = rsArtist.getString("title");
					rdate = rsArtist.getString("rdate");
					hit = rsArtist.getInt("hit");
%>
	                <tr onclick="location.href='artist_board/view.jsp?ano=<%= ano %>'">
	                    <td><%= nickname %></td>
	                    <td><%= title %></td>
	                    <td><%= rdate %></td>
	                    <td><%= hit %></td>
	                </tr>
<%
				}
%>
            </tbody>
        </table>
    </section>
    <footer>
        &copy; MADE BY GaWonKim
    </footer>
</body>
</html>
<%		
	}catch(Exception e){
		e.printStackTrace();
		out.print(e.getMessage());
	}finally{
		DBConn.close(psmtHitM, null);
		DBConn.close(psmtHitA, null);
		DBConn.close(rsMusic, psmtMusic, conn);
		DBConn.close(rsArtist, psmtArtist, conn);
		DBConn.close(rsNotice, psmtNotice, conn);
	}

%>
