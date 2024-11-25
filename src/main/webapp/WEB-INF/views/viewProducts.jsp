<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
    if (session.getAttribute("user") == null) {
        // Redirect to login page if session does not contain adminEmail
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Products by Category</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
	 <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.10.5/font/bootstrap-icons.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<style>
body {
	background-color: #f4f6f9;
	color: #495057;
	font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
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
        margin-top:20px;}
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

.product-img, .category-img {
	width: 120px;
	height: 120px;
	object-fit: cover;
	border-radius: 8px;
}

.category-img {
	width: 130px;
}


.table {
	border-radius: 12px;
	box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
	background-color: #fff;
}

.table thead {
	background: linear-gradient(90deg, #f78f1e, #ff6f61);
	color: white;
}

.table th, .table td {
	padding: 15px;
	vertical-align: middle;
}

.table-hover tbody tr:hover {
	background-color: #ffe5d9;
}

.table-striped tbody tr:nth-of-type(odd) {
	background-color: #fdf2e9;
}

.btn-outline-primary {
	background-color: #f78f1e;
	color: white;
	border-color: #f78f1e;
}

.btn-outline-primary:hover {
	background-color: #e17b15;
	border-color: #e17b15;
}

.btn-sm {
	border-radius: 20px;
}

.text-center {
	font-weight: bold;
	color: #ff6f61 !important;
}

.category-header {
	display: flex;
	align-items: center;
	gap: 20px;
	background-color: #ffffff;
	padding: 10px;
	border-radius: 8px;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}

.category-header img {
	border: 2px solid #ddd;
	border-radius: 8px;
	overflow: hidden;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}

.category-header span {
	font-size: 1.5rem;
	font-weight: bold;
	color: #333;
}


.container {

  margin-left: 204px;
            padding: 60px;
            flex: 1;
}
</style>
</head>
<body>



<!-- Sidebar -->
<div class="sidebar">
    <a class="navbar-brand" href="#"><i class="bi bi-shop"></i> Admin Dashboard</a>
    <ul class="nav flex-column">
        <li class="nav-item">
            <a class="nav-link" href="${pageContext.request.contextPath}/admin"><i class="bi bi-house-door"></i> Dashboard</a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="${pageContext.request.contextPath}/category"><i class="bi bi-list"></i> Manage Categories</a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="${pageContext.request.contextPath}/product"><i class="bi bi-box2"></i> Manage Products</a>
        </li>
       <!--  <li class="nav-item">
            <a class="nav-link" href="#"><i class="bi bi-bag-check"></i> Manage Orders</a>
        </li> -->
        <li class="nav-item">
            <a class="nav-link active" href="${pageContext.request.contextPath}/viewUsers"><i class="bi bi-people"></i> Manage Users</a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="javascript:void(0);" onclick="confirmLogout('${pageContext.request.contextPath}/logout')"><i class="bi bi-box-arrow-right"></i> Logout</a>
        </li>
    </ul>
</div>




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


	<div class="container">
		<h2 class="my-4 text-center">Products</h2>

		<!-- Display selected category -->
		<c:if test="${not empty selectedCategory}">
			<div class="alert alert-info category-header">
				<strong>Category: </strong> <img
					src="${pageContext.request.contextPath}/upload/${selectedCategory.c_photo}"
					alt="${selectedCategory.c_name}" class="category-img"> <span>${selectedCategory.c_name}</span>
			</div>
		</c:if>

		<!-- Display message if no products are found -->
		<c:if test="${empty productList}">
			<div class="alert alert-info">No products found for this
				category.</div>
		</c:if>

		<!-- Table for displaying products -->
		<c:if test="${not empty productList}">
			<table class="table table-bordered table-hover table-striped mt-4">
				<thead>
					<tr>
						<th>No</th>
						<th>Product Image</th>
						<th>Product Name</th>
						<th>Description</th>
						<th>Quantity</th>
						<th>Price (MMK)</th>
						<th>Actions</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="product" items="${productList}" varStatus="count">
						<tr>
							<td>${count.count}</td>
							<td><img
								src="${pageContext.request.contextPath}/upload/${product.p_photo}"
								alt="${product.p_name}" class="product-img"></td>
							<td>${product.p_name}</td>
							<td>${product.description}</td>
							<td>${product.quantity}</td>
							<td>${product.price}MMK</td>
							<td>
								<div class="d-flex gap-2">
									<!-- Edit Button -->
									<a
										href="${pageContext.request.contextPath}/editProduct/${product.id}"
										class="btn btn-warning btn-sm"> <i
										class="bi bi-pencil-square"></i> Edit
									</a>
									<!-- Delete Button -->
									<form
										action="${pageContext.request.contextPath}/deleteProduct/${product.id}"
										method="get" style="display: inline;">
										<input type="hidden" name="id" value="${product.id}">
										<input type="hidden" name="c_id" value="${product.c_id}">

										<!-- Delete Button -->
										<button type="button" class="btn btn-danger btn-sm"
											onclick="confirmDelete('${pageContext.request.contextPath}/deleteProduct/${product.id}?id=${product.id}&c_id=${product.c_id}')">
											<i class="bi bi-trash"></i> Delete
										</button>

									</form>
								</div>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</c:if>

		<!-- Back button to return to the category page -->
		<a href="${pageContext.request.contextPath}/product"
			class="btn btn-warning mt-4">Back</a>
	</div>

	<!-- Bootstrap JS (optional) -->
	<script type="text/javascript">
function confirmDelete(url) {
    Swal.fire({
        title: 'Are you sure?',
        text: "You won't be able to revert this!",
        icon: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#3085d6',
        cancelButtonColor: '#d33',
        confirmButtonText: 'Yes, delete it!',
        cancelButtonText: 'No, keep it'
    }).then((result) => {
        if (result.isConfirmed) {
            window.location.href = url;
        } else {
            Swal.fire({
                icon: 'info',
                title: 'Cancelled',
                text: 'Your product is safe!',
                showConfirmButton: false,
                timer: 1500
            });
        }
    });
}
</script>

</body>
</html>
