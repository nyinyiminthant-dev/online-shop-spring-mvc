<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User View - Shop</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
   <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
   
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <style>
        body {
            background-color: #f0f8ff;
            font-family: Arial, sans-serif;
            
        }

    .navbar {
    background-color: #ffffff;
    padding: 10px 20px;
    border-radius: 10px;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
    position: fixed;
    top: 0;
    width: 100%;
    z-index: 1030; /* Ensures it appears above other elements */
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


        .content {
        margin-top: 60px;
            margin-left: 280px;
            padding: 20px;
        }

        .category-card.selected {
            border: 2px solid #ff6f61;
           
        }

        .category-card {
            border: 1px solid #ddd;
            border-radius: 10px;
            cursor: pointer;
            overflow: hidden;
        }

        .category-card:hover {
            box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.2);
        }

        .category-photo {
            width: 100%;
            height: 210px;
           /*  object-fit: cover; */
            display: flex;
    justify-content: center; /* Centers the image horizontally */
    align-items: center;
            border-bottom: 1px solid #ddd;
        }

        .card-body {
            text-align: center;
            padding: 15px;
        }

        .card-body h5 {
            font-size: 1.2rem;
            color: #333;
        }

        .btn-outline-primary {
            border-radius: 20px;
            padding: 10px 20px;
            font-weight: bold;
        }

        .btn-outline-primary:hover {
            background-color: #17a589;
            color: white;
            border-color: #17a589;
        }

        .category-card a {
            text-decoration: none;
            display: inline-block;
            margin-top: 10px;
            
        }

      .sidebar {
    overflow-y: auto; /* Vertical scroll bar for overflow */
    overflow-x: hidden; /* Prevent horizontal overflow */
    background-color: #f8f9fa;
    padding: 20px;
    border-radius: 10px;
    box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
    position: fixed;
    top: 80px;
    left: 0;
    width: 250px;
    height: calc(100vh - 80px);
}


        .sidebar   .category-item a {
            display: block;
            margin-bottom: 10px;
            color: #444;
            text-decoration: none;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
            transition: all 0.3s ease;
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

    <!-- Success and Error Message Handling -->
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

    <c:if test="${not empty error}">
        <script>
            Swal.fire({
                icon: 'error',
                title: 'Error!',
                text: '${error}',
                showConfirmButton: true,
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
                <span class="navbar-text me-2 email">
                   <i class="bi bi-person-circle"></i> ${sessionScope.user.email}
                </span>
                <a href="javascript:void(0);" onclick="confirmLogout('${pageContext.request.contextPath}/logout')" >
                    <button class="btn  btn-logout" type="button"><i class="bi bi-box-arrow-right"></i> Logout</button>
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


    <!-- Main Content Area -->
    <div class="d-flex">
        <!-- Sidebar -->
        <div class="sidebar">
            <h3>Categories</h3>
            <div class="category-list">
               <c:forEach var="category" items="${categoryList}">
    <div class="category-item">
        <!-- Link to view products based on selected category -->
        <a href="${pageContext.request.contextPath}/viewProductsuser?c_id=${category.id}" class="btn btn-outline-primary w-100">
            ${category.c_name}
        </a>
    </div>
</c:forEach>

            </div>
        </div>



        <!-- Products Display base on category Area -->
        <div class="col-md-9 content">
        		<!-- Cart Icon with Dynamic Count -->
<a class="cart-icon position-fixed end-0 me-5 mt-3"
    href="${pageContext.request.contextPath}/cart"
    style="z-index: 1000; margin-right: 10px;">
    <i class="bi bi-cart2 fs-4 text-dark"></i>
    <span id="cart-count" class="badge rounded-pill bg-danger position-absolute top-0 start-100 translate-middle">
        0
    </span>
</a>
            <h2 class="admin-header text-center"><i class="bi bi-shop-window"></i> Shopping</h2>
            <c:if test="${not empty productList}">
                <div class="row">
                    <c:forEach var="product" items="${productList}">
                        <div class="col-md-6 col-lg-4 col-xl-3 mb-4">
                            <div class="card h-100">
                                <img src="${pageContext.request.contextPath}/upload/${product.p_photo}" 
                                     alt="Product Photo" class="category-photo img-fluid">
                                <div class="card-body">
                                    <h5 class="card-title">${product.p_name}</h5>
                                    <p class="card-text">$${product.price}: MMK</p>
                                    <button type="button" class="btn btn-primary" 
                                        onclick="addToCart('${product.id}', '${product.p_name}', '${product.p_photo}', '${product.price}', '${product.description}')">
                                        <i class="bi bi-cart-plus"></i> Add to Cart
                                    </button>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:if>
            <c:if test="${empty productList}">
                <p>No products available.</p>
            </c:if>
        </div>
    </div>
</body>


<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

	


	
<script>
    // Function to update the cart count badge
    function updateCartCount() {
        const cartItems = JSON.parse(localStorage.getItem('cartItems')) || [];
        /* document.getElementById('cart-count').textContent = cartItems.length; */
        const totalQuantity = cartItems.reduce((total, item) => total + item.quantity, 0);
        document.getElementById('cart-count').textContent = totalQuantity;
    }

    // Call updateCartCount on page load
    document.addEventListener('DOMContentLoaded', updateCartCount);

    // Function to handle adding to cart
    function addToCart(productId, productName, productPhoto, productPrice, productDescription) {
        // Retrieve the current cart items from local storage
        let cartItems = JSON.parse(localStorage.getItem('cartItems')) || [];

        // Check if the product already exists in the cart
        let existingProduct = cartItems.find(item => item.id === productId);

        if (existingProduct) {
            // If the product already exists, increase the quantity
            existingProduct.quantity += 1;
        } else {
            // Create a new product object
            const product = {
                id: productId,
                name: productName,
                photo: productPhoto,
                price: productPrice,
                description: productDescription,
                quantity: 1
            };

            // Add the product to the cart items array
            cartItems.push(product);
        }

        // Save the updated cart items array to local storage
        localStorage.setItem('cartItems', JSON.stringify(cartItems));

        // Update the cart count display
        updateCartCount();

        // Optional: Show a confirmation message
      
    }
    
    
    console.log(localStorage.getItem('cartItems'));

</script>



</html>
