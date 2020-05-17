<%@page import="java.sql.DriverManager"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="org.json.simple.JSONArray"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<%
	JSONArray arr = new JSONArray();
	
	String stid = request.getParameter("studentid");
	String stud_name = request.getParameter("stname");
	String course = request.getParameter("course");
	String fee = request.getParameter("courseFee");
	
	Connection con;
	PreparedStatement ps;
	ResultSet rs;
	
	JSONObject obj = new JSONObject();
	
	Class.forName("com.mysql.jdbc.Driver");
	con = DriverManager.getConnection("jdbc:mysql://localhost:3306/studentinfo","root","aditya8308307728");
	ps = con.prepareStatement("update student set student_name=?,course=?,fee=? where id=?");
	ps.setString(1, stud_name);
	ps.setString(2, course);
	ps.setString(3, fee);
	ps.setString(4, stid);
	ps.executeUpdate();
	
	obj.put("name", "success");
	arr.add(obj);	
	out.println(arr.toJSONString());
	out.flush();
	
%>