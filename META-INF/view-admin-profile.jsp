<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Profile</title>
    <link rel="stylesheet" href="adminDashboard.css">
    <link rel="stylesheet" href="profile.css">
    <script>
    	var userDetails = JSON.parse(localStorage.getItem("user"));
    	console.log(userDetails.profileImage);
    	
    	
    	if (!userDetails) {
    	    // Redirect to login if no user data            if ()
    	    window.location.href = "login.jsp";
    	} else {
    	    // Parse user data
    	    user = JSON.parse(userDetails);
    	
    	    if (userDetails.userType == "user") {
    	    	window.location.href = "login.jsp";
    	    }
    	    
    	    document.getElementById("user-fullName").innerHTML = user.fullName;
    	
    	    // Display user details
    	    //document.getElementById("username").textContent = user.fullName;
    	    //document.getElementById("user-email").textContent = user.email;
    	    //document.getElementById("user-phone").textContent = user.phoneNumber;
    	    //document.getElementById("user-tax").textContent = user.taxType;
    	}
    </script>
</head>
<body>
    <div id="sidebar-container">
        <div class="sidebar">
            <img src="./images/tax_logo.jpg" alt="Liberty Tax">
            <span style="display: flex; align-items: center; gap: 10px"><img id="sidebar-avatar" style="height: 50px; width: 50px; margin: 0"><p class="admin-info">Welcome <b id="user-fullName"></b><br>System Administrator</p></p></span>
            <a href="adminDashboard.jsp"><img src="./images/dashb.jpg" alt="Liberty Tax" style="height: 30px; width: 30px;margin: 5px;"> Dashboard</a>
            <a href="home.jsp"><img src="./images/live sign.jpg" alt="Liberty Tax" style="height: 30px; width: 30px;margin: 5px;"> Live Site</a>
            <a href="admin-taxfile.jsp"><img src="./images/user1.jpg" alt="Liberty Tax" style="height: 30px; width: 30px;margin: 5px;"> Admin TaxFile</a>
            <a href="users.jsp"><img src="./images/user1.jpg" alt="Liberty Tax" style="height: 30px; width: 30px;margin: 5px;"> Users</a>
        </div>
    </div>

    <div class="content">
        <header>
            <span class="contact-info"><img src="./images/colorphne.jpg" height="15px"> +917600300778</span>
            <button class="user-btn">User: <span class="new-user">New Comer</span></button>
            <a href="admin-profile.jsp">Edit Profile</a>
        </header>

        <!-- Main Content -->
        <main>
            <div class="profile-container">
                <div class="left-section">
                    <img class="profile-image" id="profile-pic" height="200px">
                    <h2 id="full_name"></h2>
                    <p><strong>Username:</strong> <span id="username"></span></p>
                    <p><strong>User Type:</strong> <span id="user_type"></span></p>
                    <p><strong>City:</strong> <span id="city"></span></p>
                    <p><strong>Country:</strong> <span id="country"></span></p>
                    <p><strong>Bio:</strong> <span id="bio"></span></p>
                    <p><strong>Phone:</strong> <span id="phone"></span></p>
                    <p><strong>Email:</strong> <span id="email"></span></p>
                    <p><strong>Tax Type:</strong> <span id="tax_type"></span></p>
                </div>
            </div>
        </main>
    </div>

    <script>
    //document.addEventListener("DOMContentLoaded", async function () {
    	document.getElementById("user-fullName").innerHTML = userDetails.fullName;
    	document.getElementById("profile-pic").src = decodeURIComponent(userDetails.profileImage);
    	document.getElementById("user_type").innerHTML = userDetails.userType;
    	document.getElementById("username").innerHTML = userDetails.username;
    	document.getElementById("phone").innerHTML = userDetails.phoneNumber;
    	document.getElementById("email").innerHTML = userDetails.email;
    	document.getElementById("tax_type").innerHTML = userDetails.taxType;
    	document.getElementById("username").innerHTML = userDetails.username;
    	document.getElementById("city").innerHTML = userDetails.city;
    	document.getElementById("country").innerHTML = userDetails.country;
    	document.getElementById("bio").innerHTML = userDetails.bio;
    	document.getElementById("sidebar-avatar").src = decodeURIComponent(userDetails.profileImage);
    	
    //}
    	function logout() {
            localStorage.removeItem("user"); // Clear localStorage
            window.location.href = "login.jsp"; // Redirect to login
        }

    </script>
</body>
</html>
