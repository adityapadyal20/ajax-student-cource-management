<%@page import="util.JDBCConnection"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="org.json.simple.JSONArray"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

    <%
		JSONArray list = new JSONArray();
    	Connection con;
    	PreparedStatement ps;
    	ResultSet rs;
    	
    	con = JDBCConnection.getConnection();
   
    	String sql = "select * from student";
    	Statement statement = con.createStatement();
    	rs = statement.executeQuery(sql);
    	
    	while(rs.next()){
    		JSONObject obj = new JSONObject();
    		String id = rs.getString(1);
    		String name = rs.getString(2);
    		String cource = rs.getString(3);
    		String fee = rs.getString(4);
    		
    		obj.put("name", name);
    		obj.put("course", cource);
    		obj.put("fee", fee);
    		obj.put("id",id);
    		list.add(obj);
    		
    		}
    	out.print(list.toJSONString());
    	out.flush();
	%>