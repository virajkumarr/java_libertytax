<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>About Us - LibertyTax</title>
    <link rel="stylesheet" href="styles.css">
    <script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
</head>
<body>

    <header class="top-nav">
    <div class="contact-info">
      <img src="./images/email logo btn.webp" height="15px;"> info@libertytax.com
       <img src="./images/Call-Now-Button.png" height="15px;">+91 76003 00778
    </div>
    <div class="social-icons">
      <a href="#"><i class="fab fa-facebook-f"></i></a>
      <a href="#"><i class="fab fa-x"></i></a>
      <a href="#"><i class="fab fa-instagram"></i></a>
      <a href="#"><i class="fab fa-whatsapp"></i></a>
    </div>
  </header>
  <nav class="main-nav" style="background-color: #FFFFFF">
    <div class="logo">
      <img src="./images/tax_logo.jpg" height="70px">
    </div>
    <ul class="menu">
      <li><a href="index.jsp">Home</a></li>
          <li><a href="about.jsp">About</a></li>
          <li onClick="toggleTaxBeneficiary()">
          	<a href="#">Tax Beneficiary</a>
          	<div id="tax-beneficiary">
          		<div class="elements">
          			<img src="./images/civilian.png" >
          			<p>Employee Tax </p>
          		</div>
          		<div class="elements">
          			<img src="./images/small business.png">
          			<p> Business Tax</p>
          		</div>
          	</div>
          </li>
          <li><a href="#">More</a></li>
          <li><a href="contact.jsp">Contact</a></li>
          <li onmouseover="showLogin()" onmouseout="hideLogin()"><a href="login.jsp">Login/Register</a><a id="login" href="login.jsp">Login</a></li>
    </ul>
  </nav>
    <!-- Hero Section -->
    <section class="hero-section" style="background: url('./images/bg-2.jpeg') no-repeat center; background-size: cover; height: 100px; padding: 50px;">
        <h1>About</h1>
    </section>

    <!-- About Us Section -->
    <section class="about">
        <div class="about-content">
            <img src="./images/bg-1.jpeg" style="height: 500px; width: 700px;" alt="Best Tax Filing">
            <div class="text">
                <h2>About Us</h2>
                <h2><strong>LibertyTax</strong> is a platform that helps in connecting citizens with an easy tax filing.</h2>
                <p>LibertyTax is an easy-to-use web app that allows citizens to submit details to accountants for tax filing and other related services. Our simple, fast, and secure platform is catered to citizens who want to get their taxes filed from home without the hassle of taking buses in rainy or sunny weather, booking appointments, and waiting in line at accountant offices.</p>
                <button class="btn green-btn">Best Tax Filing</button>
                <h2>Our Goal</h2>
        <p>Since 2018, LibertyTax has served over 5,000 citizens across Liberia, simplifying tax filing with fast, secure, and efficient solutions. Our platform connects citizens to expert accountants, offering personalized guidance and eliminating the need for in-person visits.</p>
            </div>
        </div>
    </section>

    <!-- Services Section -->
    <section class="services">
        <h2 class="section-title">What Services We Offer</h2>
        <div class="services-container">
          <div class="service-card">
            <img src="./images/carousal img2.jpg" alt="Corporate Tax">
            <h3>Annual CIT Filing</h3>
            <p>
              We help clients prepare and submit their annual corporate income tax returns along with necessary supporting documents to obtain tax clearance.
            </p>
            <a href="#" class="read-more">More</a>
          </div>
          <div class="service-card">
            <img src="./images/carousal img1.jpg" alt="Tax Payment">
            <h3>Tax Payment Services</h3>
            <p>
              We support global clients with Trust Account services for deposit of regular taxes and VAT to the Liberian government where clients do not have local signatories and cannot issue cheques.
            </p>
            <a href="#" class="read-more">More</a>
          </div>
          <div class="service-card">
            <img src="./images/carou img3.jpg" alt="Personal Tax">
            <h3>Personal Tax Returns Preparing & Filing</h3>
            <p>
              Dealing with taxation is a crucial part for Liberians and it can often be complicated. We strive at understanding the client’s situation to minimize taxes.
            </p>
            <a href="#" class="read-more">More</a>
          </div>
        </div>
      </section>

    <!-- Contact Section -->
    <section class="contact-form">
        <div class="contact-info">
            <h1>Let's discuss something cool together</h1>
            <p><i class="fas fa-envelope"></i> info@libertytax.com</p>
            <p><i class="fas fa-phone"></i> +917600300778</p>
            <p><i class="fas fa-map-marker-alt"></i> 9th Street Sinkor, 1000 Monrovia 10</p>
            <div class="social-icons">
                <i class="fab fa-facebook"></i>
                <i class="fab fa-twitter"></i>
                <i class="fab fa-instagram"></i>
                <i class="fab fa-linkedin"></i>
            </div>
        </div>

        <div class="form-content">
            <h2>Contact Us</h2>
            <p>Please do not hesitate to send us a message, We are looking forward to hearing from you! We reply within 24 hours.</p>
            <form action="#" method="post">
                <input type="text" id="firstName" placeholder="Enter First Name Here.." required>
                <input type="text" id="lastName" placeholder="Enter Last Name Here..." required>
                <input type="email" id="email" placeholder="Enter Email Here..." required>
                <input type="tel" id="phone" placeholder="Enter Phone Here..." required>
                <input type="text" id="subject" placeholder="Enter Subject Here..." required>
                <textarea id="message" placeholder="Write Message Here...." required></textarea>
                <button type="submit">Submit</button>
            </form>
        </div>
    </section>

    <!-- Footer -->
    <footer>
        <div class="footer-content">
            <div class="footer-div" id="footer_div4">
              <img src="./images/tax_logo.jpg" height="70px">
                <p>LIBERTY TAX</p>
                <p><i class="fas fa-phone"></i> +917600300778</p>
                <p><i class="fas fa-globe"></i> https://www.libertytax.com</p>
                <p><i class="fas fa-envelope"></i> info@libertytax.com</p>
            </div>
            <div class="footer-div" id="footer_div3">
                <h3>Services Links</h3>
                <p>Liberty opportunities</p>
            </div>
            <div class="footer-div" id="footer_div2">
                <h3>Contact Us</h3>
                <p><i class="fas fa-map-marker-alt"></i> Office Address<br>
                    9th Street Sinkor<br>
                    1000 Monrovia 10 Liberia</p>
                <p><i class="far fa-clock"></i> Working Hours<br>
                    9:00 AM To 5:00 PM<br>
                    Saturday to Thursday</p>
            </div>
            <div class="footer-div" id="footer_div1">
                <h3>For any kind of Support</h3>
                <p><i class="fab fa-facebook-f"></i> <i class="fab fa-twitter"></i> <i class="fab fa-instagram"></i> <i class="fab fa-whatsapp"></i></p>
            </div>
            </div>
    </footer>

</body>
<script>
	let user = localStorage.getItem("user");
	
	if (user) {
	    // Redirect to login if no user data            
	    window.location.href = "home.jsp";
	}
	let loginElement = document.getElementById("login");
	let taxBeneficiary = document.getElementById("tax-beneficiary");
	let isTaxBeneficiaryOpen = false;
	function showLogin() {
		loginElement.style.display = "block";
	}
	
	function hideLogin() {
		setTimeout(() => {
			loginElement.style.display = "none";
		}, 2000)
	}
	
	function toggleTaxBeneficiary() {
		isTaxBeneficiaryOpen = !isTaxBeneficiaryOpen;
		if(isTaxBeneficiaryOpen) {
			taxBeneficiary.style.display = "grid"; 
		}
		else {
			taxBeneficiary.style.display = "none"; 
		}
	}
	
</script>
</html>
