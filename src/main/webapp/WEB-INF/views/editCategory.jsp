<%@ page language="java" contentType="text/html; charset=UTF-8"%>
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
    <title>Edit Category</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <style>
        body {
            background-color: #f0f8ff;
            color: #212529;
            display: flex;
            min-height: 100vh;
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
        .content {
            margin-left: 250px;
            padding: 20px;
            flex: 1;
        }
        .card {
            border-radius: 15px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            padding: 30px;
        }
        .category-photo {
            width: 200px;
            height: 200px;
            object-fit: cover;
            border-radius: 10px;
            margin-bottom: 10px;
        }
        
        
        .error {
            color: red;
            font-size: 0.875rem;
        }
        .btn-primary, .btn-warning {
            border-radius: 20px;
        }
        .admin-header {
        
            color: #ff6f61;
            margin-left: 5px;
        }
        
        
        .navbar-text {
            color: #4b6584 !important;
            position: relative;
            right: -883px;
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
            <a class="nav-link active" href="/viewUsers"><i class="bi bi-people"></i> Manage Users</a>
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

    <!-- Edit Category Form -->
    <h2 class="admin-header">Edit Category</h2>

    <div class="card">
        <div class="text-center">
            <img src="${pageContext.request.contextPath}/upload/${categoryObj.c_photo}" alt="Category Photo" class="category-photo">
            <div class="category-name">${categoryObj.c_name}</div>
        </div>

        <form:form modelAttribute="categoryObj" action="${pageContext.request.contextPath}/editcategory/${categoryObj.id}" method="POST" enctype="multipart/form-data">
            <div class="mb-3 input-group">
                <span class="input-group-text"><i class="bi bi-tags"></i></span>
                <form:input path="c_name" type="text" class="form-control" placeholder="Enter category name" />
                <form:errors path="c_name" class="error" />
            </div>
            <div class="mb-3 input-group" style="width: 148px;">
                <span class="input-group-text"><i class="bi bi-upload"></i></span>
                <form:input path="photo" type="file" class="form-control" />
                <form:errors path="photo" class="error" />
            </div>

            <button type="submit" class="btn btn-primary"><i class="bi bi-save"></i> Save Changes</button>
            <a href="${pageContext.request.contextPath}/category" class="btn btn-warning"><i class="bi bi-arrow-left"></i> Back</a>
        </form:form>
    </div>
</div>

<script>
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
