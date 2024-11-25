<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
    <title>View Users</title>
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
        .admin-header {
            margin-top: 20px;
            margin-left: 1px;
            text-align: left;
            font-size: 2rem;
            color: #ff6f61;
        }
        .table {
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            overflow: hidden;
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
            right: -900px;
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
    <!-- Admin Info -->
    <c:if test="${not empty sessionScope.user}">
        <span class="navbar-text me-2">
            <i class="bi bi-person-circle"></i> Admin: ${sessionScope.user.email}
        </span>
    </c:if>

    <!-- User List Content -->
    <h2 class="admin-header">User List</h2>

    <!-- Check if there are users -->
    <c:if test="${empty userList}">
        <p class="text-center text-danger">No user available.</p>
    </c:if>

    <c:if test="${not empty userList}">
        <table class="table table-bordered mt-4">
            <thead class="table-light">
                <tr>
                    <th>ID</th>
                    <th>Email</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="user" items="${userList}" varStatus="count">
                    <tr>
                         <td>${count.count} </td>
                        <td>${user.email}</td>
                        <td>
                            <button class="btn btn-ban" onclick="confirmBan('${pageContext.request.contextPath}/delete/${user.id}')">
                                <i class="bi bi-x-circle"></i> Ban
                            </button>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </c:if>
</div>

<!-- SweetAlert Scripts -->
<script>
    function confirmBan(url) {
        Swal.fire({
            title: 'Are you sure you want to ban this user?',
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#dc3545',
            cancelButtonColor: '#6c757d',
            confirmButtonText: 'Yes, Ban!'
        }).then((result) => {
            if (result.isConfirmed) {
                window.location.href = url;
            }
        });
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

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js"></script>
</body>
</html>
