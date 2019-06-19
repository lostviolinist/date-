<%@ page import="java.sql.Date" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="javax.management.relation.RelationSupport" %><%--
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
    String firstName = request.getParameter("firstName");
    String lastName = request.getParameter("lastName");
    String userName_form = request.getParameter("userName");
    String password = request.getParameter("password");
    String confirm_password = request.getParameter("confirmPassword");
    String birthday = request.getParameter("birthday");
    String gender = request.getParameter("gender");
    String interested = request.getParameter("interested");
    Boolean userNameTaken = false;

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


    if(firstName.isEmpty() || lastName.isEmpty() || userName.isEmpty() ||
            password.isEmpty() || confirm_password.isEmpty() || birthday.isEmpty())
    {%>
<script type="text/javascript">
    alert("Please fill all the fields!")
</script><%
        RequestDispatcher req = request.getRequestDispatcher("editProfile.jsp");
        req.include(request, response);
    }
    else if(!password.equals(confirm_password)){
%>
<script type="text/javascript">
    alert("Password and Confirm Password not the same!")
</script><%
        RequestDispatcher req = request.getRequestDispatcher("editProfile.jsp");
        req.include(request, response);
    }

    else if(!userName_form.equals(userName)) {
        String sql_getusername = "select * from user_data;";

        ResultSet username = stm.executeQuery(sql_getusername);
        while (username.next()) {
            if (username.getString("userName").equals(userName_form)) {
                userNameTaken = true;
            }
        }
        if(userNameTaken){
%>
<script type="text/javascript">
    alert("The username is taken!")
</script><%
            RequestDispatcher req = request.getRequestDispatcher("editProfile.jsp");
            req.include(request, response);
        }else{
            String sql_updateUserName_userData = "update user_data set userName = \""+userName_form+"\" where userName =\""+userName+"\";";
            String sql_updateUserName_posts = "update posts set userName = \""+userName_form+"\" where userName =\""+userName+"\";";
            stm.executeUpdate(sql_updateUserName_userData);
            stm.executeUpdate(sql_updateUserName_posts);
            userName = userName_form;
            session.setAttribute("userId", userName);


                String sql_getUser = "select * from user_data where userName =\""+userName+"\";";
                ResultSet rs = stm.executeQuery(sql_getUser);
                rs.next();
                String ori_firstName = rs.getString("firstName");
                String ori_lastName = rs.getString("lastName");
                String ori_password = rs.getString("password");
                String ori_birthday = rs.getString("birthday");
                if(!firstName.equals(ori_firstName)){
                    String sql_updateFirstName = "update user_data set firstName = \""+firstName+"\" where userName =\""+userName+"\";";
                    stm.executeUpdate(sql_updateFirstName);
                }
                if(!lastName.equals(ori_lastName)){
                    String sql_updateLastName = "update user_data set lastName = \""+lastName+"\" where userName =\""+userName+"\";";
                    stm.executeUpdate(sql_updateLastName);
                }
                if(!password.equals(ori_password)){
                    String sql_updatePassword = "update user_data set password = \""+password+"\" where userName =\""+userName+"\";";
                    stm.executeUpdate(sql_updatePassword);
                }
                if(!birthday.equals(ori_birthday)){
                    String sql_updateBirthday = "update user_data set birthday = \""+birthday+"\" where userName =\""+userName+"\";";
                    stm.executeUpdate(sql_updateBirthday);
                }
                String sql_updateGender = "update user_data set gender = \""+Gender+"\" where userName =\""+userName+"\";";
                stm.executeUpdate(sql_updateGender);
                String sql_updateInterested = "update user_data set interested = \""+Interested+"\" where userName =\""+userName+"\";";
                stm.executeUpdate(sql_updateInterested);








                RequestDispatcher req = request.getRequestDispatcher("main.jsp");
                req.forward(request, response);
            }
    }else{

    String sql_getUser = "select * from user_data where userName =\""+userName+"\";";
    ResultSet rs = stm.executeQuery(sql_getUser);
    rs.next();
    String ori_firstName = rs.getString("firstName");
    String ori_lastName = rs.getString("lastName");
    String ori_password = rs.getString("password");
    String ori_birthday = rs.getString("birthday");
    if(!firstName.equals(ori_firstName)){
        String sql_updateFirstName = "update user_data set firstName = \""+firstName+"\" where userName =\""+userName+"\";";
        stm.executeUpdate(sql_updateFirstName);
    }
    if(!lastName.equals(ori_lastName)){
        String sql_updateLastName = "update user_data set lastName = \""+lastName+"\" where userName =\""+userName+"\";";
        stm.executeUpdate(sql_updateLastName);
    }
    if(!password.equals(ori_password)){
        String sql_updatePassword = "update user_data set password = \""+password+"\" where userName =\""+userName+"\";";
        stm.executeUpdate(sql_updatePassword);
    }
    if(!birthday.equals(ori_birthday)){
        String sql_updateBirthday = "update user_data set birthday = \""+birthday+"\" where userName =\""+userName+"\";";
        stm.executeUpdate(sql_updateBirthday);
    }
    String sql_updateGender = "update user_data set gender = \""+Gender+"\" where userName =\""+userName+"\";";
    stm.executeUpdate(sql_updateGender);
    String sql_updateInterested = "update user_data set interested = \""+Interested+"\" where userName =\""+userName+"\";";
    stm.executeUpdate(sql_updateInterested);








        RequestDispatcher req = request.getRequestDispatcher("main.jsp");
        req.forward(request, response);
    }
%>

