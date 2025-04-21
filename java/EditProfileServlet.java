

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.nio.file.Paths;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * Servlet implementation class EditProfileServlet
 */
@WebServlet("/EditProfileServlet")
@MultipartConfig(
	    fileSizeThreshold = 1024 * 1024 * 2, // 2MB
	    maxFileSize = 1024 * 1024 * 10, // 10MB
	    maxRequestSize = 1024 * 1024 * 50 // 50MB
)
public class EditProfileServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public EditProfileServlet() {
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
	
	private static final String UPLOAD_DIR = "profile_pictures";
    private static final String DB_URL = "jdbc:mysql://localhost:3306/liberty_tax";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "";

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
//		doGet(request, response);
		PrintWriter out = response.getWriter();
		String userId = request.getParameter("userId");
        String fullName = request.getParameter("fullName");
        String city = request.getParameter("city");
        String country = request.getParameter("country");
        String aboutMe = request.getParameter("aboutMe");
        String currentPassword = request.getParameter("currentPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");
        String profilePicturePath = null;
        

        // Handle file upload
        Part filePart = request.getPart("profilePicture");
        if (filePart != null && filePart.getSize() > 0) {
            String fileExtension = "";
            String originalFileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
            
            // Extract file extension if present
            int dotIndex = originalFileName.lastIndexOf('.');
            if (dotIndex > 0) {
                fileExtension = originalFileName.substring(dotIndex); // Includes the dot (e.g., ".jpg")
            }

            // Define the new filename using userId
            String newFileName = "profile_" + userId + fileExtension;

            // Define a web-accessible directory
            String uploadDir = UPLOAD_DIR; 
            String uploadPath = getServletContext().getRealPath("") + File.separator + uploadDir;

            // Ensure the directory exists
            File uploadDirFile = new File(uploadPath);
            if (!uploadDirFile.exists()) {
                uploadDirFile.mkdirs(); // Create directory if it doesn't exist
            }

            // Save the file with the new name
            String savedFilePath = uploadPath + File.separator + newFileName;
            filePart.write(savedFilePath);

            // Save only the relative path (not full system path)
            profilePicturePath = uploadDir + "/" + newFileName; 
        }

        // Update user profile details in the database
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
            
            String sql = "UPDATE users SET full_name=?, city=?, country=?, bio=?, profile_picture=? WHERE userId=?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, fullName);
            stmt.setString(2, city);
            stmt.setString(3, country);
            stmt.setString(4, aboutMe);
            stmt.setString(5, profilePicturePath);
            stmt.setString(6, userId);
            stmt.executeUpdate();
            
            // Process password update if provided
            if (currentPassword != null && !currentPassword.isEmpty() && newPassword != null && confirmPassword.equals(newPassword)) {
                String updatePasswordSQL = "UPDATE users SET password=? WHERE userId=?";
                PreparedStatement passwordStmt = conn.prepareStatement(updatePasswordSQL);
                passwordStmt.setString(1, newPassword);
                passwordStmt.setString(2, userId);
                passwordStmt.executeUpdate();
            }
            
            String fetchQuery = "SELECT * FROM users WHERE userId=?";
            PreparedStatement fetchstmt = conn.prepareStatement(fetchQuery);
            fetchstmt.setString(1, userId);

            ResultSet rs = fetchstmt.executeQuery();
            

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
                out.println("\"message\": \"" + "Profile Updated Succesfully" + "\",");
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
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            response.getWriter().println("Error updating profile: " + e.getMessage());
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
