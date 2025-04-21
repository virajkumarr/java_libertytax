
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login Page</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
            padding: 20px;
        }
        .container {
            display: flex;
            flex-direction: row;
            align-items: center;
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            max-width: 900px;
            width: 100%;
        }
        .image-section {
            flex: 1;
            text-align: center;
            padding: 20px;
        }
        .image-section img {
            max-width: 100%;
            height: auto;
        }
        .login-box {
            flex: 1;
            padding: 20px;
        }
        .input-box {
            display: flex;
            align-items: center;
            margin: 10px 0;
            border-bottom: 2px solid #ccc;
            padding: 5px;
        }
        .input-box input {
            border: none;
            outline: none;
            flex: 1;
            padding: 10px;
            font-size: 16px;
        }
	.remember {
	    margin: 50px 0px;
	}
        .btn {
            background: #2c3e50;
            color: white;
            border: none;
            padding: 10px;
            width: 100%;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
        }
        .btn:hover {
            background: #34495e;
        }
        .links {
            display: flex;
            justify-content: space-between;
            margin-top: 10px;
        }
        .links a {
            text-decoration: none;
            color: #555;
        }
        @media (max-width: 768px) {
            .container {
                flex-direction: column;
                text-align: center;
            }
            .image-section {
                margin-bottom: 20px;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="image-section">
            <img src="./images/th (1).jpg" style="height: 300px;" alt="Liberty Tax Illustration">
        </div>
        <div class="login-box">
        	<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-arrow-left" viewBox="0 0 16 16">
  <path fill-rule="evenodd" d="M15 8a.5.5 0 0 0-.5-.5H2.707l3.147-3.146a.5.5 0 1 0-.708-.708l-4 4a.5.5 0 0 0 0 .708l4 4a.5.5 0 0 0 .708-.708L2.707 8.5H14.5A.5.5 0 0 0 15 8"/>
</svg><a href="index.jsp" style="color: black; text-decoration: none; margin-left: 5px; margin-bottom: 15px;">Home</a>
            <h2>Login</h2>
            <form onsubmit="verifyUser(event)">
                <div class="input-box">
                    <i class="fas fa-envelope"></i>
                    <input id="email" type="text" name="emailOrPhone" placeholder="Email or Phone Here" required>
                </div>
                <div class="input-box">
                    <i class="fas fa-lock"></i>
                    <input type="password" id="password" name="password" placeholder="Password" required>
                    <i class="fas fa-eye-slash"></i>
                </div>
                <div class="remember">
                    <input type="checkbox" id="remember">
                    <label for="remember">Remember me</label>
                </div>
                <button type="submit" class="btn">Login Here</button>
            </form>
            <div class="links">
                <a href="signup.jsp">New User?</a>
                <a href="#">Forget Password?</a>
            </div>
        </div>
    </div>
</body>

<script>
	let user = localStorage.getItem("user");
	
	if (user) {
	    // Redirect to login if no user data            if ()
	    window.location.href = "home.jsp";
	}

	function verifyUser(event) {
	    event.preventDefault(); // Prevent form from submitting normally
	
	    let emailOrPhone = document.getElementById("email").value;
	    let password = document.getElementById("password").value;
	
	    // Send login request to the servlet
	    fetch("LoginServlet", {
		    method: "POST",
		    headers: {
		        "Content-Type": "application/x-www-form-urlencoded"
		    },
		    body: "emailOrPhone=" + encodeURIComponent(emailOrPhone) + "&password=" + encodeURIComponent(password)
		})
	    .then(response => response.json()) // Parse JSON response
	    .then(data => {
	        console.log("Response Data:", data);
	
	        if (data.status === "success") {
	            // Store user data in localStorage
	            localStorage.setItem("user", JSON.stringify(data));
	
	            // Parse stored data to access properties
	            let userData = JSON.parse(localStorage.getItem("user"));
	
	            if (userData.userType === "user") {
	                window.location.href = "userDashboard.jsp";
	            } else if (userData.userType === "admin") {
	                window.location.href = "adminDashboard.jsp";
	            } else {
	                alert("Unknown user type.");
	            }
	
	        } else {
	            alert(data.message); // Show error message
	        }
	    })
	    .catch(error => console.error("Error:", error));
	}

</script>

</html>
