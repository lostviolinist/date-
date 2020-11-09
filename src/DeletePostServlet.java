import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.DriverManager;
import java.sql.Statement;

@WebServlet(name = "DeletePostServlet")
public class DeletePostServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        if(session.getAttribute("userId")==null){
            response.sendRedirect("index.jsp");
        }
        try{
        Class.forName("com.mysql.jdbc.Driver");
        Statement stm = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/users?useSSL=false",
                "root",
                "rootroot").createStatement();

        String date = request.getParameter("date");
        String src = request.getParameter("src");


        System.out.println(date);
        String sql = "delete from posts where post_date = \""+date+"\";";
        stm.executeUpdate(sql);

        if(src.equals("main"))
            response.sendRedirect("main.jsp");
        if(src.equals("profile"))
            response.sendRedirect("profile.jsp?userName="+session.getAttribute("userId").toString());
        }catch(Exception e){

        }
    }
}
