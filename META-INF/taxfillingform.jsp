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
            <form id="tax-filling-form">
            	<label>Username</label>
            	<input type="text" placeholder="Enter Username Here" name="username" required>
            	<label>Email</label>
            	<input type="email" placeholder="Enter Email Here" name="email" required>
            	<label>Tax File ID</label>
            	<input type="text" placeholder="Enter Tax File ID Here" name="taxFileId" required>
            	<label>Amount</label>
            	<input type="number" placeholder="Enter Amount Here" name="amount" required>
            	<label>Payment Mode</label>
            	<div style="display: flex; align-items: center; justify-content: space-between;">
            		<p style="margin-left: 10px;">Scan UPI Code</p>
            		<img src="./images/upi_qr.jpg" height="150px">
            	</div>
            	<label>Payment Date</label>
            	<input type="date" name="paymentDate" required>
            	<br>
            	<button type="submit" >Submit</button>
            </form>
            <div class="payment-success" id="payment-success">
            	<button class="close-button" onClick="handleClose()">Close</button>
            	<div style="height: 100%; display: flex; align-items: center; justify-content: center; flex-direction: column">
            		<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512" height="200px" width="200px">
            			<!--!Font Awesome Free 6.7.2 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2025 Fonticons, Inc.-->
            			<path d="M256 512A256 256 0 1 0 256 0a256 256 0 1 0 0 512zM369 209L241 337c-9.4 9.4-24.6 9.4-33.9 0l-64-64c-9.4-9.4-9.4-24.6 0-33.9s24.6-9.4 33.9 0l47 47L335 175c9.4-9.4 24.6-9.4 33.9 0s9.4 24.6 0 33.9z"/>
            		</svg>
            		<h3 style="text-align: center">Payment Success</h3>
            	</div>
            </div>
        </main>
    </div>
</body>
<script>
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
    
    
	document.getElementById("tax-filling-form").addEventListener("submit", async function (event) {
	    event.preventDefault(); // Prevent default form submission

	    let formData = new FormData(this); // Get form data

	    // Convert formData to JSON
	    let data = {};
	    formData.forEach((value, key) => { data[key] = value; });

	    fetch("FillTaxFileServlet", { 
	    	method: "POST",
            body: new URLSearchParams(data),
            headers: { "Content-Type": "application/x-www-form-urlencoded" }
	    })
	    .then(response => response.text())
	    .then(data => {
	        console.log("Raw response:", data); // Debug response
	        
	        try {
	            let jsonData = JSON.parse(data);
	            alert(jsonData.message);
	            paymentSuccess.style.display = "block";
	        } catch (error) {
	            console.error("JSON Parsing Error:", error);
	            alert("Unexpected response from server!");
	        }
	    })
	    .catch(error => console.error("Fetch Error:", error));
	});



	function logout() {
	    localStorage.removeItem("user"); // Clear localStorage
	    window.location.href = "login.jsp"; // Redirect to login
	}
	let paymentSuccess = document.getElementById('payment-success');
    
    function handleClose() {
    	paymentSuccess.style.display = "none";
    	location.reload();
    }
	</script>
</html>
