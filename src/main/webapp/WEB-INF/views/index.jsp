<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Online Shop</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
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

        .btn-outline-primary {
            color: #007bff;
            border-color: #007bff;
        }
        .btn-outline-primary:hover {
            background-color: #007bff;
            color: #ffffff;
        }
        .form-control {
            background-color: #ffffff;
            color: #212529;
            border: 2px solid #1e90ff;
            max-width: 300px; 
            height: 60px;
            padding-left: 20px;
        }
        .form-control:focus {
            border-color: #007bff;
            box-shadow: 0 0 5px rgba(0, 123, 255, 0.5);
        }
        .btn-primary {
            background-color: #20c997;
            border-color: #20c997;
            border-radius: 30px;
        }
        .btn-primary:hover {
            background-color: #17a589;
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

        
       

        .navbar .form-inline {
            display: flex;
            justify-content: center;
            align-items: center;
        }
        .email {
            background-color: transparent;
            padding: 5px 10px;
            border-radius: 10px;
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
        
        
        
        
        /*for pages  */
 .home {
    width: 100%;
    height: 510px;
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1), 0 8px 24px rgba(0, 0, 0, 0.1);
    border-radius: 10px;
   background: url('${pageContext.request.contextPath}/resources/img/p9bg.jpg') no-repeat center center fixed;
        background-size: cover;
    background-position: center;
    background-repeat: no-repeat;
}



.home_text {
  position: relative;
  top: 230px;
  left: 40px;	
}

.about,.shop{
      width: 100%;
      height: 700px;
       box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1), 0 8px 24px rgba(0, 0, 0, 0.1);
    border-radius: 10px;
}


.bg-img {
   width: 300px;
   position: relative;
   bottom: 100px;
   right: -800px;
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
            timerProgressBar: true,
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
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto mb-2 mb-lg-0">
                <li class="nav-item">
                    <a class="nav-link active" href="#"><i class="bi bi-house-door"></i> Home</a>
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




<!-- Home Section -->
<div class="home">
<section class="container mt-5">

    <div class="home_text">
        <h1>Welcome to Our Online Shop!</h1>
        <p>Your one-stop destination for the best quality products at unbeatable prices.</p>
        <a href="${pageContext.request.contextPath}/shop" class="btn btn-primary">
            <i class="bi bi-cart-plus"></i> Start Shopping
        </a>
    </div>
    
    <img alt="" src="${pageContext.request.contextPath}/upload/model.png" class="bg-img">
   
</section>
 </div>



<!-- Footer -->
<footer class="container mt-5 mb-5 text-center">
    <p>&copy; 2024 Online Shop. All rights reserved.</p>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-pzjw8f+ua7Kw1TIq0G8ZxvKHQ5nt0Vz/9BOwWjYtuZtM4KzpFWFCXi5vQdVuzw12" crossorigin="anonymous"></script>
</body>
</html>
