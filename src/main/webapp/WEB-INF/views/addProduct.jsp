<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%
    if (session.getAttribute("user") == null) {
        // Redirect to login page if session does not contain adminEmail
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }
%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Manage Products</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.10.5/font/bootstrap-icons.css"
	rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<style>
body {
	background-color: #f0f8ff;
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
	padding-bottom: 20px;
}

.nav-link {
	color: #4b6584 !important;
	margin-right: 20px;
	padding-right: 10px;
}

.nav-item {
	margin-top: 20px;
}

.nav-link:hover {
	color: #17a589 !important;
}

.sidebar {
	position: fixed;
	top: 0;
	left: 0;
	width: 250px;
	height: 100%;
	background-color: #fff;
	padding-top: 20px;
	padding-left: 20px;
	color: white;
	box-shadow: 2px 0 5px rgba(0, 0, 0, 0.1);
}

.sidebar .nav-link {
	color: #bbb;
}

.sidebar .nav-link:hover {
	color: #ffffff;
}

.sidebar .navbar-brand {
	color: #ff6f61 !important;
}

.content {
	margin-left: 250px;
	padding: 20px;
	flex: 1;
}

.admin-header {
	margin-top: 20px;
	margin-left: 1px;
	text-align: left;
	font-size: 2rem;
	color: #ff6f61;
	margin-bottom: 50px;
}

.table {
	border-radius: 10px;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
	overflow: hidden;
}

.table th, .table td {
	padding: 15px;
	vertical-align: middle;
}

.btn-ban {
	border-radius: 20px;
	background-color: #dc3545;
	color: #fff;
}

.btn-ban:hover {
	background-color: #c82333;
}

.navbar-text {
	color: #4b6584 !important;
	position: relative;
	top: 20px;
	right: -1130px;
}

.category-card {
	cursor: pointer;
	border: 1px solid #ddd;
	border-radius: 8px;
	overflow: hidden;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}

.category-card:hover {
	border-color: #ff6f61;
}

.category-photo {
	width: 100%;
	height: 200px;
	object-fit: cover;
}

/* Selected category card style */
.category-card.selected {
	border-color: #ff6f61;
	box-shadow: 0 4px 8px rgba(255, 111, 97, 0.4);
	/* Optional, for a glowing effect */
}

.error {
	color: red;
	font-size: 0.9rem;
	margin-top: 10px;
	display: block;
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
</style>
</head>
<body>

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

	<!-- Sidebar -->
	<div class="sidebar">
		<a class="navbar-brand" href="#"><i class="bi bi-shop"></i> Admin
			Dashboard</a>
		<ul class="nav flex-column">
			<li class="nav-item"><a class="nav-link"
				href="${pageContext.request.contextPath}/admin"><i
					class="bi bi-house-door"></i> Dashboard</a></li>
			<li class="nav-item"><a class="nav-link"
				href="${pageContext.request.contextPath}/category"><i
					class="bi bi-list"></i> Manage Categories</a></li>
			<li class="nav-item"><a class="nav-link" href="#"><i
					class="bi bi-box2"></i> Manage Products</a></li>
			<!-- <li class="nav-item"><a class="nav-link" href="#"><i
					class="bi bi-bag-check"></i> Manage Orders</a></li> -->
			<li class="nav-item"><a class="nav-link active"
				href="${pageContext.request.contextPath}/viewUsers"><i
					class="bi bi-people"></i> Manage Users</a></li>
			<li class="nav-item"><a class="nav-link"
				href="javascript:void(0);"
				onclick="confirmLogout('${pageContext.request.contextPath}/logout')"><i
					class="bi bi-box-arrow-right"></i> Logout</a></li>
		</ul>
	</div>

	<c:if test="${not empty sessionScope.user}">
		<span class="navbar-text me-2"> <i class="bi bi-person-circle"></i>
			Admin: ${sessionScope.user.email}
		</span>
	</c:if>

	<!-- Main Content Area -->
	<div class="content">
		<h2 class="admin-header">Manage Products</h2>

		<!-- Add Product Form -->
		<div class="mb-4">

			<form:form modelAttribute="productObj"
				action="${pageContext.request.contextPath}/addProduct" method="POST"
				enctype="multipart/form-data" onsubmit="return validateForm()">

				<!-- Category Selection -->
				<div class="mb-3">
					<label style="margin-bottom: 20px;">Category</label>
					<div class="row">
						<c:forEach var="category" items="${categoryList}">
							<div class="col-md-3">
								<div class="card category-card"
									onclick="setCategoryId(${category.id}, this)">
									<img
										src="${pageContext.request.contextPath}/upload/${category.c_photo}"
										alt="Category Photo" class="category-photo">
									<div class="card-body">
										<h5 class="card-title">${category.c_name}</h5>
									</div>
									<!-- Category Error Message -->


								</div>
								<br> <a
									href="${pageContext.request.contextPath}/viewProducts?c_id=${category.id}"
									class="btn btn-outline-primary btn-lg my-2"> <i
									class="bi bi-box-seam"></i> View Products
								</a> <span class="error" id="category_error"></span>
							</div>
						</c:forEach>
					</div>
				</div>

				<!-- Product Name -->
				<div class="mb-3">
					<h4>Add New Product</h4>
					<label>Product Name</label>
					<div class="mb-3 input-group">
						<span class="input-group-text"><i class="bi bi-tags"></i></span>
						<form:input path="p_name" type="text" class="form-control"
							placeholder="Enter product name" />

					</div>
					<span class="error" id="p_name_error"></span>
				</div>

				<!-- Product Description -->
				<div class="mb-3">
					<label>Description</label>
					<div class="mb-3 input-group">
						<span class="input-group-text"><i
							class="bi bi-file-earmark-text"></i></span>
						<!-- Description Icon -->
						<form:textarea path="description" class="form-control"
							placeholder="Enter description" />
					</div>
					<span class="error" id="description_error"></span>
				</div>

				<!-- Product Price -->
				<div class="mb-3">
					<label>Price</label>
					<div class="mb-3 input-group">
						<span class="input-group-text"><i
							class="bi bi-currency-dollar"></i></span>
						<!-- Price Icon -->
						<form:input path="price" type="number" class="form-control"
							placeholder="Enter price" />
					</div>
					<span class="error" id="price_error"></span>
				</div>


				<!-- Product Quantity -->
				<div class="mb-3">
					<label>Quantity</label>
					<div class="mb-3 input-group">
						<span class="input-group-text"><i class="bi bi-box"></i></span>
						<!-- Quantity Icon -->
						<form:input path="quantity" type="number" class="form-control"
							placeholder="Enter quantity" />
					</div>
					<span class="error" id="quantity_error"></span>
				</div>


				<!-- Product Image Upload -->
				<div class="mb-3 input-group" style="width: 148px;">
					<span class="input-group-text"><i class="bi bi-camera-fill"></i></span>
					<form:input path="photo" type="file" class="form-control" />
					<span class="error" id="photo_error"></span>
				</div>

				<!-- Hidden Category ID Field -->
				<form:hidden path="c_id" id="categoryId" />

				<button type="submit" class="btn btn-primary">
					<i class="bi bi-plus-circle"></i> Add Product
				</button>
			</form:form>
		</div>

		<!-- Validation Script -->
		<script>
        function validateForm() {
            let isValid = true;
            clearErrors(); // Clear previous errors
            
         // Validate category selection
            const categoryId = document.getElementById("categoryId").value;
            if (!categoryId) {
                document.getElementById("category_error").textContent = "Please select a category.";
                isValid = false;
            }

            
            // Validate product name
            const productName = document.querySelector("[name='p_name']").value;
            if (!productName) {
                document.getElementById("p_name_error").textContent = "Product name is required.";
                isValid = false;
            }
            
            // Validate description
            const description = document.querySelector("[name='description']").value;
            if (!description) {
                document.getElementById("description_error").textContent = "Description is required.";
                isValid = false;
            }
            
            // Validate price
            const price = document.querySelector("[name='price']").value;
            if (!price || price <= 0) {
                document.getElementById("price_error").textContent = "Valid price is required.";
                isValid = false;
            }
            
         // Validate quantity
            const quantity = document.querySelector("[name='quantity']").value;
            if (!quantity || quantity <= 0) {
                document.getElementById("quantity_error").textContent = "Valid quantity is required.";
                isValid = false;
            }

            
            // Validate file upload
            const fileInput = document.querySelector("[name='photo']");
            if (!fileInput.files.length) {
                document.getElementById("photo_error").textContent = "Please upload a product image.";
                isValid = false;
            }

            return isValid;
        }
        
        function clearErrors() {
            const errorElements = document.querySelectorAll(".error");
            errorElements.forEach(element => element.textContent = "");
        }
        
        

        function setCategoryId(categoryId, element) {
            // Set the selected category ID in the hidden input
            document.getElementById("categoryId").value = categoryId;

            // Toggle the selected class for category card
            const categoryCards = document.querySelectorAll('.category-card');
            categoryCards.forEach(card => card.classList.remove('selected'));

            element.classList.add('selected');
        }
        
        
        function confirmLogout(url) {
            Swal.fire({
                title: 'Are you sure you want to logout?',
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
	</div>
</body>
</html>
