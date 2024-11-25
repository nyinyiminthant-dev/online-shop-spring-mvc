<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Checkout</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        .checkout-summary {
            margin-top: 20px;
        }
        .total-price {
            font-weight: bold;
            color: #ff6f61;
        }
    </style>
</head>
<body>

<div class="container">
    <h1 class="text-center my-4">Checkout</h1>
    
    <!-- Cart Summary -->
    <div class="checkout-summary">
        <h3>Cart Summary</h3>
        <table class="table table-bordered">
            <thead>
                <tr>
                    <th>Product Name</th>
                    <th>Price</th>
                    <th>Quantity</th>
                    <th>Total</th>
                </tr>
            </thead>
            <tbody id="cart-summary-container">
                <!-- Cart items will be populated here using JavaScript -->
            </tbody>
        </table>

        <h4 class="total-price">Total Price: $<span id="total-price-summary"></span></h4>
    </div>

    <!-- Billing & Shipping Information -->
    <div class="checkout-form">
        <h3>Billing & Shipping Information</h3>
        <form id="orderForm" method="POST">
            <div class="mb-3">
                <label for="address" class="form-label">Address</label>
                <input type="text" id="address" name="address" class="form-control" required>
            </div>

            <!-- Payment Method Selection -->
            <div class="mb-3">
                <label for="payment-method" class="form-label">Payment Method</label>
                <select id="payment-method" name="paymentMethod" class="form-select" required>
                    <option value="" disabled selected>Select Payment Method</option>
                    <option value="kpay">K Pay</option>
                    <option value="wave">Wave</option>
                </select>
            </div>
        </form>

        <div class="text-center">
            <button type="button" id="placeOrderButton" class="btn btn-primary">Place Order</button>
            <a href="${pageContext.request.contextPath}/cart" class="btn btn-secondary">Go Back to Cart</a>
        </div>
    </div>
</div>

<script>
    // Function to update the checkout page with cart items
    function updateCheckout() {
        const cartItems = JSON.parse(localStorage.getItem('cartItems')) || [];
        const cartSummaryContainer = document.getElementById('cart-summary-container');
        const totalPriceElement = document.getElementById('total-price-summary');

        // Clear existing cart items in the summary
        cartSummaryContainer.innerHTML = '';

        let totalPrice = 0;

        // Iterate through cart items and populate the table
        cartItems.forEach(item => {
            const itemPrice = parseFloat(item.price) || 0;
            const itemQuantity = parseInt(item.quantity, 10) || 0;

            const totalItemPrice = (itemPrice * itemQuantity).toFixed(2);
            totalPrice += itemPrice * itemQuantity;

            // Create a table row for each item
            const row = document.createElement('tr');
            row.innerHTML = 
                "<td>" + item.name + "</td>" +
                "<td>$" + itemPrice.toFixed(2) + "MMK" + "</td>" +
                "<td>" + itemQuantity  + "</td>" +
                "<td>$" + totalItemPrice + "MMK" + "</td>";

            cartSummaryContainer.appendChild(row);
        });

        // Update total price in the summary
        totalPriceElement.textContent = totalPrice.toFixed(2) + "MMK";
    }

    // Initialize checkout page on load
    document.addEventListener('DOMContentLoaded', updateCheckout);

    // Function to handle order submission
    function submitOrder() {
        const address = document.getElementById('address').value;
        const paymentMethod = document.getElementById('payment-method').value;
        const cartItems = JSON.parse(localStorage.getItem('cartItems')) || [];

        // Check if payment method is selected
        if (!paymentMethod) {
            alert('Please select a payment method.');
            return;
        }

        // Prepare order data
        const orderData = {
            address: address,
            paymentMethod: paymentMethod,
            orderDetails: cartItems
        };

        // Make a POST request to update the order
        fetch('/Online_shop/update_order', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify(orderData)
        })
        .then(response => {
            // Check if the response is JSON
            const contentType = response.headers.get('content-type');
            if (!contentType || !contentType.includes('application/json')) {
                throw new Error('Server returned an invalid response.');
            }
            return response.json();
        })
        .then(data => {
            if (data.status === 'success') {
                alert('Order submitted successfully!');
                localStorage.removeItem('cartItems');
                window.location.href = '${pageContext.request.contextPath}/thankyou';
            } else {
                alert(data.message || 'Failed to submit order.');
            }
        })
        .catch(error => {
            console.error('Error:', error);
            alert('Internal server error.');
        });
    }

    // Attach the submitOrder function to the button click
    document.getElementById('placeOrderButton').addEventListener('click', submitOrder);
</script>

</body>
</html>
