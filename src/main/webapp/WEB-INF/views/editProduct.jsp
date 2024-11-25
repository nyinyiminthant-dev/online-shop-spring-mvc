<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
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
    <title>Edit Product</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
       <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        body {
            background-color: #f4f6f9;
            color: #495057;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        .form-container {
            max-width: 600px;
            margin: 40px auto;
            padding: 20px;
            border-radius: 12px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            background-color: #fff;
        }

        .form-label {
            font-weight: bold;
        }

        .product-img-preview {
            width: 120px;
            height: 120px;
            object-fit: cover;
            border-radius: 8px;
            margin-bottom: 15px;
        }

        .btn-primary {
            background-color: #f78f1e;
            border-color: #f78f1e;
        }

        .btn-primary:hover {
            background-color: #e17b15;
            border-color: #e17b15;
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

    <div class="container">
        <h2 class="text-center my-4">Edit Product</h2>

        <div class="form-container">
            <!-- Using form:form for Spring form binding -->
           <form:form modelAttribute="productObj" action="${pageContext.request.contextPath}/updateProduct/${productObj.id}" method="post" enctype="multipart/form-data">

                <form:hidden path="id"/>
                <form:hidden path="c_id"/>

                <!-- Product Image Preview -->
                <div class="mb-3 text-center">
                    <img src="${pageContext.request.contextPath}/upload/${productObj.p_photo}" alt="${productObj.p_name}" class="product-img-preview">
                </div>

                <!-- Product Name -->
                <div class="mb-3">
                    <label for="p_name" class="form-label">Product Name:</label>
                    <form:input path="p_name" id="p_name" class="form-control" />
                </div>

                <!-- Description -->
                <div class="mb-3">
                    <label for="description" class="form-label">Description:</label>
                    <form:textarea path="description" id="description" class="form-control" rows="3" />
                </div>

                <!-- Quantity -->
                <div class="mb-3">
                    <label for="quantity" class="form-label">Quantity:</label>
                    <form:input path="quantity" id="quantity" type="number" class="form-control" />
                </div>

                <!-- Price -->
                <div class="mb-3">
                    <label for="price" class="form-label">Price (MMK):</label>
                    <form:input path="price" id="price" type="number" class="form-control" />
                </div>

                <!-- Upload New Image -->
                <div class="mb-3">
                    <label for="p_photo" class="form-label">Product Image:</label>
                    <input type="file" class="form-control" id="p_photo" name="photo">
                    <small class="form-text text-muted">Leave this field empty if you don't want to change the image.</small>
                </div>

                <!-- Submit Button -->
                <div class="d-grid">
                    <button type="submit" class="btn btn-primary">Update Product</button>
                </div>
            </form:form>
        </div>

        <!-- Back Button -->
        <div class="text-center mt-4">
            <a href="${pageContext.request.contextPath}/viewProducts?c_id=${productObj.c_id}" class="btn btn-warning">Back to Products</a>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
