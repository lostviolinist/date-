<%@ page import="java.sql.Date" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.text.SimpleDateFormat" %><%--
  Created by IntelliJ IDEA.
  User: roufanliau
  Date: 2019-05-30
  Time: 23:06
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>



<%
    Class.forName("com.mysql.jdbc.Driver");
    Statement stm = DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/users?useSSL=false",
            "root",
            "rootroot").createStatement();




    String content = request.getParameter("post");
    String userName = session.getAttribute("userId").toString();
    SimpleDateFormat formatter= new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    Date post_time = new Date(System.currentTimeMillis());
    String date = formatter.format(post_time);


    String sql_writePost = "insert into posts values(\""+date+"\",\""+userName+"\",\""+content+"\");";

    stm.executeUpdate(sql_writePost);

    RequestDispatcher req = request.getRequestDispatcher("main.jsp");
    req.forward(request, response);

%>