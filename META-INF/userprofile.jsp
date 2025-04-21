<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard</title>
    <!-- <link rel="stylesheet" href="adminDashboard.css"> -->
    <link rel="stylesheet" href="userDashboard.css">
    <link rel="stylesheet" href="editprofile.css">
    <!-- <script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script> -->
    <script src="sidebar.js"></script>
</head>
<body>
    <div id="sidebar-container">
        <div class="sidebar">
            <img src="./images/tax_logo.jpg" alt="Liberty Tax">
            <span style="display: flex; align-items: center; gap: 10px"><img id="sidebar-avatar" style="height: 50px; width: 50px; margin: 0"><p class="admin-info">Welcome <b id="user-fullName"></b></p></span>
            <a class="sidebar-element" href="userDashboard.jsp"><img src="./images/dashb.jpg" alt="Liberty Tax" style="height: 30px; width: 30px;margin: 5px;"> Dashboard</a>
            <a class="sidebar-element" href="home.jsp"><img src="./images/live sign.jpg" alt="Liberty Tax" style="height: 30px; width: 30px;margin: 5px;"> Live Site</a>
            <a class="sidebar-element" href="user-taxfile.jsp"><img src="./images/user1.jpg" alt="Liberty Tax" style="height: 30px; width: 30px;margin: 5px;"> My TaxFiles</a>
            <p class="sidebar-element" onClick="logout()"><img src="./images/logoutadmin2.jpg" alt="Liberty Tax" style="height: 30px; width: 30px;margin: 5px;"> Logout</p>
        </div>
        
    </div>
    <div class="content">
        <header>
            <span class="contact-info"><img src="./images/colorphne.jpg" height="15px"> +917600300778</span>
            <a href="viewProfile.jsp" class="profile">View Profile</a>
            <button class="user-btn">User: <span class="new-user">New Comer</span></button>
        </header>
    
        <!-- Main Content -->
        <main>
            <form id="edit-profile" class="display-flex" enctype="multipart/form-data">
			    <div class="left-section">
			        <div class="display-flex">
			            <img class="profile-image" height="200px">
			            <h3>Edit Profile - Complete your profile</h3>
			        </div>
			        <input id="userId" type="text" name="userId" style="display: none">
			
			        <div>
			             <label>Full Name</label>
			             <input type="text" name="fullName" placeholder="Gibson" required>
			        </div>
			        
			        <div class="display-flex">
			            <div>
			                <label>City</label>
			                <input type="text" name="city" placeholder="Rajkot">
			            </div>
			            <div>
			                <label>Country</label>
			                <input type="text" name="country" placeholder="India" required>
			            </div>
			        </div>
			        
			        <label>About me<br> Detail Information About you</label>
			        <textarea name="aboutMe"></textarea>
			
			        <button type="submit">Update Profile</button>
			
			        <h3>Change Password</h3>
			        <div class="display-flex">
			            <div>
			                <label>Current Password*</label>
			                <input type="password" name="currentPassword">
			            </div>
			            <div>
			                <label>New Password*</label>
			                <input type="password" name="newPassword">
			            </div>
			            <div>
			                <label>Confirm Password*</label>
			                <input type="password" name="confirmPassword">
			            </div>
			        </div>
			        <button type="submit">Update Password</button>
			    </div>
			    
			    <div class="right-section">
			        <h3>Update Picture</h3>
			        <div>
			            <img class="profile-image" height="250px"><br>
			            <input type="file" name="profilePicture" accept="image/*">
			        </div>
			    </div>
			</form>

        </main>
    </div>
</body>
<!-- <script>
    fetch("sidebar.jsp")
    .then(response => response.text())
    .then(data => {
        document.getElementById("sidebar-container").innerHTML = data;
    })
    .catch(error => console.error("Error loading sidebar:", error));
</script> -->
<script>
        // Check if user is logged in
        let user = localStorage.getItem("user");

        if (!user) {
            // Redirect to login if no user data            if ()
            window.location.href = "login.jsp";
        } else {
            // Parse user data
            user = JSON.parse(user);

            if (user.userType == "admin") {
            	window.location.href = "login.jsp";
            }
            
            //document.getElementById("username").innerHTML = user.username;
            document.getElementById("user-fullName").innerHTML = user.fullName;
            document.getElementById("userId").value = user.userId;
            let profileImages = document.getElementsByClassName("profile-image");
            let profileImageUrl = decodeURIComponent(user.profileImage); // Decode if URL was encoded
            document.getElementById("sidebar-avatar").src = decodeURIComponent(user.profileImage);

            // Loop through all elements with class "profile-image" and update their src
            for (let i = 0; i < profileImages.length; i++) {
                profileImages[i].src = profileImageUrl;
            }

            // Display user details
            //document.getElementById("username").textContent = user.fullName;
            //document.getElementById("user-email").textContent = user.email;
            //document.getElementById("user-phone").textContent = user.phoneNumber;
            //document.getElementById("user-tax").textContent = user.taxType;
        }
        
        document.getElementById("edit-profile").addEventListener("submit", async function (event) {
            event.preventDefault(); // Prevent default form submission

            let formData = new FormData(this); // Get form data

            try {
                let response = await fetch("EditProfileServlet", {
                    method: "POST",
                    body: formData, // No need to manually convert FormData
                });

                let result = await response.json(); // Handle response as text
                if (result.status == "success") {
    	            // Store user data in localStorage
    	            localStorage.setItem("user", JSON.stringify(result));
    	            
    	            location.reload();
    	            
    	            alert(result.message);
                }
            } catch (error) {
                console.error("Error:", error);
                alert("An error occurred. Please try again.");
            }
        });


        // Logout function
        function logout() {
            localStorage.removeItem("user"); // Clear localStorage
            window.location.href = "login.jsp"; // Redirect to login
        }
    </script>
</html>
