<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.HashSet" %>
<%@ page import="java.util.Set" %>
<%@ page import="java.util.Collections" %>
<%--
  Created by IntelliJ IDEA.
  User: roufanliau
  Date: 2019-05-30
  Time: 23:06
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>


<%
    Class.forName("com.mysql.jdbc.Driver");
    Statement stm = DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/users?useSSL=false",
            "root",
            "rootroot").createStatement();
    if(session.getAttribute("userId")==null){
        RequestDispatcher req = request.getRequestDispatcher("index.jsp");
        req.forward(request, response);
    }
    String userName = session.getAttribute("userId").toString();
    String sql_getOwnPosts = "select * from posts where userName = \""+userName+"\" ;";
    String sql_getInterestedSex = "select * from user_data where userName = \""+userName+"\" ;";
    ResultSet rs = stm.executeQuery(sql_getOwnPosts);


    int count =0;
    while(rs.next()){
        count++;
    }

    ResultSet rs_interestedSex = stm.executeQuery(sql_getInterestedSex);
    rs_interestedSex.next();
    int  interested = Integer.parseInt(rs_interestedSex.getString("interested"));
    String profile_picture = rs_interestedSex.getString("profile_picture");
    String fullname = rs_interestedSex.getString("firstName")+" "+rs_interestedSex.getString("lastName");
    String firstName = rs_interestedSex.getString("firstName");
%>
<!DOCTYPE html>

<html>
<head>
    <title>Date!</title>
    <link rel="stylesheet" href="main.css">
</head>
<body>
<table style="margin-top: 1.5vh; width: 100vw; height: 9.76vh; background-color: white;" cellpadding="0" cellspacing="0">
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
                        <a href="profile.jsp?userName=<%=userName%>"><div id="upright_crop_image"><img id="profile_picture_upright" src="<%=profile_picture%>"/></div></a>
                    </td>

                    <td>
                        <a href="profile.jsp?userName=<%=userName%>"><p id="fullname_upright"><%=fullname%></p></a>
                        <a href="profile.jsp?userName=<%=userName%>"><p id="username_upright"><%="@"+userName%></p></a>
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
</table>
<table style="height: 88.74vh; width: 100%; background-color: #FCFBFA;">
    <tr>
        <td width="70%;">
            <p class="write_post_label" style="margin-left: 5vw;">TOP LEADERBOARD</p>

                <%
                    String sql_leaderboard = "select * from hearts where receiver =\""+userName+"\";";
                    ResultSet rs_leaderboard = stm.executeQuery(sql_leaderboard);
                    ArrayList list = new ArrayList();
                    ArrayList unique = new ArrayList();
                    while(rs_leaderboard.next()){
                        list.add(rs_leaderboard.getString("sender"));
                    }
                    if(list.size()==0){
                %>
                <div id="message_leaderboard_content"></div>
                <%
                }else{
                    for(int i=0;i<list.size();i++){
                        if(!unique.contains(list.get(i).toString())){
                            unique.add(list.get(i).toString());
                        }
                    }

                    String[][] display = new String[unique.size()][3] ;
                    count = 0;
                    while(unique.size()>0) {
                        int index = -1;
                        int top_heart = 0;

                        for (int i = 0; i < unique.size(); i++) {


                            if (Collections.frequency(list, unique.get(i)) > top_heart) {
                                top_heart = Collections.frequency(list, unique.get(i));
                                index = i;
                            }
                        }
                        display[count][0]=unique.get(index).toString();
                        display[count][1]=String.valueOf(top_heart);
                        count++;
                        unique.remove(index);
                    }

                    for(int i=0;i<display.length;i++){
                        String sql_leaderboard_profile = "select * from user_data where userName = \""+display[i][0]+"\";";
                        ResultSet rs_leaderboard_profile = stm.executeQuery(sql_leaderboard_profile);
                        rs_leaderboard_profile.next();
                        display[i][2] = rs_leaderboard_profile.getString("profile_picture");
                    }
                %>
                <div id="message_leaderboard_content">
                    <table style="margin: 1vh;">
                        <tr>
                        <%
                            for(int i=0; i<display.length;i++){
                        %>

                            <td>
                                <a href="profile.jsp?userName=<%=display[i][0]%>">
                                    <a href="message.jsp?name=<%=display[i][0]%>"><div class="message_crop_image" style="margin-left: 1vw;"><img class="profile_picture_posts" src="<%=display[i][2]%>"/></a>
                                    <span class="tooltiptext"><%=display[i][0]%></span></div>
                                </a>
                            </td>
                        <%
                            }
                        %>
                        </tr>
                    </table>
                </div>
                <%
                    }
                %>
            <p class="write_post_label" style="margin-left: 5vw; margin-top: 5vh">CHAT HISTORY</p>
            <%
                String sql_getAllMessage = "select * from message where sender = '" + userName + "' or receiver = '" + userName + "';";
                ResultSet rs_getAllMessage = stm.executeQuery(sql_getAllMessage);
                ArrayList getAllMessage = new ArrayList();
                ArrayList allNames = new ArrayList();
                while(rs_getAllMessage.next()){
                    getAllMessage.add(rs_getAllMessage.getString("id"));
                    getAllMessage.add(rs_getAllMessage.getString("sender"));
                    getAllMessage.add(rs_getAllMessage.getString("receiver"));
                    getAllMessage.add(rs_getAllMessage.getString("message"));
                    getAllMessage.add(rs_getAllMessage.getString("time"));
                    getAllMessage.add(rs_getAllMessage.getString("read"));
                }
                if(getAllMessage.size()>0){
                    for(int i=getAllMessage.size()-1;i>=0;i-=6){
                        if(getAllMessage.get(i-4).toString().equals(userName)){
                            if(!allNames.contains(getAllMessage.get(i-3))){
                                allNames.add(getAllMessage.get(i-3).toString());
                                allNames.add(getAllMessage.get(i-2).toString());
                                allNames.add(getAllMessage.get(i-1));
                                allNames.add("1");
                            }
                        }else{
                            if(!allNames.contains(getAllMessage.get(i-4))){
                                allNames.add(getAllMessage.get(i-4).toString());
                                allNames.add(getAllMessage.get(i-2).toString());
                                allNames.add(getAllMessage.get(i-1).toString());
                                allNames.add(getAllMessage.get(i));
                            }
                        }
                    }
                    String[][] display = new String[allNames.size()/4][5];
                    int index=0;
                    for(int i=0;i<allNames.size();i+=4){
                        String sql_getProfilePicture = "select profile_picture from user_data where userName = '"+allNames.get(i).toString()+"';";
                        ResultSet rs_getProfilePicture = stm.executeQuery(sql_getProfilePicture);
                        rs_getProfilePicture.next();
                        display[index][0] = allNames.get(i).toString();
                        display[index][1] = rs_getProfilePicture.getString("profile_picture");
                        display[index][2] = allNames.get(i+1).toString();
                        display[index][3] = allNames.get(i+2).toString();
                        display[index][4] = allNames.get(i+3).toString();
                        index++;
                    }
                    %>
            <div id="message_history">
                <table style="width: 100%">
                        <%
                    for(int i=0;i<display.length;i++){
                        String color="#FFF";
                        if(Integer.parseInt(display[i][4])==0){
                            color="#EEE";
                        }
                        %>
                    <tr>
                        <td>
                    <table style="width: 100%; background: <%=color%>; border-radius: 15px;">
                    <tr style="border-bottom: #E2E2E2 1px solid;">
                        <td>
                            <a href="message.jsp?name=<%=display[i][0]%>"><div class="posts_crop_image" style="margin-right: 1vw;"><img class="profile_picture_posts" src="<%=display[i][1]%>"/></div></a>
                        </td>
                        <td width="60%">
                            <a href="message.jsp?name=<%=display[i][0]%>"><p class="all_post_username"><%="@"+display[i][0]%></p></a>
                            <p id="all_post_content"><%=display[i][2]%></p>
                        </td>
                        <td>
                            <p id="all_post_time"><%=display[i][3]%></p>
                        </td>
                    </tr>
                    </table>
                        </td>
                    </tr>
                        <%


                        }
                    %>
                </table>
            </div>

            <%
                }else{

            %>
            <div id="message_history"></div><%
            }
            %>




        </td>
        <%
            if(request.getParameter("name")==null) {
                %>
        <td style="background-color: white;border-left: #EBEBEB 1px solid">

        </td>

        <%
            }else{
                String name = request.getParameter("name");
                String sql_countMessage = "select count(*) from message where (sender ='"+userName+"' and receiver ='"+name+"') or (sender ='"+name+"' and receiver = '"+userName+"');";
                String sql_getMessage = "select * from message where (sender ='"+userName+"' and receiver ='"+name+"') or (sender ='"+name+"' and receiver = '"+userName+"');";
                ResultSet rs_countMessage = stm.executeQuery(sql_countMessage);
                rs_countMessage.next();
                String[][] messages = new String[Integer.parseInt(rs_countMessage.getString("count(*)"))][3];
                ResultSet rs_getMessage = stm.executeQuery(sql_getMessage);
                for(int i=0;i<messages.length;i++){
                    rs_getMessage.next();
                    messages[i][0]=rs_getMessage.getString("receiver");
                    messages[i][1]=rs_getMessage.getString("message");
                    messages[i][2]=rs_getMessage.getString("read");

                }
                if(messages.length>0) {
                    if (messages[messages.length-1][0].equals(userName)) {
                        try {
                            String sql_read = "update message set message.read = 1 where id=" + Integer.parseInt(rs_getMessage.getString("id")) + ";";
                            stm.executeUpdate(sql_read);
                        } catch (Exception e) {
                        }
                    }
                }


        %>
        <td style="background-color: white;border-left: #EBEBEB 1px solid">
            <div id="message_name">
                <table style="width: 90%; margin: 1vh auto;">
                    <%
                        String sql_messaging = "select * from user_data where userName='"+name+"';";
                        ResultSet rs_messaging = stm.executeQuery(sql_messaging);
                        rs_messaging.next();
                    %>
                    <tr>
                        <td>
                            <div id="upright_crop_image"><img id="profile_picture_upright" src="<%=rs_messaging.getString("profile_picture")%>"/></div>
                        </td>
                        <td width="80%">
                            <p id="fullname_upright"><%=rs_messaging.getString("firstName")+" "+rs_messaging.getString("lastName")%></p>
                            <p id="username_upright"><%="@"+name%></p>
                        </td>
                        <td>
                            <a href="profile.jsp?userName=<%=name%>" style="color: #E98D8E;">view profile</a>
                        </td>
                    </tr>
                </table>
            </div>
            <div style="margin-top: 0;height: 80%;overflow-y: auto; overflow-x: hidden"><table style="width: 95%;margin: 0 auto;">

        <%
            for(int i=0;i<messages.length;i++){
                if(!messages[i][0].equals(userName)){
            %>
                <tr>
                    <td>
                        <div class="message" style="float:right; background-color: #FAC7BE; color: #FFFFFF"><%=messages[i][1]%></div>
                    </td>
                </tr>

            <%
                }else{
            %>
                <tr>
                    <td>
                        <div class="message" style="float:left; background-color: #EBEBEB; color: #312E2E;"><%=messages[i][1]%></div>
                    </td>
                </tr>

            <%
                }
            }
            if(messages.length>0){
            if((!messages[messages.length-1][2].equals("0"))&&(!messages[messages.length-1][0].equals(userName))){
                %>
                <tr>
                    <td>
                        <div class="message" style="float:right; background-color: white; "><img style="width: 2vw;" src="read_tick.png"/> </div>
                    </td>
                </tr>
                <%
            }
                    }
        %>
            </table></div>
            <div id="message_type">
                <form action="MessageServlet" method="post">
                    <div id="message_field">
                        <input type="text" id="type_message" name="type_message" placeholder="Write your message here..."/>
                        <input type="hidden" id="receiver" name="receiver" value="<%=name%>">
                        <button type="submit" id="send_button"><img style="width: 2vw;" src="send_message.png"/></button>
                    </div>
                </form>
            </div>
        </td>
        <%


            }
        %>

    </tr>
</table>

</body>
</html>