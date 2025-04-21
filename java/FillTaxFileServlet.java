

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

/**
 * Servlet implementation class FillTaxFileServlet
 */
@WebServlet("/FillTaxFileServlet")
public class FillTaxFileServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public FillTaxFileServlet() {
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
	
	private static final String DB_URL = "jdbc:mysql://localhost:3306/liberty_tax";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "";

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
//		doGet(request, response);
		response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();

        

        // Extract form parameters
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String taxFileId = request.getParameter("taxFileId");
        String amount = request.getParameter("amount");
        String paymentDate = request.getParameter("paymentDate");
        String paymentMode = "UPI"; // Default to UPI

        System.out.println("Extracted Values - Username: " + username + ", Email: " + email);

        // Validate required fields
        if (username == null || email == null || taxFileId == null || 
            amount == null || paymentDate == null) {
            out.write("{\"status\": \"error\", \"message\": \"Missing required fields!\"}");
            return;
        }

        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            // Load MySQL JDBC Driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Establish database connection
            conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

            // Insert payment details into database
            String sql = "INSERT INTO tax_files (username, email, taxfile_id, amount, payment_date, payment_mode) VALUES (?, ?, ?, ?, ?, ?)";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, username);
            stmt.setString(2, email);
            stmt.setString(3, taxFileId);
            stmt.setString(4, amount);
            stmt.setString(5, paymentDate);
            stmt.setString(6, paymentMode);

            int rowsInserted = stmt.executeUpdate();

            if (rowsInserted > 0) {
                out.write("{\"status\": \"success\", \"message\": \"Your tax file has been submitted successfully!\"}");
            } else {
                out.write("{\"status\": \"error\", \"message\": \"Failed to submit the tax file. Try again!\"}");
            }
        } catch (Exception e) {
            e.printStackTrace();
            out.write("{\"status\": \"error\", \"message\": \"" + e.getMessage() + "\"}");
        } finally {
            try {
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

	}

}
