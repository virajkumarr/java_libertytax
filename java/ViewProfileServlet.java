

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
 * Servlet implementation class ViewProfileServlet
 */
@WebServlet("/ViewProfileServlet")
public class ViewProfileServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ViewProfileServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
//		response.getWriter().append("Served at: ").append(request.getContextPath());
		response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();

        // Get userId from session (Assuming user is already logged in)
        Integer userId = (Integer) request.getSession().getAttribute("userId");

        if (userId == null) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            out.write("{\"status\": \"error\", \"message\": \"User not logged in\"}");
            return;
        }

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            // Database connection setup
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/your_database", "your_username", "your_password");

            // SQL query to fetch user details
            String query = "SELECT user_type, username, full_name, city, country, bio, phone, email, tax_type, profile_picture FROM users WHERE id = ?";
            pstmt = conn.prepareStatement(query);
            pstmt.setInt(1, userId);
            rs = pstmt.executeQuery();

            // Process result and return JSON response
            if (rs.next()) {
            	String encodedProfileImage = URLEncoder.encode(rs.getString("profile_picture"), StandardCharsets.UTF_8);
                out.println("{");
                out.println("\"status\": \"success\",");
                out.println("\"userId\": \"" + escapeJson(rs.getString("userId")) + "\",");
                out.println("\"fullName\": \"" + escapeJson(rs.getString("full_name")) + "\",");
                out.println("\"username\": \"" + escapeJson(rs.getString("username")) + "\",");
                out.println("\"email\": \"" + escapeJson(rs.getString("email")) + "\",");
                out.println("\"phoneNumber\": \"" + escapeJson(rs.getString("phone")) + "\",");
                out.println("\"userType\": \"" + escapeJson(rs.getString("user_type")) + "\",");
                out.println("\"message\": \"" + "Profile Updated Succesfully" + "\",");
                out.println("\"profileImage\": \"" + encodedProfileImage + "\",");
                out.println("\"taxType\": \"" + escapeJson(rs.getString("tax_type")) + "\"");
                out.println("}");
            } else {
                response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                out.write("{\"status\": \"error\", \"message\": \"User not found\"}");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            out.write("{\"status\": \"error\", \"message\": \"Internal server error\"}");
        } finally {
            try { if (rs != null) rs.close(); } catch (Exception e) {}
            try { if (pstmt != null) pstmt.close(); } catch (Exception e) {}
            try { if (conn != null) conn.close(); } catch (Exception e) {}
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
