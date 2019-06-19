import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

@WebServlet(name = "SignInServlet")
public class SignInServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try{
        Class.forName("com.mysql.jdbc.Driver");
        Statement stm = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/users?useSSL=false",
                "root",
                "rootroot").createStatement();




        String userName = request.getParameter("userName");
        String password = request.getParameter("password");

        userName.replace("\'","");
        userName.replace("\"","");
        password.replace("\'","");
        password.replace("\"","");
        Boolean verify = false;

        String sql_getusername = "select * from user_data where username =\""+userName+"\";";

        ResultSet username = stm.executeQuery(sql_getusername);
        if(username.next()){
            if(username.getString("password").equals(password)){
                verify = true;
            }
        }



        if(!verify){
            response.sendRedirect("index.jsp");
        }
        else
        {
            HttpSession session = request.getSession();
            session.setAttribute("userId", userName);
            response.sendRedirect("main.jsp");
        }}
        catch(Exception e){

        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
