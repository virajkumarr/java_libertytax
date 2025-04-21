<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sign Up Page</title>
    <script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
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
        .signup-box {
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
        <div class="signup-box">
            <h2>Sign Up</h2>
            <form id="registerForm">
                <div class="input-box">
                    <i class="fas fa-user"></i>
                    <select style="background: transparent; border: none" name="taxType">
                    	<option>Select Tax Type</option>
                    	<option>Employee</option>
                    	<option>Business</option>
                    </select>
                </div>
                <div class="input-box">
                    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 448 512" height="15px" width="15px">
                    	<path d="M224 256A128 128 0 1 0 224 0a128 128 0 1 0 0 256zm-45.7 48C79.8 304 0 383.8 0 482.3C0 498.7 13.3 512 29.7 512l388.6 0c16.4 0 29.7-13.3 29.7-29.7C448 383.8 368.2 304 269.7 304l-91.4 0z"/>
                    </svg>
                    <input type="text" placeholder="Enter full name" name="fullname" required>
                </div>
                <div class="input-box">
                    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512" height="15px" width="15px">
                    <!--!Font Awesome Free 6.7.2 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2025 Fonticons, Inc.-->
                    <path d="M164.9 24.6c-7.7-18.6-28-28.5-47.4-23.2l-88 24C12.1 30.2 0 46 0 64C0 311.4 200.6 512 448 512c18 0 33.8-12.1 38.6-29.5l24-88c5.3-19.4-4.6-39.7-23.2-47.4l-96-40c-16.3-6.8-35.2-2.1-46.3 11.6L304.7 368C234.3 334.7 177.3 277.7 144 207.3L193.3 167c13.7-11.2 18.4-30 11.6-46.3l-40-96z"/>
                    </svg>
                    <input type="text" placeholder="Enter Phone number" name="phoneNumber" required>
                </div>
                <div class="input-box">
                    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512" height="15px" width="15px">
                    	<!--!Font Awesome Free 6.7.2 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2025 Fonticons, Inc.-->
                    	<path d="M48 64C21.5 64 0 85.5 0 112c0 15.1 7.1 29.3 19.2 38.4L236.8 313.6c11.4 8.5 27 8.5 38.4 0L492.8 150.4c12.1-9.1 19.2-23.3 19.2-38.4c0-26.5-21.5-48-48-48L48 64zM0 176L0 384c0 35.3 28.7 64 64 64l384 0c35.3 0 64-28.7 64-64l0-208L294.4 339.2c-22.8 17.1-54 17.1-76.8 0L0 176z"/>
                    </svg>
                    <input type="email" placeholder=" Enter Email" name="email" required>
                </div>
                <div class="input-box">
                	<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 448 512" height="15px" width="15px">
                    	<!--!Font Awesome Free 6.7.2 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2025 Fonticons, Inc.-->
                    	<path d="M144 144l0 48 160 0 0-48c0-44.2-35.8-80-80-80s-80 35.8-80 80zM80 192l0-48C80 64.5 144.5 0 224 0s144 64.5 144 144l0 48 16 0c35.3 0 64 28.7 64 64l0 192c0 35.3-28.7 64-64 64L64 512c-35.3 0-64-28.7-64-64L0 256c0-35.3 28.7-64 64-64l16 0z"/>
                    </svg>
                    <input type="password" placeholder="Enter Password" name="password" required>
                </div>
                <div class="input-box">
                    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 448 512" height="15px" width="15px">
                    	<!--!Font Awesome Free 6.7.2 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2025 Fonticons, Inc.-->
                    	<path d="M144 144l0 48 160 0 0-48c0-44.2-35.8-80-80-80s-80 35.8-80 80zM80 192l0-48C80 64.5 144.5 0 224 0s144 64.5 144 144l0 48 16 0c35.3 0 64 28.7 64 64l0 192c0 35.3-28.7 64-64 64L64 512c-35.3 0-64-28.7-64-64L0 256c0-35.3 28.7-64 64-64l16 0z"/>
                    </svg>
                    <input type="password" placeholder="Re-Write Password" required>
                    
                </div>
                <div class="remember">
                    <input type="checkbox" id="agree">
                    <label for="agree">I have read the agreement</label>
                </div>
                <button type="submit" class="btn">Register Here</button>
            </form>
            <div class="links">
                <a href="login.jsp">Already Have an Account?</a>
            </div>
        </div>
    </div>
</body>
<script>
let user = localStorage.getItem("user");

if (user) {
    // Redirect to login if no user data 
    window.location.href = "home.jsp";
}
document.getElementById("registerForm").addEventListener("submit", async function(event) {
    event.preventDefault(); // Prevent default form submission

    let formData = new FormData(this); // Get form data

    // Convert formData to JSON
    let data = {};
    formData.forEach((value, key) => { data[key] = value; });

    try {
        let response = await fetch("RegisterServlet", {
            method: "POST",
            body: new URLSearchParams(data),
            headers: { "Content-Type": "application/x-www-form-urlencoded" }
        });

        let result = await response.json();

        if (result.status === "success") {
            // Store user data in localStorage
            localStorage.setItem("user", JSON.stringify(result));

            // Redirect to dashboard
            window.location.href = "userDashboard.jsp";
        } else {
            alert("Registration failed: " + result.message);
        }
    } catch (error) {
        console.error("Error:", error);
        alert("An error occurred. Please try again.");
    }
});
</script>

</html>
