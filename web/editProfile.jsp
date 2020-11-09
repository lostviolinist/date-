<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="com.sun.org.apache.xpath.internal.operations.Bool" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.*" %>
<%--
  Created by IntelliJ IDEA.
  User: roufanliau
  Date: 2019-05-30
  Time: 23:06
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>


<%

    if(session.getAttribute("userId")==null){
        RequestDispatcher req = request.getRequestDispatcher("index.jsp");
        req.forward(request, response);
    }
    String userName = session.getAttribute("userId").toString();

    Class.forName("com.mysql.jdbc.Driver");
    Statement stm = DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/users?useSSL=false",
            "root",
            "rootroot").createStatement();
    String sql_getUser = "select * from user_data where userName = \""+userName+"\";";
    ResultSet rs_getUser = stm.executeQuery(sql_getUser);
    rs_getUser.next();
    String firstName = rs_getUser.getString("firstName");
    String lastName = rs_getUser.getString("lastName");
    String password = rs_getUser.getString("password");
    String birthday = rs_getUser.getString("birthday");
    int gender = Integer.parseInt(rs_getUser.getString("gender"));
    int interested = Integer.parseInt(rs_getUser.getString("interested"));
    String profile_picture = rs_getUser.getString("profile_picture");
    String fullname_own = firstName+" "+lastName;
    SimpleDateFormat formatter= new SimpleDateFormat("yyyy-MM-dd");
    Date current_date = new Date(System.currentTimeMillis());
    String date = formatter.format(current_date);
    int year = Integer.parseInt(date.substring(0,4));
    year-=16;
    date = Integer.toString(year) + date.substring(4,10);

%>
<!DOCTYPE html>

<html>
<head>
    <title>Date!</title>
    <link rel="stylesheet" href="main.css">
</head>
<body>
<table style="margin-top: 1.5vh; width: 100vw; height: 98.5vh; background-color: white;" cellpadding="0" cellspacing="0">
    <tr height="9.76vh">
        <td style="width: 18.3vw;  border: #EBEBEB 1px solid;">
            <a href="main.jsp"><table class="content_table">
                <tr>
                    <td>
                        <img id="nav_logo_main" src="logo.png" />
                    </td>
                    <td>
                        <p id="logo_word">date</p>
                    </td>
                </tr>
            </table>
            </a>
        </td>
        <td style="width: 60.06vw;  border: #EBEBEB 1px solid;">
            <table class="content_table">
                <tr>
                    <td>
                        <form action="SearchUserServlet" method="post">
                            <div id="search_bar">
                                <input type="text" name="search_field" id="search_field" placeholder="Search"/>
                                <button class="icon_button" id="search_button"><img class="icon" src="search.png"/></button>
                            </div>
                        </form>
                    </td>
                    <td>
                        <a href="message.jsp"><button class="icon_button"><img class="icon_r" src="message.png"/></button></a>
                    </td>
                </tr>
            </table>
        </td>
        <td style="width: 21.64vw;  border: #EBEBEB 1px solid;">
            <table class="content_table">
                <tr>
                    <td>
                        <a href="profile.jsp?userName=<%=session.getAttribute("userId")%>"><div id="upright_crop_image"><img id="profile_picture_upright" src="<%=profile_picture%>"/></div></a>
                    </td>

                    <td>
                        <a href="profile.jsp?userName=<%=session.getAttribute("userId")%>"><p id="fullname_upright"><%=fullname_own%></p></a>
                        <a href="profile.jsp?userName=<%=session.getAttribute("userId")%>"><p id="username_upright"><%="@"+userName%></p></a>
                    </td>
                    <td>
                        <button class="icon_button" onclick="open_close_menu()"><img class="icon" src="hander.png"/></button>

                        <script>
                            var x=0;
                            function open_close_menu() {
                                if (x==0) {
                                    document.getElementById("upright_menu").style.display = "block";
                                    x=1;
                                } else {
                                    document.getElementById("upright_menu").style.display = "none";
                                    x=0;
                                }

                            }
                        </script>
                    </td>
                </tr>
            </table>
            <div class="menu-popup" id="upright_menu">
                <a href="profile.jsp?userName=<%=userName%>"><button class="menu_button">My Profile</button></a><br>
                <a href="message.jsp"><button class="menu_button">Message</button></a>
                <form action="signout.jsp" method="post">
                    <button class="menu_button">Sign Out</button>
                </form>
            </div>
        </td>
    </tr>
    <tr style="height: 88.67vh;">
        <td style="background-color: #FCFBFA; ">

        </td>
        <td style="background-color: #FCFBFA;">
            <div id="editprofile_container">
                <div id="grad">
                    <table>
                        <tr>

                            <td width="80%">
                                <h4>Edit Profile</h4>
                            </td>
                            <td width="10%">
                                <a href="profile.jsp?userName=<%=userName%>"><h5 style="color: #E98D8E">Back</h5></a>
                            </td>
                        </tr>
                    </table>
                </div>
                <div id="signup_field">
                    <form action="process_editProfile.jsp" method="post">
                        <table style="border-bottom: #9D9D9D 1px solid;">
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
                                    <input type="hidden" name="userName" value="<%=userName%>"/>
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
                    <p style="margin-top: 10vh;">Add Image:</p>
                    <form action="./EditProfileServlet" method="post" name="change_picture" enctype="multipart/form-data">
                        <input type="file" name="image"/>

                        <input type="submit"/>

                    </form>

                </div>
            </div>
        </td>
        <td style="background-color: #FCFBFA;">

        </td>
    </tr>
</table>

</body>
</html>