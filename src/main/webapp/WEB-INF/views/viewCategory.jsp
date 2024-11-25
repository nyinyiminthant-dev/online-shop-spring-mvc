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
    <title>Manage Categories</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <style>
        /* Your custom styles go here */
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
            right: -880px;
        }
        .category-photo {
            width: 50px;
            height: 50px;
            object-fit: cover;
            border-radius: 5px;
        }
       
        button a {
            color: white;
            text-decoration: none;
        }
        button:hover {
            opacity: 0.9;
        }
        button .bi {
            font-size: 1.2rem;
        }
        .btn-ban {
            margin-left: 10px;
        }
        .btn-warning {
            margin-left: 10px;
        }
        .table tbody tr:hover {
            background-color: #f1f1f1;
        }
        .error {
            color: red;
            font-size: 0.875rem;
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
    <a class="navbar-brand" href="#"><i class="bi bi-shop"></i> Admin Dashboard</a>
    <ul class="nav flex-column">
        <li class="nav-item">
            <a class="nav-link" href="${pageContext.request.contextPath}/admin"><i class="bi bi-house-door"></i> Dashboard</a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="#"><i class="bi bi-list"></i> Manage Categories</a>
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

<!-- Main Content Area -->
<div class="content">
    <c:if test="${not empty sessionScope.user}">
        <span class="navbar-text me-2">
            <i class="bi bi-person-circle"></i> Admin: ${sessionScope.user.email}
        </span>
    </c:if>

<!-- Category List Content -->
<div class="container">
    <h2 class="admin-header">Manage Categories</h2>

    <!-- Add Category Form -->
    <div class="mb-4">
        <h4>Add New Category</h4>
        <form:form modelAttribute="categoryObj" action="${pageContext.request.contextPath}/addCategory" method="POST" enctype="multipart/form-data" onsubmit="return validateForm()">
            <div class="mb-3 input-group">
                <span class="input-group-text"><i class="bi bi-tags"></i></span>
                <form:input path="c_name" type="text" class="form-control" placeholder="Enter category name" />
                <form:errors path="c_name" class="error" />
            </div>
          <div class="mb-3 input-group" style="width: 148px;">
    <span class="input-group-text"><i class="bi bi-upload"></i></span>
    <form:input path="photo" type="file" class="form-control" id="categoryPhoto" />
</div>

            <button type="submit" class="btn btn-primary"><i class="bi bi-plus-circle"></i> Add Category</button>
        </form:form>
    </div>

    <!-- Check if there are categories -->
    <c:if test="${empty categoryList}">
        <p class="text-center text-danger">No categories available.</p>
    </c:if>

    <c:if test="${not empty categoryList}">
        <table class="table table-bordered mt-4">
            <thead class="table-light">
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Photo</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="category" items="${categoryList}" varStatus="count">
                    <tr>
                        <td>${count.count}</td>
                        <td>${category.c_name}</td>
                        <td>
                            <img src="${pageContext.request.contextPath}/upload/${category.c_photo}" alt="Category Photo" class="category-photo">
                        </td>
                        <td>
                            <a href="${pageContext.request.contextPath}/editCategory/${category.id}" class="btn btn-warning mt-1"><i class="bi bi-pencil"></i> Edit</a>
                            <button class="btn btn-ban" onclick="confirmDelete('${pageContext.request.contextPath}/deleteCategory/${category.id}')">
                                <i class="bi bi-x-circle"></i> Delete
                            </button>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </c:if>
</div>
</div>

<!-- SweetAlert Delete Confirmation Script -->
<script>
    function confirmDelete(url) {
        Swal.fire({
            title: 'Are you sure you want to delete this category?',
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: 'Yes, delete it!',
        }).then((result) => {
            if (result.isConfirmed) {
                window.location.href = url;
            }
        });
    }
    
    
   
    function validateForm() {
        // Get the values of the fields
        var categoryName = document.querySelector('input[name="c_name"]').value;
        var photo = document.querySelector('input[name="photo"]').value;

        // Check if category name is empty
        if (categoryName.trim() === "") {
            Swal.fire({
                icon: 'error',
                title: 'Error',
                text: 'Category name cannot be empty!',
            });
            return false; // Prevent form submission
        }

        // Check if photo is selected
        if (photo.trim() === "") {
            Swal.fire({
                icon: 'error',
                title: 'Error',
                text: 'Please upload a photo!',
            });
            return false; // Prevent form submission
        }

        // If both fields are filled, allow form submission
        return true;
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




<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</body>
</html>
