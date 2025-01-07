<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="project.*" %>
<%
	request.setCharacterEncoding("UTF-8");
	
	String searchType = request.getParameter("searchType");
	if(searchType == null || searchType.equals("null")){
		searchType = "";
	}
	String searchValue = request.getParameter("searchValue");
	if(searchValue == null || searchValue.equals("null")){
		searchValue = "";
	}
	

	Connection conn = null;
	PreparedStatement psmt = null;
	ResultSet rs = null;
	
	PreparedStatement psmtTotal = null;
	ResultSet rsTotal = null;
	
	int nowPage = 1;
	if(request.getParameter("nowPage")!= null){
		nowPage = Integer.parseInt(request.getParameter("nowPage"));
	}
	
	try{
		conn = DBConn.conn();
		
		String sqlTotal ="SELECT COUNT(*) AS total FROM artist_board a INNER JOIN user u ON a.uno = u.uno WHERE open = 'O' AND u.state = 'E'";
		
		if(!searchType.equals("")){
			if(searchType.equals("nickname")){
				sqlTotal += " AND nickname like CONCAT('%',?,'%')";
			}else if(searchType.equals("title")){
				sqlTotal += " AND title like CONCAT('%',?,'%')";
			}
		}
		
		psmtTotal = conn.prepareStatement(sqlTotal);
		if(!searchType.equals("")){
			psmtTotal.setString(1,searchValue);
		}
		
		rsTotal = psmtTotal.executeQuery();
		
		int total = 0;
		
		if(rsTotal.next()){
			total=rsTotal.getInt("total");
		}
		
		PagingUtil paging = new PagingUtil(nowPage,total,10);
		
		String sql = "SELECT ano, title, nickname, date_format(a.rdate, '%Y-%m-%d') as rdate, hit FROM artist_board a INNER JOIN user u ON a.uno = u.uno WHERE open = 'O' AND u.state = 'E'"; 
		
		if(!searchType.equals("")){
			if(searchType.equals("nickname")){
				sql += " AND nickname like CONCAT('%',?,'%')";
			}else if(searchType.equals("title")){
				sql += " AND title like CONCAT('%',?,'%')";
			}
		}
		
		sql += " ORDER BY ano desc";
		sql += " LIMIT ?, ?";
		
		psmt = conn.prepareStatement(sql);
		if(!searchType.equals("")){
			psmt.setString(1,searchValue);
			psmt.setInt(2,paging.getStart());
			psmt.setInt(3,paging.getPerPage());
		}else{
			psmt.setInt(1,paging.getStart());
			psmt.setInt(2,paging.getPerPage());
		}
		
		
		rs = psmt.executeQuery();
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>아티스트 정보 게시판</title>
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
        h3 {
            color: #6748fe;
        }
        .topBtn{
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }
        form{
            display: flex;
            align-items: center;
        }
        select, input, button{
            padding: 8px;
            margin-right: 10px;
            border-radius: 1rem;
            border: 1px solid #6748fe;
            font-size: 15px;
        }
        input{
            width: 200px;
        }
        input:focus{
            border-color: #6748fe;
            outline: none;
        }
        button{
            background-color: #6748fe;
            color: white;
        }
        button:hover{
            background-color: aliceblue;
            color: #6748fe;

        }
        .write{
            margin-left: auto;
        }
        .write a{
            background-color: #6748fe;
            color: white;
            padding: 9px 20px;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            border-radius: 1rem;
        }
        .write a:hover{
            background-color: aliceblue;
            color: #6748fe;
        }
        footer{
            color: white;
            text-align: right;
            padding: 10px;
        }
        table{
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }
        th, td{
            padding: 10px;
            text-align: left;
        }
        th{
            background-color: #f2f2f2;
        }
        tr:hover{
            background-color: #f9f9f9;
        }
        .pagingAera{
            text-align: center;
            margin-top: 10px;
        }
        .pagingAera strong{
            margin: 0 5px;
            padding: 8px 12px;
            background-color: #6748fe;
            color: white;
            border-radius: 1rem;
        }
        .pagingAera a{
            margin: 0 5px;
            padding: 8px 12px;
            background-color: #6748fe;
            color: white;
            text-decoration: none;
            border-radius: 1rem;
        }
        .pagingAera a, .pagingAera strong:hover{
            background-color: aliceblue;
            color: #6748fe;
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
        		<a href="../account.jsp">계정 설정</a>
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
            <li><a href="../music_board/list.jsp">음악 추천 게시판</a></li>
            <li><a href="list.jsp">아티스트 정보 게시판</a></li>
            <li><a href="../secret_board/list.jsp">내가 쓴 비공개 글</a></li>
        </ul>
    </nav>
    <section>
        <div class="topBtn">
            <form action="list.jsp" method="get">
                <select name="searchType">
                    <option value="nickname" <%=searchType != null && searchType.equals("nickname")? "selected":"" %>>닉네임</option>
                    <option value="title" <%=searchType != null && searchType.equals("title")? "selected":"" %>>제목</option>
                </select>
                <input type="text" name="searchValue" placeholder="검색어 입력">
                <button>검색</button>
            </form>
<%
		// 로그인 상태일 때 글쓰기 버튼 노출!
		if(session.getAttribute("id") != null){
%>
            <div class="write">
                <a href="write.jsp">글쓰기</a>
            </div>
<%		
	}
%>
        </div>
        <h3>아티스트 정보 게시판</h3>
        <table>
            <thead>
                <tr>
                    <th>글번호</th>
                    <th>제목</th>
                    <th>닉네임</th>
                    <th>작성일</th>
                    <th>조회수</th>
                </tr>
            </thead>
            <tbody>
<%
				while(rs.next()){
					int ano = rs.getInt("ano");
					String title = rs.getString("title");
					String nickname = rs.getNString("nickname");
					String rdate = rs.getString("rdate");
					int hit = rs.getInt("hit");
%>
                <tr onclick="location.href='view.jsp?ano=<%= ano %>'">
                    <td><%= ano %></td>
                    <td><%= title %></td>
                    <td><%= nickname %></td>
                    <td><%= rdate %></td>
                    <td><%= hit %></td>
                </tr>
<%
			}
%>                

            </tbody>
        </table>
        <!-- 페이징 영역 -->
        <div class="pagingAera">
<%
			if(paging.getStartPage() >1){
%>
            <a href="list.jsp?nowPage=<%=paging.getStartPage()-1%>&searchType=<%=searchType%>&searchValue=<%=searchValue%>">&laquo;</a>
<%				
			}

			for(int i=paging.getStartPage(); i<=paging.getEndPage(); i++){
				if(i == nowPage){
%>
					<strong><%= i %></strong>
<%					
				}else{
%>
					<a href="list.jsp?nowPage=<%= i %>&searchType=<%=searchType%>&searchValue=<%=searchValue%>"><%= i %></a>
<%					
				}
			}
			if(paging.getEndPage() < paging.getLastPage()){
%>
            <a href="list.jsp?nowPage=<%=paging.getEndPage()+1%>&searchType=<%=searchType%>&searchValue=<%=searchValue%>">&raquo;</a>
<%				
			}
%>
        </div>
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
		DBConn.close(rsTotal,psmtTotal,null);
		DBConn.close(rs, psmt, conn);
	}
%>

