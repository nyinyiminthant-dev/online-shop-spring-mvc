<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thank You</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        body {
            background-color: #f0f8ff;
        }
        .thank-you-container {
            display: flex;
            align-items: center;
            justify-content: center;
            min-height: 100vh;
            padding: 20px;
        }
        .card {
            border: none;
            border-radius: 15px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        .card-header {
            background-color: #ffe;
            color: #ff6f61;
            font-size: 1.8rem;
            font-weight: bold;
            border-top-left-radius: 15px;
            border-top-right-radius: 15px;
            text-align: center;
            padding: 20px;
        }
        .card-body {
            text-align: center;
            padding: 30px;
        }
        .thank-you-message {
            font-size: 1.5rem;
            color: #333;
        }
        .thank-you-text {
            font-size: 1.2rem;
            color: #6c757d;
            margin: 20px 0;
        }
        .btn {
            margin: 10px;
            font-size: 1rem;
            transition: transform 0.3s, box-shadow 0.3s;
        }
        .btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }
        .btn-primary {
            background-color: #ff6f61;
            border-color: #ff6f61;
        }
        .btn-primary:hover {
            background-color: #ff4b45;
            border-color: #ff4b45;
        }
    </style>
</head>
<body>

<div class="thank-you-container">
    <div class="card" style="width: 100%; max-width: 600px;">
        <div class="card-header">
            Thank You!
        </div>
        <div class="card-body">
            <h1 class="thank-you-message">Your Order is Confirmed</h1>
            <p class="thank-you-text">We truly appreciate your business and look forward to serving you again!</p>
            <a href="${pageContext.request.contextPath}/shop" class="btn btn-primary btn-lg">
                <i class="bi bi-bag"></i> Continue Shopping
            </a>
         
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Optionally, you can clear the cart data from localStorage when the user reaches this page
    localStorage.removeItem('cartItems');
</script>

</body>
</html>
