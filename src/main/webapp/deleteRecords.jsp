<%@page import="util.JDBCConnection"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="org.json.simple.JSONArray"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<%
	JSONArray  arr = new JSONArray();
	
	String stud_id = request.getParameter("id");
	Connection con;
	PreparedStatement ps;
	
	JSONObject obj = new JSONObject();
	
	con = JDBCConnection.getConnection();
	
	ps = con.prepareStatement("delete from student where id = ?");
	ps.setString(1,stud_id);
	ps.executeUpdate();

	obj.put("name", "success");
	arr.add(obj);	
	out.println(arr.toJSONString());
	out.flush();
%>