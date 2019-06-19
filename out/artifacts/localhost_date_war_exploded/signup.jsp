<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %><%--
  Created by IntelliJ IDEA.
  User: roufanliau
  Date: 2019-05-30
  Time: 23:06
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>

<%
    SimpleDateFormat formatter= new SimpleDateFormat("yyyy-MM-dd");
    Date current_date = new Date(System.currentTimeMillis());
    String date = formatter.format(current_date);
    int year = Integer.parseInt(date.substring(0,4));
    year-=16;
    date = Integer.toString(year) + date.substring(4,10);
%>

<html>
<head>
    <title>Date!</title>
    <link rel="stylesheet" href="style.css">
</head>
<body style="background-color: #FCF4E9">
    <p id="createAccountTitle">Create a new account.</p>

    <form action="process_signup.jsp" id="signUp_form" method="post">
    <table style="width:36vw; margin:0 auto;" cellspacing="0" cellpadding="0">

        <tr>
            <td>
                <p class="label">Full Name</p>
            </td>
        </tr>
        <tr>
            <td>
                <table>
                    <tr>
                        <td>
                            <input type="text" class="signup_field2" name="firstName" placeholder="firstname" required/>
                        </td>
                        <td>
                            <input type="text" class="signup_field2" name="lastName" placeholder="lastname" required/>
                        </td>
                    </tr>
                </table>



            </td>
        </tr>
        <tr>
            <td>
                <p class="label">Username</p>
            </td>
        </tr>
        <tr>
            <td>
                <input type="text" class="signup_field1" name="userName" placeholder="username" required/>
            </td>
        </tr>
        <tr>
            <td>
                <p class="label">Date of birth</p>
            </td>
        </tr>
        <tr>
            <td>
                <table>
                    <tr>
                        <td>
                            <input type="text" class="signup_field3" name="DD_dob" placeholder="DD" required/>
                        </td>
                        <td>
                            <input type="text" class="signup_field3" name="MM_dob" placeholder="MM" required/>
                        </td>
                        <td>
                            <input type="text" class="signup_field3" name="YYYY_dob" placeholder="YYYY" required/>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td>
                <div style="width:50%; float:left">
                    <p class="label">Gender</p>
                </div>
                <div style="width:50%; float:right">
                    <p class="label">Interested in</p>
                </div>

            </td>
        </tr>
        <tr>
            <td>
                <div style="width:50%; float:left">
                    <select class="gender_selector" name="gender">
                        <option value="male">Male</option>
                        <option value="female">Female</option>
                    </select>
                </div>
                <div style="width:50%; float:right">
                    <select class="gender_selector" name="interested">
                        <option value="male">Male</option>
                        <option value="female">Female</option>
                        <option value="both">Both</option>
                    </select>
                </div>
            </td>
        </tr>
        <tr>
            <td>
                <p class="label">Password</p>
            </td>
        </tr>
        <tr>
            <td>
                <input type="password" class="signup_field1" name="password" placeholder="password" required/>
            </td>
        </tr>
        <tr>
            <td>
                <p class="label">Confirm Password</p>
            </td>
        </tr>
        <tr>
            <td>
                <input type="password" class="signup_field1" name="confirmPassword" placeholder="confirm password" required/>
            </td>
        </tr>


        <tr>
            <td>
                <button class="submit_button_signup" onclick="check()">SIGN UP</button>

    </table>
            </td>
        </tr>



    </form>
        <p id="prompt_signin">Already have an account? <a href="index.jsp">Sign in</a></p>



</body>
</html>