<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Product Catalog</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.10.5/font/bootstrap-icons.css"
	rel="stylesheet">
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

.product-card {
	border: 1px solid #ddd;
	border-radius: 8px;
	padding: 15px;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
	margin-bottom: 20px;
	text-align: center;
}

.product-card img {
	width: 100%;
	height: 200px;
	object-fit: cover;
}

.product-card h5 {
	font-size: 1.25rem;
	margin-top: 10px;
}

.product-card .btn {
	margin-top: 10px;
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
			<a class="navbar-brand" href="#"><i class="bi bi-shop"></i>
				Online Shop</a>
			<button class="navbar-toggler" type="button"
				data-bs-toggle="collapse" data-bs-target="#navbarNav"
				aria-controls="navbarNav" aria-expanded="false"
				aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="navbarNav">
				<ul class="navbar-nav ms-auto mb-2 mb-lg-0">
					<li class="nav-item"><a class="nav-link active"
						href="${pageContext.request.contextPath}/"><i
							class="bi bi-house-door"></i> Home</a></li>
					<li class="nav-item"><a class="nav-link" href="#"><i
							class="bi bi-info-circle"></i> About</a></li>
					<li class="nav-item"><a class="nav-link" href="#"><i
							class="bi bi-bag"></i> Shop</a></li>
					<li class="nav-item"><a class="nav-link" href="#"><i
							class="bi bi-telephone"></i> Contact</a></li>
				</ul>

				<!-- User Login/Logout -->
				<c:if test="${not empty sessionScope.user}">
					<span class="navbar-text me-2 email"> <i
						class="bi bi-person-circle"></i> ${sessionScope.user.email}
					</span>
					<a href="javascript:void(0);"
						onclick="confirmLogout('${pageContext.request.contextPath}/logout')">
						<button class="btn btn-outline-primary btn-logout" type="button">
							<i class="bi bi-box-arrow-right"></i> Logout
						</button>
					</a>
				</c:if>
				<c:if test="${empty sessionScope.user}">
					<a href="${pageContext.request.contextPath}/login">
						<button class="btn btn_login" type="button">
							<i class="bi bi-box-arrow-in-right"></i> Login
						</button>
					</a>
				</c:if>
			</div>
		</div>
	</nav>
	<div class="container">
		<div class="text-center my-4">
			<h1 style="color: #ff6f61;">
				<i class="bi bi-card-list me-2" style="color: #ff6f61;"></i>Product
				Catalog
			</h1>
		</div>



		<!-- Cart Icon with Dynamic Count -->
<a class="cart-icon position-fixed end-0 me-5 mt-3"
    href="${pageContext.request.contextPath}/cart"
    style="z-index: 1000; margin-right: 10px;">
    <i class="bi bi-cart2 fs-4 text-dark"></i>
    <span id="cart-count" class="badge rounded-pill bg-danger position-absolute top-0 start-100 translate-middle">
        0
    </span>
</a>







		<div class="text-center my-4">
			<a href="${pageContext.request.contextPath}/shop">
				<button class="btn btn-secondary">
					<i class="bi bi-arrow-left-circle"></i> Back to Category
				</button>
			</a>
		</div>

		<!-- Display Success/Error Message -->
		<c:if test="${not empty successMessage}">
			<div class="alert alert-success">
				<strong>Success!</strong> ${successMessage}
			</div>
		</c:if>
		<c:if test="${not empty errorMessage}">
			<div class="alert alert-danger">
				<strong>Error!</strong> ${errorMessage}
			</div>
		</c:if>

		<!-- Product Listing -->
		<div class="row">
			<c:forEach var="product" items="${productList}">
				<div class="col-md-3">
					<div class="card product-card">
						<!-- Check if the product has a valid photo -->
						<img
							src="${pageContext.request.contextPath}/upload/${product.p_photo}"
							alt="${product.p_name}" class="product-img">
						<h5>${product.p_name}</h5>
						<p>${product.description}</p>
						<p>
							<strong>$${product.price} : MMK</strong>
						</p>

						<!-- Add to Cart Form -->
						<form action="${pageContext.request.contextPath}/addToCart"
							method="POST">
							<input type="hidden" name="id" value="${product.id}" /> <input
								type="hidden" name="p_name" value="${product.p_name}" /> <input
								type="hidden" name="price" value="${product.price}" />
<input type="hidden" name="c_id" value="${product.c_id}" />



			<button type="button" class="btn btn-primary" 
    onclick="addToCart('${product.id}', '${product.p_name}', '${product.p_photo}', '${product.price}', '${product.description}')">
    <i class="bi bi-cart-plus"></i> Add to Cart
</button>


						</form>
					</div>
				</div>
			</c:forEach>

		</div>
	</div>

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


	

</body>
</html>
