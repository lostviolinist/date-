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



    String firstName = request.getParameter("firstName");
    String lastName = request.getParameter("lastName");
    String userName = request.getParameter("userName");
    String password = request.getParameter("password");
    String confirmPassword = request.getParameter("confirmPassword");
    String date = request.getParameter("YYYY_dob")+"-"+request.getParameter("MM_dob")+"-"+request.getParameter("DD_dob");
    String gender = request.getParameter("gender");
    String interested = request.getParameter("interested");
    Boolean userNameTaken = false;

    int dd = Integer.parseInt(request.getParameter("DD_dob"));
    int mm = Integer.parseInt(request.getParameter("MM_dob"));
    int yyyy = Integer.parseInt(request.getParameter("YYYY_dob"));
    int Gender,Interested;
    if(gender.equals("male"))
        Gender=0;
    else
        Gender=1;

    if(interested.equals("male"))
        Interested=0;
    else if(interested.equals("female"))
        Interested=1;
    else
        Interested=2;

    SimpleDateFormat formatter= new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    Date post_time = new Date(System.currentTimeMillis());
    String profile_picture;
    if(Gender==0)
        profile_picture="man_icon.png";
    else
        profile_picture="women_icon.png";


    String sql_getusername = "select * from user_data;";
    String sql_addUser = "insert into user_data" +
            " values( \"" + userName +"\"  ,\""+firstName +"\",\""+ lastName +"\",\"" + password +"\",\"" + date+"\",\""+Gender+"\",\""+Interested+"\",\""+profile_picture+"\");";
    String sql_initpost = "insert into posts values (\""+formatter.format(post_time)+"\", \""+userName+"\",\"Hi, I am "+firstName+" "+lastName+".\")";

    ResultSet username = stm.executeQuery(sql_getusername);
    while(username.next()) {
        if (username.getString("userName").equals(userName)) {
            userNameTaken = true;
        }
    }
    if(!password.equals(confirmPassword)){
        %>
        <script>
            alert("Password and Confirm Password not the same!");
        </script><%
        RequestDispatcher req = request.getRequestDispatcher("signup.jsp");
        req.include(request, response);
    }
    else if(dd<1||dd>31||mm<1||mm>12||yyyy<1900||yyyy>2003){
        %>
        <script>
            alert("Invalid date of birth");
        </script><%

        RequestDispatcher req = request.getRequestDispatcher("signup.jsp");
        req.include(request, response);}
    else if(userNameTaken){
        %>
        <script type="text/javascript">
                        alert("The username is taken!");
                        </script><%
        RequestDispatcher req = request.getRequestDispatcher("signup.jsp");
        req.include(request, response);
            }
    else
    {
        stm.executeUpdate(sql_addUser);
        stm.executeUpdate(sql_initpost);
        RequestDispatcher req = request.getRequestDispatcher("index.jsp");
        req.forward(request, response);
}
%>

