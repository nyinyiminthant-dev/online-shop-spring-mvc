<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order Details</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body>
    <div class="container mt-5">
        <h1 class="mb-4">Order Details</h1>
        <ul class="list-group">
            <c:forEach var="item" items="${order.items}">
                <li class="list-group-item d-flex justify-content-between align-items-center">
                    ${item.name}
                    <span>$<fmt:formatNumber value="${item.price * item.quantity}" minFractionDigits="2" /> (x${item.quantity})</span>
                </li>
            </c:forEach>
        </ul>
        <div class="mt-3">
            <h3>Total: $<fmt:formatNumber value="${order.total}" minFractionDigits="2" /></h3>
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
