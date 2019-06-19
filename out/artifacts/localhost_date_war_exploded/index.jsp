<%--
  Created by IntelliJ IDEA.
  User: roufanliau
  Date: 2019-05-30
  Time: 23:06
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>

<html>
<head>
  <title>Date!</title>
  <link rel="stylesheet" href="style.css">
</head>
<body>
<div id="index_background">
  <table id="index_table" cellpadding="0" cellspacing="0">
    <tr>
      <td id="index_left">
        <p id="line1">Find your soulmate<br>
          and connect with friends.</p>
        <p id="line2">All in one place.</p>

      </td>
      <td id="index_right">
        <p id="title">date</p>
        <form action="SignInServlet" method="post">
          <p class="label_signin">username</p>
          <input type="text" class="signin_field" name="userName" placeholder="username" required/>
          <p class="label_signin">password</p>
          <input type="password" class="signin_field" name="password" placeholder="password" required/><br>
          <button class="submit_button" type="submit">SIGN IN</button>
        </form>

        <p id="prompt_signup">Don’t have an account yet? <a href="signup.jsp">Sign up</a></p>

      </td>
    </tr>
  </table>
</div>


</body>
</html>