<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Tax File</title>
    <link rel="stylesheet" href="userDashboard.css">
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
            <button class="user-btn">User: New Comer</button>
            <div class="profile-options">
                <a href="userprofile.jsp" class="profile"><i class="fas fa-user"></i> Edit Profile</a>
                <a href="viewProfile.jsp" class="profile">View Profile</a>
            </div>
        </header>
        <div class="header">
            <h2>Tax Files Record</h2>
        </div>
        <form class="search-form" onSubmit="fetchFilteredTaxFiles(event)">
        	<input type="text" id="search-keyword" placeholder="Enter TaxFile ID" required>
        	<button type="submit">Search</button>
        </form>
        <table id="taxFilesTable" style="width: 100%">
            <tr>
                <th>User Name</th>
                <th>Email</th>
                <th>TaxFile ID</th>
                <th>Amount</th>
                <th>Payment Method</th>
                <th>Payment Date</th>
                <th>Download Receipt</th>
            </tr>
        </table>
    </div>
    <!-- <script src="sidebar.js"></script> -->
</body>
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
        
        function fetchFilteredTaxFiles(e) {
        	e.preventDefault();
        	let searchTaxFileId = document.getElementById("search-keyword").value;
        	let email = JSON.parse(localStorage.getItem("user")).email;
            let tableContainer = document.getElementById("taxFilesTable");
            const rows = tableContainer.querySelectorAll("tr"); 
        	fetch("FetchTaxFilesServlet?email="+email+"&taxfileid="+searchTaxFileId)
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
        	let email = JSON.parse(localStorage.getItem("user")).email;
            let tableContainer = document.getElementById("taxFilesTable");
            fetch("FetchTaxFilesServlet?email="+email)
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
