<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.HashSet" %>
<%@ page import="java.util.Set" %>
<%@ page import="java.util.Collections" %>
<%@ page import="com.sun.org.apache.xpath.internal.operations.Bool" %>
<%--
  Created by IntelliJ IDEA.
  User: roufanliau
  Date: 2019-05-30
  Time: 23:06
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>


<%
    String userName = request.getParameter("userName");
    if(session.getAttribute("userId")==null){
        RequestDispatcher req = request.getRequestDispatcher("index.jsp");
        req.forward(request, response);
    }
    String own = session.getAttribute("userId").toString();
    Boolean ownProfile = false;

    Class.forName("com.mysql.jdbc.Driver");
    Statement stm = DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/users?useSSL=false",
            "root",
            "rootroot").createStatement();
    if(session.getAttribute("userId")==null){
        RequestDispatcher req = request.getRequestDispatcher("index.jsp");
        req.forward(request, response);
    }

    String sql_getOwnPosts = "select * from posts where userName = \""+userName+"\" ;";
    String sql_getInterestedSex = "select * from user_data where userName = \""+userName+"\" ;";
    ResultSet rs = stm.executeQuery(sql_getOwnPosts);


    int count =0;
    while(rs.next()){
        count++;
    }

    ResultSet rs_interestedSex = stm.executeQuery(sql_getInterestedSex);

    if(!rs_interestedSex.next()){
        RequestDispatcher req = request.getRequestDispatcher("main.jsp");
        req.forward(request, response);
    }
    int interested = Integer.parseInt(rs_interestedSex.getString("interested"));
    String profile_picture = rs_interestedSex.getString("profile_picture");
    String fullname = rs_interestedSex.getString("firstName") + " " + rs_interestedSex.getString("lastName");
    int gender_index = Integer.parseInt(rs_interestedSex.getString("gender"));
    String birthday = rs_interestedSex.getString("birthday");
    userName = rs_interestedSex.getString("userName");
    if(own.equals(userName)){
        ownProfile = true;
    }
    String interested_gender;
    String gender;
    String gender_label;
    String gender_label_2;
    if(interested==0){
        interested_gender = "Male";
    }else if(interested==1){
        interested_gender = "Female";
    }else{
        interested_gender = "Male, Female";
    }
    if(gender_index==0){
        gender = "Male";
        gender_label = "HIM";
        gender_label_2 = "HE";
    }else{
        gender = "Female";
        gender_label = "HER";
        gender_label_2 = "SHE";
    }
    String sql_own = "select * from user_data where userName = \""+own+"\" ;";
    ResultSet rs_own = stm.executeQuery(sql_own);
    rs_own.next();
    String profile_picture_own = rs_own.getString("profile_picture");
    String fullname_own = rs_own.getString("firstName")+" "+rs_own.getString("lastName");
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
                        <a href="profile.jsp?userName=<%=session.getAttribute("userId")%>"><div id="upright_crop_image"><img id="profile_picture_upright" src="<%=profile_picture_own%>"/></div></a>
                    </td>

                    <td>
                        <a href="profile.jsp?userName=<%=session.getAttribute("userId")%>"><p id="fullname_upright"><%=fullname_own%></p></a>
                        <a href="profile.jsp?userName=<%=session.getAttribute("userId")%>"><p id="username_upright"><%="@"+own%></p></a>
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
                <a href="profile.jsp?userName=<%=own%>"><button class="menu_button">My Profile</button></a><br>
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
            <div id="profile_container">
                <table style="width: 100%;margin-top: -1vh;" cellpadding="0" cellspacing="0">
                    <tr>
                        <td style="width: 66%">
                            <table style="width: 100%">
                                <tr>
                                    <td>
                                        <div id="profile_icon"><img id="profilePage_profilePic" src="<%=profile_picture%>" />></div>
                                    </td>
                                    <td width="80%">
                                        <p id="profile_page_fullname"><%=fullname%></p>
                                        <%
                                            if(ownProfile){
                                        %>
                                        <a href="editProfile.jsp"><button id="profile_page_editprofile">EDIT PROFILE</button></a>
                                        <%
                                            }else{
                                                %>
                                        <a href="message.jsp?name=<%=userName%>"><button id="profile_page_editprofile">MESSAGE</button></a>
                                        <%
                                            }
                                        %>
                                        <p id="profile_page_username"><%="@"+userName%></p>
                                        <p class="profile_page_details">Gender: <span style="color: #E98D8E"><%=gender%></span></p>
                                        <p class="profile_page_details">Interested In: <span style="color: #E98D8E"><%=interested_gender%></span></p>
                                        <p class="profile_page_details" style="margin-bottom: 2vh;">Birthday: <span style="color: #E98D8E"><%=birthday%></span></p>
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td>
                            <table style="border-left: #EBEBEB solid 2px;width: 100%; height: 100% " cellpadding="0" cellspacing="0">
                                <tr>
                                    <td>
                                        <p class="profile_page_count"><%=count%></p>
                                        <p class="profile_page_count_label">TOTAL POSTS</p>
                                    </td>
                                </tr>
                                <tr ">
                                    <td>
                                        <%
                                            String sql_count_interested="select * from hearts where sender = \""+userName+"\";";
                                            ResultSet rs_count_interested = stm.executeQuery(sql_count_interested);
                                            ArrayList count_interested = new ArrayList();
                                            while(rs_count_interested.next()){
                                                if(!count_interested.contains(rs_count_interested.getString("receiver"))) {
                                                    count_interested.add(rs_count_interested.getString("receiver"));
                                                }
                                            }



                                            String sql_leaderboard_count = "select * from hearts where receiver =\""+userName+"\";";
                                            ResultSet rs_leaderboard_count = stm.executeQuery(sql_leaderboard_count);
                                            ArrayList list_count = new ArrayList();
                                            while(rs_leaderboard_count.next()){
                                                list_count.add(rs_leaderboard_count.getString("sender"));
                                            }
                                        %>
                                        <table style="border-top: #EBEBEB solid 2px;width:100%" cellpadding="0" cellspacing="0">
                                            <tr>
                                                <td style="border-right: #EBEBEB solid 2px;">
                                                    <p class="profile_page_count"><%=list_count.size()%></p>
                                                    <p class="profile_page_count_label">HEARTS<br> RECEIVED</p>
                                                </td>
                                                <td>
                                                    <p class="profile_page_count"><%=count_interested.size()%></p>
                                                    <p class="profile_page_count_label"><%=gender_label_2%> HAS<br>INTEREST IN</p>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <%
                                if(ownProfile){
                            %>
                            <div id="profile_page_left_label">My Posts</div>
                            <%
                                }else{
                            %>
                            <div id="profile_page_left_label"><%=userName+"'s"%> Posts</div>
                            <%
                                }
                            %>
                        </td>
                        <td>
                            <div id="profile_page_right_label">INTERESTED IN <%=gender_label%></div>
                        </td>
                    </tr>

                    <tr>
                        <td>
                            <%
                                String[][] own_post = new String[count][2];
                                ResultSet rs_get = stm.executeQuery(sql_getOwnPosts);
                                for(int i=0;i<count;i++){
                                    rs_get.next();
                                    own_post[count-i-1][0]=rs_get.getString("content");
                                    own_post[count-i-1][1]=rs_get.getString("post_date");
                                }
                            %>
                            <%
                                if(ownProfile){
                            %>
                            <div id="profile_page_own_posts">
                                <table style="">
                                    <%
                                        for(int i=0;i<count;i++){
                                    %>
                                    <tr>
                                        <td width="100%">
                                            <div id="own_post_date"><%=own_post[i][1].substring(0,16)+"      "%><a href="DeletePostServlet?date=<%=own_post[i][1].substring(0,19)%>&src=profile" style="text-decoration: none; color: #C75C5C; font-weight: bold;"><img id="rubbish" src="rubbish.png"/></a></div>
                                            <div id="own_post_content"><%=own_post[i][0]%></div>

                                        </td>
                                    </tr>
                                    <%
                                        }%>

                                </table>
                            </div>
                            <%
                                }else{
                            %>
                            <div id="profile_page_own_posts">
                                <table style="">
                                    <%
                                        String sql_heart = "select * from hearts where sender = '"+session.getAttribute("userId")+"' and receiver = '"+userName+"';";
                                        ArrayList hearts = new ArrayList();
                                        ResultSet rs_hearts = stm.executeQuery(sql_heart);
                                        while (rs_hearts.next()){
                                            hearts.add(rs_hearts.getString("post"));
                                        }
                                        for(int i=0;i<count;i++){
                                    %>
                                    <tr>
                                        <td width="100%">
                                            <%
                                                if(hearts.contains(own_post[i][1].substring(0,19))){
                                                    %>
                                            <div id="own_post_date"><%=own_post[i][1].substring(0,16)+"      "%><img class="all_post_heart" src="filled_heart.png"/></div>


                                            <%
                                                }else{
                                            %>
                                            <div id="own_post_date"><%=own_post[i][1].substring(0,16)+"      "%><a href="GiveHeartServlet?username=<%=userName%>&post=<%=own_post[i][1].substring(0,19)%>&from=profile"><img class="all_post_heart" src="heart.png"/></a></div>
                                            <%
                                                }
                                            %>
                                            <div id="own_post_content"><%=own_post[i][0]%></div>

                                        </td>
                                    </tr>
                                    <%
                                        }%>

                                </table>
                            </div>
                            <%
                                }
                            %>
                        </td>
                        <td>
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
                            <div id="profile_page_leaderboard_content"></div>
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
                            <div id="profile_page_leaderboard_content">
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
                        </td>
                    </tr>
                </table>
            </div>
        </td>
        <td style="background-color: #FCFBFA;">

        </td>
    </tr>
</table>

</body>
</html>