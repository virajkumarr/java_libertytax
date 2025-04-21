

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

/**
 * Servlet implementation class LoginServlet
 */
@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LoginServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
//		doGet(request, response);
		response.setContentType("application/json");
		PrintWriter out = response.getWriter();

        String emailOrPhone = request.getParameter("emailOrPhone");
        String password = request.getParameter("password");
        
        System.out.println("User entered: " + emailOrPhone + " | Password: " + password);

        String jdbcURL = "jdbc:mysql://localhost:3306/liberty_tax"; // Your database
        String dbUser = "root"; // Your database username
        String dbPassword = ""; // Your database password

        try {
            // Load MySQL JDBC Driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Establish connection
            Connection conn = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);

            // Check if user exists
            String sql = "SELECT * FROM users WHERE (email = ? OR phone = ?) AND password = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, emailOrPhone);
            stmt.setString(2, emailOrPhone);
            stmt.setString(3, password);

            ResultSet rs = stmt.executeQuery();
            

            if (rs.next()) {
                // User found, return JSON response
            	String encodedProfileImage = URLEncoder.encode(rs.getString("profile_picture"), StandardCharsets.UTF_8);
                out.println("{");
                out.println("\"status\": \"success\",");
                out.println("\"userId\": \"" + escapeJson(rs.getString("userId")) + "\",");
                out.println("\"fullName\": \"" + escapeJson(rs.getString("full_name")) + "\",");
                out.println("\"city\": \"" + escapeJson(rs.getString("city")) + "\",");
                out.println("\"country\": \"" + escapeJson(rs.getString("country")) + "\",");
                out.println("\"bio\": \"" + escapeJson(rs.getString("bio")) + "\",");
                out.println("\"username\": \"" + escapeJson(rs.getString("username")) + "\",");
                out.println("\"email\": \"" + escapeJson(rs.getString("email")) + "\",");
                out.println("\"phoneNumber\": \"" + escapeJson(rs.getString("phone")) + "\",");
                out.println("\"userType\": \"" + escapeJson(rs.getString("user_type")) + "\",");
                out.println("\"profileImage\": \"" + encodedProfileImage + "\",");
                out.println("\"taxType\": \"" + escapeJson(rs.getString("tax_type")) + "\"");
                out.println("}");
            } else {
                // User not found
                out.println("{\"status\": \"error\", \"message\": \"Invalid email/phone or password!\"}");
            }

            // Close connections
            rs.close();
            stmt.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
            out.println("{\"status\": \"error\", \"message\": \"" + e.getMessage() + "\"}");
        }
	}
	
	private String escapeJson(String value) {
        if (value == null) return "";
        return value.replace("\\", "\\\\") // Escape backslashes
                    .replace("\"", "\\\"") // Escape double quotes
                    .replace("\n", "\\n") // Escape new lines
                    .replace("\r", "\\r"); // Escape carriage returns
    }

}
