

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.security.SecureRandom;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.text.Normalizer;
import java.util.Locale;
import java.util.UUID;

/**
 * Servlet implementation class RegisterServlet
 */
@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RegisterServlet() {
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
	
	public class UsernameGenerator {
	    private static final String CHARACTERS = "0123456789";
	    private static final SecureRandom random = new SecureRandom();

	    public static String generateUsername(String fullName) {
	        // Normalize and clean up the full name
	        String username = Normalizer.normalize(fullName, Normalizer.Form.NFD)
	                .replaceAll("\\p{M}", "") // Remove accents
	                .replaceAll("[^a-zA-Z]", "") // Keep only letters
	                .toLowerCase(Locale.ROOT);

	        // Append a random number for uniqueness
	        String randomDigits = String.valueOf(1000 + random.nextInt(9000)); // 4-digit random number

	        return username + randomDigits;
	    }
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
//		doGet(request, response);
		 // Generate unique user ID
		response.setContentType("application/json");
        String userId = UUID.randomUUID().toString();
        String taxType = request.getParameter("taxType");
        String fullName = request.getParameter("fullname");
        String phoneNumber = request.getParameter("phoneNumber");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String username = UsernameGenerator.generateUsername(fullName);
        // Database connection details
        String jdbcURL = "jdbc:mysql://localhost:3306/liberty_tax";
        String dbUser = "root";
        String dbPassword = "";
        PrintWriter out = response.getWriter();

        try {
            // Load MySQL JDBC Driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Establish connection
            Connection conn = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);

            // Insert query
            String sql = "INSERT INTO users (userId, user_type, full_name, phone, email, password, tax_type, username) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, userId);
            stmt.setString(2, "user");
            stmt.setString(3, fullName);
            stmt.setString(4, phoneNumber);
            stmt.setString(5, email);
            stmt.setString(6, password);
            stmt.setString(7, taxType);
            stmt.setString(8, username);

            // Execute update
            int result = stmt.executeUpdate();

            if (result > 0) {
                // Manually create JSON response
                String jsonResponse = "{"
                        + "\"status\":\"success\","
                        + "\"userId\":\"" + userId + "\","
                        + "\"fullName\":\"" + fullName + "\","
                        + "\"city\":\"" + "" + "\","
                        + "\"country\":\"" + "" + "\","
                        + "\"bio\":\"" + "" + "\","
                        + "\"username\":\"" + username + "\","
                        + "\"phoneNumber\":\"" + phoneNumber + "\","
                        + "\"email\":\"" + email + "\","
                        + "\"userType\":\"" + "user" + "\","
                        + "\"profileImage\":\"" + "" + "\","
                        + "\"taxType\":\"" + taxType + "\""
                        + "}";

                out.print(jsonResponse);
            } else {
                out.print("{\"status\":\"error\", \"message\":\"Registration Failed. Try Again!\"}");
            }

            stmt.close();
            conn.close();

        } catch (Exception e) {
            e.printStackTrace();
            out.print("{\"status\":\"error\", \"message\":\"" + e.getMessage() + "\"}");
        }
	}

}
