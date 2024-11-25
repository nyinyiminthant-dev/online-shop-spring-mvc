<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Login</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    <!-- SweetAlert2 Library -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <style>
        body {
            background-color: #f0f8ff;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin-top: 70px; /* Ensure content doesn't hide behind fixed navbar */
        }
        
        
          .navbar {
            background-color: #ffffff;
            padding: 10px 20px;
            border-radius: 10px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
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

        .navbar {
            background-color: #ffffff;
            padding: 10px 20px;
            border-radius: 10px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            position: fixed; /* Make navbar fixed at the top */
            width: 100%;
            top: 0;
            z-index: 1000; /* Make sure navbar stays on top */
        }
        .navbar-brand {
            font-weight: bold;
            color: #ff6f61 !important;
        }
        .nav-link {
            color: #4b6584 !important;
            font-size: 1.1rem;
            margin-right: 15px;
            transition: color 0.3s;
        }
        .nav-link:hover {
            color: #17a589 !important;
        }
        .btn-outline-primary {
            color: #007bff;
            border-color: #007bff;
        }
        .btn-outline-primary:hover {
            background-color: #007bff;
            color: #ffffff;
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





<!-- Display Success Message -->
<c:if test="${not empty successMessage}">
    <script>
        Swal.fire({
            icon: 'success',
            title: 'Success!',
            text: '${successMessage}',
            showConfirmButton: false,
            timer: 2000,
            timerProgressBar: true
        });
    </script>
</c:if>

<!-- Display Success Message -->
<c:if test="${not empty successMessage}">
    <script>
        Swal.fire({
            icon: 'success',
            title: 'Success!',
            text: '${successMessage}',
            showConfirmButton: false,
            timer: 2000,
            timerProgressBar: true
        });
    </script>
</c:if>

<c:if test="${not empty winningMessage}">
    <script>
        Swal.fire({
             // Dynamically set icon
           
            text: '${winningMessage}',
            showConfirmButton: false,
            timer: 2000,
            timerProgressBar: true
        });
    </script>
</c:if>

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
    <form:form modelAttribute="userObj" action="${pageContext.request.contextPath}/bdologin" method="post" id="loginForm">

        <h1>Login</h1>

       <!-- Email Field -->
<div class="mb-3">
    <label for="email" class="form-label">Email Address</label>
    <form:input path="email" class="form-control" placeholder="Enter Email" type="email" id="email"/>
           <span id="emailError" class="error"></span>
        
    <!-- Display email error -->
    <c:if test="${not empty emailError}">
        <span class="error">${emailError}</span>
    </c:if>
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
            <c:if test="${not empty passwordError}">
                <span class="error">${passwordError}</span>
            </c:if>
        </div>


        <!-- Submit Button -->
        <div class="mb-3">
            <input type="submit" value="Login" class="btn btn-primary">
        </div>

        <!-- Optional Note -->
        <div class="text-center">
            <small class="text-muted">Don't have an account? <a href="${pageContext.request.contextPath}/register">Register here</a>.</small>
        </div>
    </form:form>
</div>

<!-- Bootstrap JS Link (Optional) -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>

<!-- JavaScript Validation -->
<script>
    document.getElementById("loginForm").addEventListener("submit", function(event) {
        // Get input values
        const email = document.getElementById("email").value.trim();
        const password = document.getElementById("password").value.trim();

        // Error message elements
        const emailError = document.getElementById("emailError");
        const passwordError = document.getElementById("passwordError");

        // Reset error messages
        emailError.textContent = "";
        passwordError.textContent = "";

        let isValid = true;

        // Check if email is empty
        if (email === "") {
            emailError.textContent = "Email is required.";
            isValid = false;
        } else {
            // Validate email format
            const emailPattern = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6}$/;
            if (!emailPattern.test(email)) {
                emailError.textContent = "Invalid email format.";
                isValid = false;
            }
        }

        // Check if password is empty
        if (password === "") {
            passwordError.textContent = "Password is required.";
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
