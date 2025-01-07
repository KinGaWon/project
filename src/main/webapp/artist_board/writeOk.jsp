<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="project.*"%>
<%
	String method = request.getMethod();
	if(method.equals("GET") || session.getAttribute("uno") == null){
%>
		<script>
			alert("잘못된 접근입니다.");
			location.href="list.jsp";
		</script>
<%		
	}else{
		request.setCharacterEncoding("UTF-8");
		
		int size = 10*1024*1024;
		String uploadPath = "D:\\KGW\\workspace\\project\\src\\main\\webapp\\upload";
		uploadPath = request.getServletContext().getRealPath("/upload");
		MultipartRequest multi = null;
		
		int uno = (Integer)session.getAttribute("uno");
		
		Connection conn = null;
		PreparedStatement psmt = null;
		
		try{
			conn = DBConn.conn();
			
			multi = new MultipartRequest(request, uploadPath, size, "UTF-8", new DefaultFileRenamePolicy());
			
			String title = multi.getParameter("title");
			String content = multi.getParameter("content");
			String open = multi.getParameter("open");
			
			Enumeration<?> files= multi.getFileNames();
			String phyName = ""; //물리명
			String logiName = ""; //논리명
			
			if(files != null){
				String fileId = (String) files.nextElement();
				String fileName = (String)multi.getFilesystemName("filename");
				if(fileName != null){
					String fileExtension = "";
					int dotIdx = 0;
					dotIdx = fileName.lastIndexOf(".");
					if(dotIdx > 0){
						fileExtension = fileName.substring(dotIdx).toLowerCase();
					}
					if(!fileExtension.equals(".jpg")){
						response.sendRedirect(request.getContextPath()+"/artist_board/list.jsp"); return;
					}
					String newFileName = UUID.randomUUID().toString();
					
					String orgName = uploadPath + "\\" + fileName;
					String newName = uploadPath + "\\" + newFileName;
					
					File srcFile = new File(orgName);
					File targetFile = new File(newName);
					srcFile.renameTo(targetFile);

					phyName = newFileName;
					logiName = fileName;
					
					String sqlfile = "INSERT INTO artist_board(uno, title, content, open, filename, originalfile) values(?,?,?,?,?,?)";
					psmt = conn.prepareStatement(sqlfile);
					psmt.setInt(1,uno);
					psmt.setString(2, title);
					psmt.setString(3, content);
					psmt.setString(4, open);
					psmt.setString(5, phyName);
					psmt.setString(6, logiName);
					
					int result = psmt.executeUpdate();
					
					if(result > 0){
%>
						<script>
							alert("등록이 완료되었습니다.")
							location.href="list.jsp";
						</script>
<%				
					}
					
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
	alert("등록 실패했습니다.");
	location.href="list.jsp";
</script>