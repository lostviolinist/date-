import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.DriverManager;
import java.sql.Statement;

@WebServlet(name = "GiveHeartServlet")
public class GiveHeartServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        if(session.getAttribute("userId")==null){
            response.sendRedirect("index.jsp");
        }
        try {
            String receiver = request.getParameter("username");
            String post = request.getParameter("post");
            String sender = session.getAttribute("userId").toString();

            String sql = "insert into hearts (sender,receiver,post) value(\"" + sender + "\",\"" + receiver + "\",\"" + post +"\");";

            Class.forName("com.mysql.jdbc.Driver");
            Statement stm = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/users?useSSL=false",
                    "root",
                    "rootroot").createStatement();

            stm.executeUpdate(sql);
            if(request.getParameter("from")!=null){
                response.sendRedirect("profile.jsp?userName="+receiver);
            }else {
                response.sendRedirect("main.jsp");
            }
        }catch(Exception e){
            System.out.println("SQL error");
        }
    }
}
