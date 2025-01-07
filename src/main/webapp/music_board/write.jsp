<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	if(session.getAttribute("id") == null){
%>
		<script>
			alert("잘못된 접근입니다.")
			location.href="list.jsp";
		</script>
<%		
	}
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>글쓰기</title>
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
        .write{
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
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
        .Btn{
            text-align: center;
            margin-top: 10px;
        }
        .Btn button{
            background-color: #6748fe;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 1rem;
            margin-right: 10px;
        }
        .Btn button:hover {
            background-color: aliceblue;
            color: #6748fe;
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
            <li><a href="../notice_board/list.jsp">공지사항</a></li>
            <li><a href="list.jsp">음악 추천 게시판</a></li>
            <li><a href="../artist_board/list.jsp">아티스트 정보 게시판</a></li>
            <li><a href="../secret_board/list.jsp">내가 쓴 비공개 글</a></li>
        </ul>
    </nav>
    <section>
        <h3>글쓰기</h3>
        <form action="writeOk.jsp" method="post">
            <div class="write">제목</div>
            <input type="text" id="title" name="title" placeholder="제목을 입력해주세요.">
            
            <div class="write">내용</div>
            <textarea id="content" name="content" placeholder="내용을 입력해주세요."></textarea>
            
            <div class="write">링크</div>
            <input type="text" id="link" name="link" placeholder="링크를 입력해주세요.">
            
            <div class="write">글 공개 여부</div>
            <label><input type="radio" name="open" value="O" checked>공개</label>
            <label><input type="radio" name="open" value="S">비공개</label>
            
            <div class="Btn">
                <button>저장</button>
				<button type="button" onclick="location.href='list.jsp'">취소</button>
            </div>
        </form>
    </section>
    <footer>
        &copy; MADE BY GaWonKim
    </footer>
</body>
</html>