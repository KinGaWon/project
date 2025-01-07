<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.*" %>
<%@ page import="java.net.URLEncoder" %>
<%
	request.setCharacterEncoding("UTF-8");
	
	String orgName = request.getParameter("logiName");
	String phyName = request.getParameter("phyName");
	if( orgName == null || orgName.equals("") || phyName == null || phyName.equals("") ) {
			response.sendRedirect("list.jsp");
	}
	
	String uploadPath = "D:\\KGW\\workspace\\project\\src\\main\\webapp\\upload";
	uploadPath = request.getServletContext().getRealPath("/upload");
	phyName = uploadPath + "\\" + phyName;
	response.setContentType("application/octet-stream");
	orgName = URLEncoder.encode(orgName, "UTF-8");
	response.setHeader("Content-Disposition", "attachment; filename=" + orgName );
	
	File file = new File(phyName);
	
	FileInputStream fileIn = new FileInputStream(file);
	
	ServletOutputStream ostream = response.getOutputStream();
	
	byte[] outputByte = new byte[4096];
	
	while(fileIn.read(outputByte, 0, 4096 ) != -1){
		ostream.write(outputByte, 0, 4096);
	}
	fileIn.close();
	
	ostream.flush();
	ostream.close();
%>