<%@page import="util.JDBCConnection"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<%
	JSONArray list = new JSONArray();
	
	String studName = request.getParameter("stname");
	String course = request.getParameter("course");
	String fee = request.getParameter("courseFee");
	
	Connection con;
	PreparedStatement ps;
	ResultSet rs;
	
	JSONObject obj = new JSONObject();
	con = JDBCConnection.getConnection();
	ps = con.prepareStatement("insert into student (student_name,course,fee)values(?,?,?)");
	ps.setString(1, studName);
	ps.setString(2, course);
	ps.setString(3, fee);
	ps.executeUpdate();
	
	obj.put("name", "success");
	list.add(obj);	
	
	out.println(list.toJSONString());
	out.flush();
	
%>