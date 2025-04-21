<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard</title>
    <!-- <link rel="stylesheet" href="adminDashboard.css"> -->
    <link rel="stylesheet" href="userDashboard.css">
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
            <button class="user-btn">User: <span class="new-user">New Comer</span></button>
            <div class="profile-options">
                <a href="userprofile.jsp" class="profile">Edit Profile</a>
                <a href="viewProfile.jsp" class="profile">View Profile</a>
            </div>
        </header>
    
        <!-- Main Content -->
        <main>
            <h2>Greetings!</h2>
    
            <!-- Call to Action -->
            <div class="cta">
                <span>File Your Tax:</span>
                <a href="taxfillingform.jsp" class="btn red-btn">Let's Get Started</a>
            </div>
    
            <!-- Image Grid Section -->
            <div class="image-grid">
                <img src="./images/taxes img.jpg" alt="Taxes" class="tax-image">
                <img src="./images/carousal img1.jpg" alt="Tax Calculation" class="tax-image">
                <img src="./images/carousal img2.jpg" alt="Corporate Tax" class="tax-image">
            </div>
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
            
            document.getElementById("user-fullName").innerHTML = user.fullName;
            document.getElementById("sidebar-avatar").src = decodeURIComponent(user.profileImage);
            // Display user details
            //document.getElementById("username").textContent = user.fullName;
            //document.getElementById("user-email").textContent = user.email;
            //document.getElementById("user-phone").textContent = user.phoneNumber;
            //document.getElementById("user-tax").textContent = user.taxType;
        }

        // Logout function
        function logout() {
            localStorage.removeItem("user"); // Clear localStorage
            window.location.href = "login.jsp"; // Redirect to login
        }
    </script>
</html>
