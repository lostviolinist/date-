<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %><%--
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
    String userName = session.getAttribute("userId").toString();
    String sql_getUser = "select * from user_data where userName = \""+userName+"\";";
    ResultSet rs_getUser = stm.executeQuery(sql_getUser);
    rs_getUser.next();
    String firstName = rs_getUser.getString("firstName");
    String lastName = rs_getUser.getString("lastName");
    String password = rs_getUser.getString("password");
    String birthday = rs_getUser.getString("birthday");
    int gender = Integer.parseInt(rs_getUser.getString("gender"));
    int interested = Integer.parseInt(rs_getUser.getString("interested"));

    SimpleDateFormat formatter= new SimpleDateFormat("yyyy-MM-dd");
    Date current_date = new Date(System.currentTimeMillis());
    String date = formatter.format(current_date);
    int year = Integer.parseInt(date.substring(0,4));
    year-=16;
    date = Integer.toString(year) + date.substring(4,10);

%>

<html>
<head>
    <title>Edit Profile</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
<div id="grad">
    <table>
        <tr>

            <td width="80%">
                <h4>Edit Profile</h4>
            </td>
            <td width="10%">
                <a href="main.jsp"<h5>Back</h5></td>
            </td>
        </tr>
    </table>
</div>
<div id="signup_field">
    <form action="process_editProfile.jsp" method="post">
        <table>
            <tr>
                <td width="50%">
                    <h5>First Name</h5>
                </td>
                <td width="50%">
                    <input type="text" name="firstName" value="<%=firstName%>"/>
                </td>
            </tr>
            <tr>
                <td>
                    <h5>Last Name</h5>
                </td>
                <td>
                    <input type="text" name="lastName" value="<%=lastName%>"/>
                </td>
            </tr>
            <tr>
                <td>
                    <h5>Username</h5>
                </td>
                <td>
                    <input type="text" name="userName" value="<%=userName%>"/>
                </td>
            </tr>
            <tr>
                <td>
                    <h5>Password</h5>
                </td>
                <td>
                    <input type="password" name="password" value="<%=password%>"/>
                </td>
            </tr>
            <tr>
                <td>
                    <h5>Confirm Password</h5>
                </td>
                <td>
                    <input type="password" name="confirmPassword" value="<%=password%>"/>
                </td>
            </tr>
            <tr>
                <td>
                    <h5>Birthday</h5>
                </td>
                <td>
                    <input type="text" name="birthday" value="<%=birthday%>"/>
                </td>
            </tr>
            <tr>
                <td>
                    <h5>Gender</h5>
                </td>
                <%
                    switch (gender){
                        case 0:
                            %>
                <td>
                    <select name="gender">
                        <option value="male">Male</option>
                        <option value="female">Female</option>
                    </select>
                </td><%break;
                case 1:%>
                <td>
                    <select name="gender">
                        <option value="female">Female</option>
                        <option value="male">Male</option>
                    </select>
                </td><%break;
                    }
                %>

            </tr>
            <tr>
                <td>
                    <h5>Interested In</h5>
                </td>
                <%
                    switch (interested){
                        case 0:%>
                <td>
                <select name="interested">
                    <option value="male">Male</option>
                    <option value="female">Female</option>
                    <option value="both">Both</option>
                </select>
                </td><%break;
                case 1:%>
                <td>
                    <select name="interested">
                        <option value="female">Female</option>
                        <option value="male">Male</option>
                        <option value="both">Both</option>
                    </select>
                </td><%break;
                case 2:%>
                    <td>
                    <select name="interested">
                        <option value="both">Both</option>
                        <option value="male">Male</option>
                        <option value="female">Female</option>
                    </select>
                </td><%break;
                    }
                %>

            </tr>
            <tr>
                <td></td>
                <td>
                    <input type="submit"/>
                </td>
            </tr>
        </table>
    </form>

</div>
</body>
</html>