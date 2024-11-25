<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Registration</title>

    <!-- Bootstrap CSS Link -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        body {
            background-color: #f0f8ff;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .form-container {
            background-color: #ffffff;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.1);
            max-width: 400px;
            width: 100%;
        }
        h1 {
            text-align: center;
            margin-bottom: 20px;
            color: #ff6f61;
        }
        label {
            color: #4b6584;
        }
        .error {
            color: #e74c3c;
            font-size: 0.9em;
            margin-top: 5px;
        }
        .btn-primary {
            background-color: #20c997;
            border-color: #20c997;
            width: 100%;
        }
        .btn-primary:hover {
            background-color: #17a589;
        }
        .text-muted a {
            color: #1e90ff;
            text-decoration: none;
        }
        .text-muted a:hover {
            color: #007bff;
        }
        
        .error{
          color:red;
        }
        
        
        
         /* Updated Navbar CSS */
.navbar {
    background-color: #ffffff;
    padding: 10px 20px;
    border-radius: 10px;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
    position: fixed;
    top: 0;
    left: 0;
    right: 0;
    z-index: 1000;
}

/* Adjust content margin to avoid overlap with fixed navbar */
body {
    padding-top: 80px; /* Adjust this value if needed */
}


        .navbar-brand {
            font-weight: bold;
            color: #ff6f61 !important;
        }

        .nav-link {
            color: #4b6584 !important;
            font-size: 1.1rem;
            margin-right: 15px;
            text-decoration: none;
            position: relative;
            display: inline-block;
            transition: color 0.3s, transform 0.3s;
        }

        .nav-link::after {
            content: '';
            position: absolute;
            width: 0;
            height: 2px;
            bottom: 0;
            left: 0;
            background-color: #17a589;
            transition: width 0.3s ease-in-out;
        }

        .nav-link:hover {
            color: #17a589 !important;
        }


        .nav-link:hover::after {
            width: 100%;
        }
        
        
        
         .btn_login {
            background-color: transparent;
            border: none; /* Same border color as nav-link */
            border-radius: 30px;
            color: #4b6584; /* Match the color of nav-link */
            padding: 5px 20px; /* Adjust padding as needed */
            font-size: 1.1rem;
            position: relative;
            text-decoration: none;
            transition: color 0.3s, transform 0.3s;
        }
        

        .btn_login::after {
            content: '';
            position: absolute;
            width: 0;
            height: 2px;
            bottom: 0;
            left: 0;
            background-color: #17a589; /* The hover color for nav-link */
            transition: width 0.3s ease-in-out;
        }

        .btn_login:hover {
            color: #17a589; /* Hover color like nav-link */
            transform: translateY(-2px); /* Add slight upward movement on hover */
        }

        .btn_login:hover::after {
            width: 100%;
        }
        
        

        
    </style>
</head>
<body>



<!-- Navbar -->
<nav class="navbar navbar-expand-lg">
    <div class="container-fluid">
        <a class="navbar-brand" href="#"><i class="bi bi-shop"></i> Online Shop</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto mb-2 mb-lg-0">
             <li class="nav-item">
                    <a class="nav-link active" href="${pageContext.request.contextPath}/"><i class="bi bi-house-door"></i> Home</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#"><i class="bi bi-info-circle"></i> About</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/shop"><i class="bi bi-bag"></i> Shop</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/contact"><i class="bi bi-telephone"></i> Contact</a>
                </li>
            </ul>

            <!-- User Login/Logout -->
            <c:if test="${not empty sessionScope.user}">
                <span class="navbar-text me-2 email">
                   <i class="bi bi-person-circle"></i> ${sessionScope.user.email}
                </span>
                <a href="javascript:void(0);" onclick="confirmLogout('${pageContext.request.contextPath}/logout')" >
                    <button class="btn btn-outline-primary btn-logout" type="button"><i class="bi bi-box-arrow-right"></i> Logout</button>
                </a>
            </c:if>
            <c:if test="${empty sessionScope.user}">
                <a href="${pageContext.request.contextPath}/login">
                    <button class="btn btn_login" type="button"><i class="bi bi-box-arrow-in-right"></i> Login</button>
                </a>
            </c:if>
        </div>
    </div>
</nav>

    <div class="form-container">
       <form:form modelAttribute="userObj" action="${pageContext.request.contextPath}/register" method="post" id="registrationForm">

            <h1>Registration</h1>
<p class="error">${errorMessage}</p> <!-- This is for testing purpose -->

            <!-- Email Field -->
            <div class="mb-3">
                <label for="email" class="form-label">Email Address</label>
                <form:input path="email" class="form-control" placeholder="Enter Email" type="email" id="email"/>
                <span id="emailError" class="error"></span>
            </div>

           <!-- Password Field -->
        <div class="mb-3">
            <label for="password" class="form-label">Password</label>
            <div class="input-group">
                <form:input path="password" class="form-control" placeholder="Enter Password" type="password" id="password"/>
                <button type="button" class="btn btn-outline-secondary" id="togglePassword">
                    <i class="bi bi-eye-slash" id="eyeIcon"></i>
                </button>
            </div>
            <span id="passwordError" class="error"></span>
            
        </div>

            <!-- Confirm Password Field -->
            <div class="mb-3">
                <label for="confirmPassword" class="form-label">Confirm Password</label>
                <form:input path="confirmPassword" class="form-control" placeholder="Confirm Password" type="password" id="confirmPassword"/>
                <span id="confirmPasswordError" class="error"></span>
            </div>

            <!-- Submit Button -->
            <div class="mb-3">
                <input type="submit" value="Register" class="btn btn-primary">
            </div>

            <!-- Optional Note -->
            <div class="text-center">
                <small class="text-muted">Already have an account? <a href="${pageContext.request.contextPath}/login">Login here</a>.</small>
            </div>
        </form:form>
    </div>

    <!-- Bootstrap JS Link (Optional) -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>

    <!-- JavaScript Validation -->
    <script>
        document.getElementById("registrationForm").addEventListener("submit", function(event) {
            // Get input values
            const email = document.getElementById("email").value.trim();
            const password = document.getElementById("password").value.trim();
            const confirmPassword = document.getElementById("confirmPassword").value.trim();

            // Error message elements
            const emailError = document.getElementById("emailError");
            const passwordError = document.getElementById("passwordError");
            const confirmPasswordError = document.getElementById("confirmPasswordError");

            // Reset error messages
            emailError.textContent = "";
            passwordError.textContent = "";
            confirmPasswordError.textContent = "";

            let isValid = true;

            // Check if email is empty
            if (email === "") {
                emailError.textContent = "Email is required.";
                isValid = false;
            }

            // Check if password is empty
            if (password === "") {
                passwordError.textContent = "Password is required.";
                isValid = false;
            }

            // Check if confirm password is empty
            if (confirmPassword === "") {
                confirmPasswordError.textContent = "Please confirm your password.";
                isValid = false;
            }

            // Check if passwords match
            if (password !== "" && confirmPassword !== "" && password !== confirmPassword) {
                confirmPasswordError.textContent = "Passwords do not match.";
                isValid = false;
            }

            // Prevent form submission if there are errors
            if (!isValid) {
                event.preventDefault();
            }
        });
    </script>
    
    
    
    
    <!-- JavaScript for Password Visibility Toggle -->
<script>
    document.getElementById('togglePassword').addEventListener('click', function () {
        const passwordField = document.getElementById('password');
        const eyeIcon = document.getElementById('eyeIcon');

        if (passwordField.type === 'password') {
            passwordField.type = 'text';
            eyeIcon.classList.remove('bi-eye-slash');
            eyeIcon.classList.add('bi-eye');
        } else {
            passwordField.type = 'password';
            eyeIcon.classList.remove('bi-eye');
            eyeIcon.classList.add('bi-eye-slash');
        }
    });
</script>
</body>
</html>
