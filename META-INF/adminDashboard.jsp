<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard</title>
    <link rel="stylesheet" href="adminDashboard.css">
    <!-- <script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script> -->
    <script src="sidebar.js"></script>
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
            <button class="user-btn">User: Admin</button>
            <div class="profile-options">
                <button class="user-btn" style="color:white"><a href="admin-profile.jsp" class="profile"><i class="fas fa-user"></i> Edit Profile</a></button>
                <button class="user-btn" style="color:white"><a href="view-admin-profile.jsp" class="profile"><i class="fas fa-user"></i> View Profile</a></button>
                <button class="user-btn" style="color:white"><p class="logout" onClick="logout()" style="cursor: pointer"><i class="fas fa-sign-out-alt"></i> Logout</p></button>
            </div>
        </header>
    
        <!-- Main Content -->
        <main>
            <h2>Hi Butler19, Good Evening!</h2>
    
            <!-- Cards Section -->
            <div class="cards-container">
                <div class="card" style="background: radial-gradient(#5D68AE, #C8B7A4);">
                    <h3>All Users</h3>
                    <a href="users.jsp" class="btn red-btn">Click To See</a>
                </div>
                <div class="card" style="background: radial-gradient(#D46482, #737373);">
                    <h3>All Submitted Tax</h3>
                    <a href="admin-taxfile.jsp" class="btn green-btn">Click To See</a>
                </div>
                <div class="card" style="background: linear-gradient(#74E79180, #70213680, #4689CC80);">
                    <h3>User Form Fields</h3>
                    <a class="btn blue-btn">Click To See</a>
                </div>
            </div>
    
            <!-- Table Section -->
            <h3 class="table-title">Recent Payment Records</h3>
            <form class="search-form" onSubmit="fetchFilteredTaxFiles(event)">
	        	<input id="search-keyword" type="text" placeholder="Enter TaxFile ID" required>
	        	<button type="submit">Search</button>
	        </form>
            <table id="taxFilesTable">
                <thead>
                    <tr>
                        <th>User Name</th>
                        <th>Email</th>
                        <th>TaxFile ID</th>
                        <th>Amount</th>
                        <th>Payment Method</th>
                        <th>Payment Date</th>
                        <th>Download Receipt</th>
                    </tr>
                </thead>
                <tbody>
                    <!-- Data will be inserted here -->
                </tbody>
            </table>
    
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

            if (user.userType == "user") {
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
        
        function fetchFilteredTaxFiles(e) {
        	e.preventDefault();
        	let searchTaxFileId = document.getElementById("search-keyword").value;
            let tableContainer = document.getElementById("taxFilesTable");
            const rows = tableContainer.querySelectorAll("tr"); 
        	fetch("FetchTaxFilesServlet?email="+null+"&taxfileid="+searchTaxFileId)
            .then(response => response.text())
            .then(data => {
            	for (let i = 1; i < rows.length; i++) {
	   	             rows[i].remove();
	   	         }
                tableContainer.innerHTML += data;
            })
            .catch(error => {
            	console.error("Error fetching tax files:", error);
                tableContainer.innerHTML += "<p style='color:red;'>Error loading data.</p>";	
            });
        }
        
        document.addEventListener("DOMContentLoaded", function () {	
            let tableContainer = document.getElementById("taxFilesTable");
            fetch("FetchTaxFilesServlet?email="+null)
                .then(response => response.text())
                .then(data => {
                    tableContainer.innerHTML += data;
                })
                .catch(error => {
                	console.error("Error fetching tax files:", error);
                    tableContainer.innerHTML += "<p style='color:red;'>Error loading data.</p>";	
                });
        });

        // Logout function
        function logout() {
            localStorage.removeItem("user"); // Clear localStorage
            window.location.href = "login.jsp"; // Redirect to login
        }
    </script>
</html>
