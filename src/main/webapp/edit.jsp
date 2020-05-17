<%@page import="org.json.simple.JSONObject"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="org.json.simple.JSONArray"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<%
	JSONArray arr = new JSONArray();
	Connection con;
	PreparedStatement pst;
	ResultSet rs;
	
	Class.forName("com.mysql.jdbc.Driver");
	con = DriverManager.getConnection("jdbc:mysql://localhost:3306/studentinfo","root","aditya8308307728");
		
	String id = request.getParameter("id");
	pst = con.prepareStatement("select id,student_name,course,fee from student where id = ?");
	pst.setString(1, id);
	
	rs = pst.executeQuery();
	while(rs.next()){
		String stud_id = rs.getString(1);
		String stud_name = rs.getString(2);
		String stud_course = rs.getString(3);
		String stud_fee = rs.getString(4);
		JSONObject jsonObject = new JSONObject();
		
		jsonObject.put("stud_id", stud_id);
		jsonObject.put("stud_name", stud_name);
		jsonObject.put("stud_course", stud_course);
		jsonObject.put("stud_fee", stud_fee);
		arr.add(jsonObject);
	}

	out.print(arr.toJSONString());
	out.flush();
%>