import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.DriverManager;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.Date;

@WebServlet(name = "MessageServlet")
public class MessageServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        if(session.getAttribute("userId")==null){
            response.sendRedirect("index.jsp");
        }

        String sender = session.getAttribute("userId").toString();
        String receiver = request.getParameter("receiver");
        String message = request.getParameter("type_message");
        SimpleDateFormat formatter= new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        Date message_time = new Date(System.currentTimeMillis());
        String time = formatter.format(message_time);
        try{
            Class.forName("com.mysql.jdbc.Driver");
            Statement stm = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/users?useSSL=false",
                    "root",
                    "rootroot").createStatement();
            String sql = "insert into message (sender,receiver,message,time) value('"+sender+"','"+receiver+"','"+message+"','"+time+"');";
            stm.executeUpdate(sql);
        }catch (Exception e){
            System.out.println("sql problem");
        }
        response.sendRedirect("message.jsp?name="+receiver);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
