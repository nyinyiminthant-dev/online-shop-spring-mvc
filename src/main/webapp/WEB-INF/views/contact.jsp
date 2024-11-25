<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Contact</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <style>
        body {
            background-color: #f0f8ff;
            color: #212529;
        }

        .navbar {
            background-color: #ffffff;
            padding: 10px 20px;
            border-radius: 10px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        .about {
            width: 100%;
            height: 510px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1), 0 8px 24px rgba(0, 0, 0, 0.1);
            border-radius: 10px;
            background: url('${pageContext.request.contextPath}/resources/img/p9bg.jpg') no-repeat center center fixed;
            background-size: cover;
            margin-top: 47px;
           
        }
        
        .container {
           padding-top: 20px;
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
            position: relative;
            display: inline-block;
            text-decoration: none;
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
        
        .btn-logout {
            color: #dc3545; 
            border-color: #dc3545;
            border-radius: 30px;
        }

        .btn-logout:hover {
            background-color: #ff6f61;
            color: #ffffff; 
            border-color: #ff6f61;
        }
    </style>
</head>
<body>

<!-- Success Message -->
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

<script>
    function confirmLogout(url) {
        Swal.fire({
            title: 'Are you sure?',
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: 'Yes, Logout!'
        }).then((result) => {
            if (result.isConfirmed) {
                window.location.href = url;
            }
        });
    }
</script>

<!-- Navbar -->
<nav class="navbar navbar-expand-lg">
    <div class="container-fluid">
        <a class="navbar-brand" href="#"><i class="bi bi-shop"></i> Online Shop</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon bg-light"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item">
                    <a class="nav-link active" href="${pageContext.request.contextPath}/"><i class="bi bi-house-door"></i> Home</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/about"><i class="bi bi-info-circle"></i> About</a>
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
                <span class="navbar-text me-2 email"><i class="bi bi-person-circle"></i> ${sessionScope.user.email}</span>
                <button class="btn btn-outline-primary btn-logout" onclick="confirmLogout('${pageContext.request.contextPath}/logout')">
                    <i class="bi bi-box-arrow-right"></i> Logout
                </button>
            </c:if>
            <c:if test="${empty sessionScope.user}">
                <a href="${pageContext.request.contextPath}/login">
                    <button class="btn btn_login"><i class="bi bi-box-arrow-in-right"></i> Login</button>
                </a>
            </c:if>
        </div>
    </div>
</nav>

<!-- About Section -->
<div class="about">

<!-- Contact Section -->
<section class="container mt-5 mb-5">
    <h2>Contact Us</h2>
    <p>If you have any questions or need support, feel free to reach out to us.</p>
    <form action="${pageContext.request.contextPath}/sendContact" method="post">
        <div class="mb-3">
            <label for="name" class="form-label">Your Name</label>
            <input type="text" class="form-control" id="name" name="name" required>
        </div>
        <div class="mb-3">
            <label for="email" class="form-label">Your Email</label>
            <input type="email" class="form-control" id="email" name="email" required>
        </div>
        <div class="mb-3">
            <label for="message" class="form-label">Message</label>
            <textarea class="form-control" id="message" name="message" rows="4" required></textarea>
        </div>
        <button type="submit" class="btn btn-primary">Send Message</button>
    </form>
</section>

</div>
<!-- Footer -->
<footer class="container text-center mt-5 py-4">
    <p>&copy; 2024 Online Shop. All Rights Reserved.</p>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
</body>
</html>
