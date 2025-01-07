<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="project.*" %>

<%
	int mno = Integer.parseInt(request.getParameter("mno"));

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
	int uno = 0;
	String link = "";
	
	List<MSComment> commentList = new ArrayList<MSComment>();
	
	try{
		conn = DBConn.conn();
		
		//조회수
		String sqlHit = "UPDATE music_board SET hit = hit+1 WHERE mno = ?";
		
		psmtHit = conn.prepareStatement(sqlHit);
		psmtHit.setInt(1,mno);
		psmtHit.executeUpdate();
		
		//상세 데이터
		String sql ="SELECT mno, m.uno, date_format(m.rdate, '%Y-%m-%d') as rdate, nickname, hit, title, content, link FROM music_board m INNER JOIN user u ON m.uno = u.uno WHERE mno = ?";

		psmt = conn.prepareStatement(sql);
		psmt.setInt(1,mno);
		
		rs = psmt.executeQuery();
		
		// 댓글
		String sqlComment = "SELECT msc.*, nickname FROM ms_comment msc INNER JOIN user u ON msc.uno = u.uno WHERE mno = ? AND u.state = 'E' ORDER BY msc.rdate desc";
		
		psmtComment = conn.prepareStatement(sqlComment);
		psmtComment.setInt(1, mno);
		
		rsComment = psmtComment.executeQuery();
		
		while(rsComment.next()){
			MSComment comment = new MSComment(rsComment.getInt("ms_cno"),
					rsComment.getInt("mno"),
					rsComment.getInt("uno"),
					rsComment.getString("content"),
					rsComment.getString("rdate"),
					rsComment.getString("nickname"));
			commentList.add(comment);
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
            <li><a href="../notice_board/list.jsp">공지사항</a></li>
            <li><a href="list.jsp">음악 추천 게시판</a></li>
            <li><a href="../artist_board/list.jsp">아티스트 정보 게시판</a></li>
            <li><a href="../secret_board/list.jsp">내가 쓴 비공개 글</a></li>
        </ul>
    </nav>
    <section>
        <h3>상세 내용</h3>
        <table>
<%
			while(rs.next()){
				rdate = rs.getString("rdate");
				nickname = rs.getString("nickname");
				hit = rs.getInt("hit");
				title = rs.getString("title");
				content = rs.getString("content");
				link = rs.getString("link");
%>
            <tr>
                <th style="width: 30%;">작성일</th>
                <td><%= rdate %></td>
            </tr>
            <tr>
                <th style="width: 30%;">닉네임</th>
                <td><%= nickname %></td>
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
            	<th colspan="2" style="text-align: center;">내용</th>
            </tr>
            <tr>
            	<td colspan="2"><%= content.replace("\n","<br>") %></td>
            </tr>
<%
			if(link != null){
%>
            <tr>
            	<td>
            		<iframe
						width="560"
						height="315"
						src="<%= link %>"
						frameborder="0"
						allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture"
						allowfullscreen>
					</iframe>
				</td>
            </tr>
<%
			}
%>
<%
			}
%>
        </table>
<%
		// 관리자와 자신이 쓴 글에만 수정, 삭제 버튼 보이기
		if(session.getAttribute("nickname")!= null){
			if(session.getAttribute("nickname").equals(nickname) || session.getAttribute("authorization").equals("A")){
%>
	        <div class="contentBtn">
	             <button onclick="location.href='modify.jsp?mno=<%= mno %>'">수정</button>
	             <button onclick="document.deleteForm.submit();">삭제</button>
	             <form name="deleteForm" action="deleteOk.jsp" method="post">
	             	<input type="hidden" name="mno" value="<%= mno %>">
	             </form>
	        </div>
<%			}	
		}
%>
        <hr>
        <h3>댓글</h3>
   	        <form id="commentAction" name="commentAction" method="post">
	        	<input type="hidden" name="mno" value="<%= mno %>">
				<input type="hidden" name="ms_cno">
	            <input type="text" id="commentContent" name="commentContent" placeholder="내용을 입력해주세요.">
	           <button type="button" onclick="submitComment()">등록</button>
	        </form>
			<script>
			let submitType = "insert";
			
			function submitComment(){
				let loginUno = '<%= session.getAttribute("uno") %>';
				
				if(loginUno != 'null'){
					if(submitType == 'insert'){
						document.commentAction.action="commentWriteOk.jsp";
					}else if(submitType == 'update'){
						document.commentAction.action="commentModifyOk.jsp";
					}
					document.commentAction.submit();
				}else{
					alert("로그인 후 사용할 수 있습니다.");
				}
			}
			
			function updateFn(c_content, ms_cno){
				submitType = "update";
				document.commentAction.commentContent.value = c_content;
				document.commentAction.ms_cno.value = ms_cno;
			}
		</script>
        <table>
        	<tr>
<%
			for(MSComment comment : commentList){
%>
	            <tr>
	                <td><%= comment.getNickname() %></td>
	                <td><%= comment.getContent() %></td>
	                <td><%= comment.getRdate() %></td>
	                <td>
<%
						if(session.getAttribute("nickname")!= null){
							if(session.getAttribute("nickname").equals(comment.getNickname()) || session.getAttribute("authorization").equals("A")){
%>
		                    <div class="commentBtn">
		                        <button onclick="updateFn('<%= comment.getContent() %>',<%= comment.getMs_cno() %>)">수정</button>
		                        <button onclick="deleteFn('<%= comment.getMs_cno() %>')">삭제</button>
		                    </div>
<%							}
						}
%>
					</td>
            	</tr>
<%			
		}
%>
			<tr>
        </table>
        <script>
        function deleteFn(ms_cno){
			document.commentDelete.ms_cno.value = ms_cno;
			document.commentDelete.submit();
		}
        </script>
        <form name="commentDelete" action="commentDeleteOk.jsp" method="post">
            <input type="hidden" name="ms_cno" >
			<input type="hidden" name="mno" value="<%= mno %>" >
        </form>
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
		DBConn.close(psmtHit, null);
		DBConn.close(rsComment, psmtComment, null);
		DBConn.close(rs, psmt, conn);
	}
%>
