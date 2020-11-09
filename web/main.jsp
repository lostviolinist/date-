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
    <tr style="height: 88.67vh;">
        <td style=" border: #EBEBEB 1px solid;">
            <div>
                <table width="100%">
                    <tr>
                        <td>
                            <table>
                                <tr>
                                    <td>
                                        <a href="profile.jsp?userName=<%=userName%>"><div id="profile_picture_crop_image"><img id="profile_picture" src="<%=profile_picture%>"/></div></a>
                                    </td>
                                    <td>
                                        <a href="profile.jsp?userName=<%=userName%>"><p id="fullname"><%=firstName%></p></a>
                                        <p class="details"><%=count+" posts"%></p>
                                        <%
                                            String sql_count_interested="select * from hearts where sender = \""+userName+"\";";
                                            ResultSet rs_count_interested = stm.executeQuery(sql_count_interested);
                                            ArrayList count_interested = new ArrayList();
                                            while(rs_count_interested.next()){
                                                if(!count_interested.contains(rs_count_interested.getString("receiver"))) {
                                                    count_interested.add(rs_count_interested.getString("receiver"));
                                                }
                                            }

                                        %>
                                        <p class="details"><%=count_interested.size()%> interested</p>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <div id="own_post_label">MY POSTS</div>
                        </td>
                    </tr>
                </table>
            </div>
            <%
                String[][] own_post = new String[count][2];
                ResultSet rs_get = stm.executeQuery(sql_getOwnPosts);
                for(int i=0;i<count;i++){
                    rs_get.next();
                    own_post[count-i-1][0]=rs_get.getString("content");
                    own_post[count-i-1][1]=rs_get.getString("post_date");
                }
            %>
            <div id="own_posts">
                <table>
                    <%
                        for(int i=0;i<count;i++){
                    %>
                    <tr>
                        <td width="100%">
                            <div id="own_post_date"><%=own_post[i][1].substring(0,16)+"      "%><a href="DeletePostServlet?date=<%=own_post[i][1].substring(0,19)%>&src=main" style="text-decoration: none; color: #C75C5C; font-weight: bold;"><img id="rubbish" src="rubbish.png"/></a></div>
                            <div id="own_post_content"><%=own_post[i][0]%></div>

                        </td>
                    </tr>
                    <%
                        }%>

                </table>
            </div>
        </td>
        <td style="background-color: #FCFBFA;  border: #EBEBEB 1px solid;">
            <table style="width: 92%; margin: 0 auto;">
                <tr>
                    <td>
                        <p class="write_post_label">Write Post</p>
                    </td>
                </tr>
                <form action="writePost.jsp" method="post">
                    <tr>
                        <td>
                            <input type="text" id="post_field" name="post" placeholder="Write your post here..." required/>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <button id="write_post_submit">Submit</button>
                        </td>
                    </tr>

                </form>
                <tr>
                    <td>
                    <%
                        String sql_getAllPosts = "select *\n" +
                                "from posts\n" +
                                "inner join user_data\n" +
                                "on posts.userName=user_data.userName\n" +
                                "where posts.userName!=\""+userName+"\" and gender = \""+interested+"\";";

                        if(interested==2){
                            sql_getAllPosts = "select *\n" +
                                    "from posts\n" +
                                    "inner join user_data\n" +
                                    "on posts.userName=user_data.userName\n" +
                                    "where posts.userName!=\""+userName+"\";";
                        }

                        ResultSet rs_allPosts = stm.executeQuery(sql_getAllPosts);
                        int count_all =0;
                        while(rs_allPosts.next()){
                            count_all++;
                        }

                        String[][] all_posts = new String[count_all][4];
                        ResultSet rs_getAllPosts = stm.executeQuery(sql_getAllPosts);
                        for(int i=0;i<count_all;i++){
                            rs_getAllPosts.next();
                            all_posts[count_all-i-1][0] = rs_getAllPosts.getString("username");
                            all_posts[count_all-i-1][1] = rs_getAllPosts.getString("content");
                            all_posts[count_all-i-1][2] = rs_getAllPosts.getString("post_date");
                            all_posts[count_all-i-1][3] = rs_getAllPosts.getString("profile_picture");
                        }

                        String sql_heart = "select * from hearts where sender = \""+userName+"\";";
                        ResultSet rs_heart = stm.executeQuery(sql_heart);
                        ArrayList hearts_sent = new ArrayList();
                        while(rs_heart.next()){
                            hearts_sent.add(rs_heart.getString("post"));
                        }

                    %>

                    <div id="all_post_container">
                        <table style="width: 100%">
                            <%
                                for(int j=0; j<count_all;j++){
                            %>

                            <tr>

                                <td>
                                    <a href="profile.jsp?userName=<%=all_posts[j][0]%>"><div class="posts_crop_image"><img class="profile_picture_posts" src="<%=all_posts[j][3]%>"/></div></a>
                                </td>
                                <td>
                                    <%
                                        if(!hearts_sent.contains(all_posts[j][2].substring(0,19))){
                                    %>
                                    <p class="all_post_username"><a style="color: #E98D8E;" href="profile.jsp?userName=<%=all_posts[j][0]%>"><%="@"+all_posts[j][0]%></a><a href="GiveHeartServlet?username=<%=all_posts[j][0]%>&post=<%=all_posts[j][2].substring(0,19)%>"><img class="all_post_heart" src="heart.png"/></a></p>
                                    <%
                                        }else{
                                    %>
                                    <p class="all_post_username"><a style="color: #E98D8E;" href="profile.jsp?userName=<%=all_posts[j][0]%>"><%="@"+all_posts[j][0]%></a><img class="all_post_heart" src="filled_heart.png"/></p>
                                    <%
                                        }
                                    %>
                                    <p id="all_post_content"><%=all_posts[j][1]%></>

                                </td>
                                <td>
                                    <p id="all_post_time"><%=all_posts[j][2].substring(0,16)%></p>
                                </td>

                            </tr>


                            <%
                                }%>
                        </table>
                    </div>
                </td>
                </tr>
            </table>

        </td>
        <td style=" border: #EBEBEB 1px solid;">

            <div id="leaderboard_label">TOP LEADERBOARD</div>
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
            <div id="leaderboard_content"></div>
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
            <div id="leaderboard_content">
                <table style="margin-top: 2vh;width: 90%">
                    <%
                        for(int i=0; i<display.length;i++){
                    %>
                    <tr>
                        <td>
                            <a href="profile.jsp?userName=<%=display[i][0]%>"><div class="posts_crop_image"><img class="profile_picture_posts" src="<%=display[i][2]%>"/></div></a>
                        </td>
                        <td>
                            <a href="profile.jsp?userName=<%=display[i][0]%>"><p id="leaderboard_username"><%="@"+display[i][0]%></p></a>
                            <p id="leaderboard_heart_count"><%=display[i][1]+" hearts"%></p>
                        </td>

                    </tr>
                    <%
                        }
                    %>
                </table>
            </div>
            <%
                 }
            %>

            <div id="leaderboard_bottom">
                <table width="100%">
                    <tr>
                        <td>
                            <img class="filled_heart" src="filled_heart.png"/>
                        </td>
                        <td>
                            <p id="num_of_hearts"><%=list.size()%> HEARTS <span style="color:#797979">RECEIVED</span></p>
                        </td>
                    </tr>
                </table>
            </div>

        </td>
    </tr>
</table>

</body>
</html>