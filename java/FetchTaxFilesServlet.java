

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

/**
 * Servlet implementation class FetchTaxFilesServlet
 */
@WebServlet("/FetchTaxFilesServlet")
public class FetchTaxFilesServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public FetchTaxFilesServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
//		response.getWriter().append("Served at: ").append(request.getContextPath());
		response.setContentType("text/html");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();

        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        String email = request.getParameter("email");
        String taxFileId = request.getParameter("taxfileid");

        try {
            // Load MySQL JDBC Driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Establish database connection
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/liberty_tax", "root", "");

            String sql;
            if (taxFileId == null || taxFileId.trim().isEmpty()) {
                if (email == null || email.trim().isEmpty() || email.equalsIgnoreCase("null")) {
                    sql = "SELECT * FROM tax_files"; // Fetch all records
                    stmt = conn.prepareStatement(sql);
                } else {
                    sql = "SELECT * FROM tax_files WHERE email = ?";
                    stmt = conn.prepareStatement(sql);
                    stmt.setString(1, email);
                }
            } else {
                if (email == null || email.trim().isEmpty() || email.equalsIgnoreCase("null")) {
                    sql = "SELECT * FROM tax_files WHERE taxfile_id = ?";
                    stmt = conn.prepareStatement(sql);
                    stmt.setString(1, taxFileId);
                } else {
                    sql = "SELECT * FROM tax_files WHERE email = ? AND taxfile_id = ?";
                    stmt = conn.prepareStatement(sql);
                    stmt.setString(1, email);
                    stmt.setString(2, taxFileId);
                }
            }

            rs = stmt.executeQuery();

            // Generate HTML table

            while (rs.next()) {
                out.println("<tr>");
                out.println("<td>" + rs.getString("username") + "</td>");
                out.println("<td>" + rs.getString("email") + "</td>");
                out.println("<td>" + rs.getString("taxfile_id") + "</td>");
                out.println("<td>" + rs.getString("amount") + "</td>");
                out.println("<td>" + rs.getString("payment_mode") + "</td>");
                out.println("<td>" + rs.getString("payment_date") + "</td>");
                out.println("<td><a href='downloadReceipt.jsp?taxFileId=" + rs.getString("taxfile_id") + "'>Download</a></td>");
                out.println("</tr>");
            }

        } catch (Exception e) {
            e.printStackTrace();
            out.println("<p style='color:red;'>Error: " + e.getMessage() + "</p>");
        } finally {
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
		
	}

}
