import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.*;
import java.sql.DriverManager;
import java.sql.Statement;

@MultipartConfig
@WebServlet(name = "EditProfileServlet")
public class EditProfileServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Part image = request.getPart("image");
        InputStream is = image.getInputStream();
        byte[] data = new byte[10*1024*1024];
        int len = is.read(data);
        HttpSession session = request.getSession();
        String username = session.getAttribute("userId").toString();
        OutputStream os = new FileOutputStream(getServletContext().getRealPath("image")+"/"+username+".png");
        os.write(data, 0, len);
        os.close();

        try{
        Class.forName("com.mysql.jdbc.Driver");
        Statement stm = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/users?useSSL=false",
                "root",
                "rootroot").createStatement();
        stm.executeUpdate("update user_data set profile_picture = \"image/"+username+".png\" where userName = \""+username+"\";");
        }
        catch (Exception e){

        }

        response.sendRedirect("main.jsp");
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
