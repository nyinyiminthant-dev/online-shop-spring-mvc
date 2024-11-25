/**
 * 
 */



// Function to display cart items
 function displayCartItems() {
     const cartItems = JSON.parse(localStorage.getItem('cartItems')) || [];
     const cartItemsContainer = document.getElementById('cart-items');
     let totalPrice = 0;

     // Clear existing items
     cartItemsContainer.innerHTML = '';

     // Check if the cart is empty
     if (cartItems.length === 0) {
         cartItemsContainer.innerHTML = '<tr><td colspan="5">Your cart is empty.</td></tr>';
         document.getElementById('total-price').innerText = 'Total Price: $0.00';
         return;
     }

     // Populate the table with cart items
     cartItems.forEach((item) => {
         const itemTotal = item.price * item.quantity;
         totalPrice += itemTotal;

         const row = document.createElement('tr');
         row.innerHTML = `
             <td class="cart-item">
                 <img src="data:image/jpeg;base64,${item.image}" alt="${item.name}" />
                 <h5>${item.name}</h5>
                 <p>Price: ${item.price} KS</p>
             </td>
             <td>$${item.price.toFixed(2)}</td>
             <td>
                 <div>
                     <button onclick="adjustQuantity('${item.id}', -1)">-</button>
                     <input type="number" id="quantity-${item.id}" value="${item.quantity}" min="1" style="width: 50px; text-align: center;" />
                     <button onclick="adjustQuantity('${item.id}', 1)">+</button>
                 </div>
             </td>
             <td>$${itemTotal.toFixed(2)}</td>
             <td><button class="btn btn-danger btn-sm" onclick="removeFromCart('${item.id}')">Remove</button></td>
         `;
         cartItemsContainer.appendChild(row);
     });

     // Update the total price
     document.getElementById('total-price').innerText = `Total Price: $${totalPrice.toFixed(2)}`;
 }

 // Function to adjust item quantity
 function adjustQuantity(itemId, change) {
     const cartItems = JSON.parse(localStorage.getItem('cartItems')) || [];
     const item = cartItems.find(i => i.id === itemId);

     if (item) {
         item.quantity += change;
         if (item.quantity < 1) {
             item.quantity = 1;  // Prevent quantity from going below 1
         }
     }

     // Save updated cart to localStorage
     localStorage.setItem('cartItems', JSON.stringify(cartItems));

     // Refresh the cart display
     displayCartItems();
 }

 // Function to remove item from cart
 function removeFromCart(itemId) {
     let cartItems = JSON.parse(localStorage.getItem('cartItems')) || [];
     cartItems = cartItems.filter(item => item.id !== itemId);

     // Save the updated cart to localStorage
     localStorage.setItem('cartItems', JSON.stringify(cartItems));

     // Refresh the cart display
     displayCartItems();
 }

 // Function to clear the cart
 function clearCart() {
     localStorage.removeItem('cartItems');
     displayCartItems();
 }

 // Function to simulate checkout (for now just clear the cart)
 function checkout() {
     alert("Proceeding to checkout!");
     clearCart();
 }

 // Call displayCartItems on page load
 document.addEventListener('DOMContentLoaded', displayCartItems); // Function to display cart items
  function displayCartItems() {
      const cartItems = JSON.parse(localStorage.getItem('cartItems')) || [];
      const cartItemsContainer = document.getElementById('cart-items');
      let totalPrice = 0;

      // Clear existing items
      cartItemsContainer.innerHTML = '';

      // Check if the cart is empty
      if (cartItems.length === 0) {
          cartItemsContainer.innerHTML = '<tr><td colspan="5">Your cart is empty.</td></tr>';
          document.getElementById('total-price').innerText = 'Total Price: $0.00';
          return;
      }

      // Populate the table with cart items
      cartItems.forEach((item) => {
          const itemTotal = item.price * item.quantity;
          totalPrice += itemTotal;

          const row = document.createElement('tr');
          row.innerHTML = `
              <td class="cart-item">
                  <img src="data:image/jpeg;base64,${item.image}" alt="${item.name}" />
                  <h5>${item.name}</h5>
                  <p>Price: ${item.price} KS</p>
              </td>
              <td>$${item.price.toFixed(2)}</td>
              <td>
                  <div>
                      <button onclick="adjustQuantity('${item.id}', -1)">-</button>
                      <input type="number" id="quantity-${item.id}" value="${item.quantity}" min="1" style="width: 50px; text-align: center;" />
                      <button onclick="adjustQuantity('${item.id}', 1)">+</button>
                  </div>
              </td>
              <td>$${itemTotal.toFixed(2)}</td>
              <td><button class="btn btn-danger btn-sm" onclick="removeFromCart('${item.id}')">Remove</button></td>
          `;
          cartItemsContainer.appendChild(row);
      });

      // Update the total price
      document.getElementById('total-price').innerText = `Total Price: $${totalPrice.toFixed(2)}`;
  }

  // Function to adjust item quantity
  function adjustQuantity(itemId, change) {
      const cartItems = JSON.parse(localStorage.getItem('cartItems')) || [];
      const item = cartItems.find(i => i.id === itemId);

      if (item) {
          item.quantity += change;
          if (item.quantity < 1) {
              item.quantity = 1;  // Prevent quantity from going below 1
          }
      }

      // Save updated cart to localStorage
      localStorage.setItem('cartItems', JSON.stringify(cartItems));

      // Refresh the cart display
      displayCartItems();
  }

  // Function to remove item from cart
  function removeFromCart(itemId) {
      let cartItems = JSON.parse(localStorage.getItem('cartItems')) || [];
      cartItems = cartItems.filter(item => item.id !== itemId);

      // Save the updated cart to localStorage
      localStorage.setItem('cartItems', JSON.stringify(cartItems));

      // Refresh the cart display
      displayCartItems();
  }

  // Function to clear the cart
  function clearCart() {
      localStorage.removeItem('cartItems');
      displayCartItems();
  }

  // Function to simulate checkout (for now just clear the cart)
  function checkout() {
      alert("Proceeding to checkout!");
      clearCart();
  }

  // Call displayCartItems on page load
  document.addEventListener('DOMContentLoaded', displayCartItems);