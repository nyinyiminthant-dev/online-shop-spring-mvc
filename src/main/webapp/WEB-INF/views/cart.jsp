<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Shopping Cart</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        .cart-table {
            margin-top: 20px;
        }
        .cart-table th, .cart-table td {
            text-align: center;
            vertical-align: middle;
        }
        .total-price {
            font-weight: bold;
            color: #ff6f61;
        }
        .cart-item img {
            width: 100px;
            height: 100px;
        }
        .cart-item div {
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .cart-item span {
            font-weight: bold;
        }
    </style>
</head>
<body>


<div class="container">
    <h1 class="text-center my-4">Your Shopping Cart</h1>


   <!-- want to card stection  start -->
    <!-- Cart Table -->
    <table class="table table-bordered cart-table">
        <thead>
            <tr>
                <th>Product Name</th>
                <th>Price</th>
                <th>Quantity</th>
                <th>Total</th>
                <th>Action</th>
            </tr>
        </thead>
        <tbody id="cart-container">
            <!-- Cart items will be populated here using JavaScript -->
        </tbody>
    </table>

    <div class="text-center">
        <h4 class="total-price">Total Price: <span id="total-price"></span></h4>
        <button class="btn btn-danger" onclick="clearCart()">Clear Cart</button>
        <a href="${pageContext.request.contextPath}/shop" class="btn btn-secondary">Continue Shopping</a>
       <a href="${pageContext.request.contextPath}/check"> <button class="btn btn-primary" onclick="checkout()">Proceed to Checkout</button></a>
    </div>
    
    <!-- want to card stection  end -->
</div>


<div>
  
</div>
<script>
    // Function to update the cart and display items in the table
    function updateCart() {
        const cartItems = JSON.parse(localStorage.getItem('cartItems')) || [];
        const cartContainer = document.getElementById('cart-container');
        const totalPriceElement = document.getElementById('total-price');

        // Ensure totalPriceElement exists before proceeding
        if (!totalPriceElement) {
            console.error('Total price element not found.');
            return;
        }

        // Clear existing cart items in the table
        cartContainer.innerHTML = '';

        let totalPrice = 0;

        // Iterate through cart items and populate the table
        cartItems.forEach(item => {
            console.log({ item });

            // Ensure price and quantity are numbers
            const itemPrice = parseFloat(item.price) || 0;
            const itemQuantity = parseInt(item.quantity, 10) || 0;

            const totalItemPrice = (itemPrice * itemQuantity).toFixed(2);
            totalPrice += itemPrice * itemQuantity;

            // Create a table row for each item
            const row = document.createElement('tr');
            row.classList.add('cart-item');

            row.innerHTML = 
                "<td>" + item.name + "</td>" +
                "<td>$" + itemPrice.toFixed(2) + "</td>" +
                "<td>" +
                    "<div class='d-flex justify-content-center align-items-center'>" +
                        "<button class='btn btn-secondary' onclick='updateItemQuantity(\"" + item.id + "\", \"decrease\")'>-</button>" +
                        "<span class='mx-2'>" + itemQuantity + "</span>" +
                        "<button class='btn btn-secondary' onclick='updateItemQuantity(\"" + item.id + "\", \"increase\")'>+</button>" +
                    "</div>" +
                "</td>" +
                "<td>$" + totalItemPrice + "</td>" +
                "<td>" +
                    "<button class='btn btn-danger' onclick='removeItemFromCart(\"" + item.id + "\")'>" +
                        "<i class='bi bi-trash'></i> Remove" +
                    "</button>" +
                "</td>";

            cartContainer.appendChild(row);
        });

        // Update total price in the view
        totalPriceElement.textContent = "$" + totalPrice.toFixed(2);
        console.log('Updated total price:', totalPrice.toFixed(2));
    }

    // Function to update item quantity in the cart
    function updateItemQuantity(itemId, action) {
        const cartItems = JSON.parse(localStorage.getItem('cartItems')) || [];
        const updatedCartItems = cartItems.map(item => {
            if (item.id === itemId) {
                let updatedQuantity = item.quantity;

                // Handle increase and decrease actions
                if (action === 'increase') {
                    updatedQuantity++;
                } else if (action === 'decrease' && updatedQuantity > 1) {
                    updatedQuantity--;
                }

                item.quantity = updatedQuantity; // Update the quantity of the item
            }
            return item;
        });

        // Save updated cart to localStorage
        localStorage.setItem('cartItems', JSON.stringify(updatedCartItems));

        // Re-render the cart with updated data
        updateCart();
    }

    // Function to remove an item from the cart
    function removeItemFromCart(itemId) {
        const cartItems = JSON.parse(localStorage.getItem('cartItems')) || [];
        const updatedCartItems = cartItems.filter(item => item.id !== itemId);
        localStorage.setItem('cartItems', JSON.stringify(updatedCartItems));
        updateCart(); // Re-render the cart
    }

    // Function to clear the cart
    function clearCart() {
        localStorage.removeItem('cartItems');
        updateCart(); // Re-render the empty cart
    }

    // Function for checkout (placeholder, you can implement actual checkout logic here)
    
    
    
    
    
    function checkout() {
        alert("Proceeding to checkout...");
    }

    // Initialize the cart on page load
    document.addEventListener('DOMContentLoaded', updateCart);
</script>

</body>
</html>
