
let listProductHTML = document.querySelector('.listProduct');
let listCartHTML = document.querySelector('.listCart');
let iconCart = document.querySelector('.icon-cart');
let iconCartSpan = document.querySelector('.icon-cart span');
let body = document.querySelector('body');
let closeCart = document.querySelector('.close');

window.onload = function() {
    const successMessage = document.getElementById('successMessage');
    if (successMessage) {
        setTimeout(function() {
            successMessage.classList.add('hidden');
        }, 5000);
    }
};

document.body.addEventListener('click', function() {
    const successMessage = document.getElementById('successMessage');
    if (successMessage) {
        successMessage.classList.add('hidden');
    }
});

let products = [
    { "id": 1, "name": "Nan gyi Thoke", "price": 1000, "image": `${window.location.origin}/ChefsMarket/resources/image/1.png` },
    { "id": 2, "name": "Mohinga", "price": 1500, "image": `${window.location.origin}/ChefsMarket/resources/image/2.png` },
    { "id": 3, "name": "Kaut Nyinn Paung", "price": 500, "image": `${window.location.origin}/ChefsMarket/resources/image/3.png` },
    { "id": 4, "name": "Bain Mote", "price": 500, "image": `${window.location.origin}/ChefsMarket/resources/image/4.png` },
    { "id": 5, "name": "Mote Lone Yay Paw", "price": 500, "image": `${window.location.origin}/ChefsMarket/resources/image/5.png` },
    { "id": 6, "name": "Mont Lat Saung", "price": 600, "image": `${window.location.origin}/ChefsMarket/resources/image/6.png` },
    { "id": 7, "name": "Chicken Burger", "price": 3500, "image": `${window.location.origin}/ChefsMarket/resources/image/7.png` },
    { "id": 8, "name": "Coca-Cola", "price": 700, "image": `${window.location.origin}/ChefsMarket/resources/image/8.png` }
];

let cart = [];

// Toggle cart visibility
iconCart.addEventListener('click', () => body.classList.toggle('showCart'));
closeCart.addEventListener('click', () => body.classList.toggle('showCart'));

// Load cart from local storage
window.onload = function() {
    cart = JSON.parse(localStorage.getItem('cart')) || [];
    addCartToHTML();
    addDataToHTML();
};

// Add product data to HTML
const addDataToHTML = () => {
    listProductHTML.innerHTML = '';
    products.forEach(product => {
        let newProduct = document.createElement('div');
        newProduct.dataset.id = product.id;
        newProduct.classList.add('item');
        newProduct.innerHTML = 
        `<img src="${product.image}" alt="${product.name}">
         <h2>${product.name}</h2>
         <div class="price">MMK ${product.price}</div>
         <button class="addCart">Add To Cart</button>`;
        listProductHTML.appendChild(newProduct);
    });
};

// Check user login status
const checkUserLoginStatus = () => {
    return fetch(`${window.location.origin}/ChefsMarket/isLoggedIn`)
        .then(response => response.json())
        .then(data => data.isLoggedIn)
        .catch(error => {
            console.error("Error checking login status:", error);
            return false;
        });
};

// Handle adding to cart
listProductHTML.addEventListener('click', (event) => {
    if (event.target.classList.contains('addCart')) {
        let productId = event.target.parentElement.dataset.id;
        checkUserLoginStatus().then(isLoggedIn => {
            if (isLoggedIn) {
                let productIndexInCart = cart.findIndex(item => item.product_id == productId);
                if (productIndexInCart >= 0) {
                    // Show alert that product is already added to the cart
                    Swal.fire({
                        title: "Product already added to cart!",
                        icon: "info",
                        customClass: {
                            popup: 'small-alert' // Add the custom CSS class here
                        }
                    });
                } else {
                    addToCart(productId);
                }
            } else {
                Swal.fire({
                    title: "Please log in to buy the food.",
                    icon: "warning",
                    showConfirmButton: true,
                    confirmButtonText: "Login",
                    customClass: {
                        popup: 'small-alert' // Add the custom CSS class here
                    }
                }).then(result => {
                    if (result.isConfirmed) {
                        window.location.href = `${window.location.origin}/ChefsMarket/login`;
                    }
                });
            }
        });
    }
});


// Add product to cart and check availability
const addToCart = (productId) => {
    fetch(`${window.location.origin}/ChefsMarket/products/availableQuantity/${productId}`)
        .then(response => response.json())
        .then(availableQuantity => {
            let currentProductInCart = cart.find(item => item.product_id == productId);
            let currentQuantity = currentProductInCart ? currentProductInCart.quantity : 0;

            if (currentQuantity + 1 <= availableQuantity) {
                if (!currentProductInCart) {
                    cart.push({ product_id: productId, quantity: 1 });
                }
                addCartToHTML();
                addCartToMemory();
            }
        })
        .catch(error => console.error("Error fetching available quantity:", error));
};

// Save cart to local storage
const addCartToMemory = () => localStorage.setItem('cart', JSON.stringify(cart));

// Add cart data to HTML
const addCartToHTML = () => {
    listCartHTML.innerHTML = '';
    let totalQuantity = 0, totalPrice = 0;

    cart.forEach(item => {
        totalQuantity += item.quantity;
        let product = products.find(p => p.id == item.product_id);
        let itemTotalPrice = product.price * item.quantity;
        totalPrice += itemTotalPrice;

        let cartItem = document.createElement('div');
        cartItem.classList.add('item');
        cartItem.dataset.id = item.product_id;
        cartItem.innerHTML = `
            <div class="image"><img src="${product.image}"></div>
            <div class="name">${product.name}</div>
            <div class="totalPrice">MMK ${itemTotalPrice}</div>
            <div class="quantity">
                <span class="minus"><</span>
                <span>${item.quantity}</span>
                <span class="plus">></span>
            </div>`;
        listCartHTML.appendChild(cartItem);
    });

    let totalElement = document.createElement('div');
    totalElement.classList.add('total');
    totalElement.innerHTML = `<h4>Total Price: MMK ${totalPrice}</h4>`;
    listCartHTML.appendChild(totalElement);

    let actionButtons = document.createElement('div');
    actionButtons.classList.add('action-buttons');
    actionButtons.innerHTML = `
        <button class="deleteAllBtn">Delete All</button>
        <button class="buyAllBtn">Confirm</button>`;
    listCartHTML.appendChild(actionButtons);

    iconCartSpan.innerText = totalQuantity;
};

// Buy all items confirmation
const confirmBuyAllItems = () => {
    Swal.fire({
        title: `Are you sure you want to buy all items for a total of MMK ${calculateTotalPrice()}?`,
        icon: "question",
        showCancelButton: true,
        confirmButtonText: "Yes, buy all",
		customClass: {
		      popup: 'small-alert' // Add the custom CSS class here
		}
    }).then(result => {
        if (result.isConfirmed) buyAllItems();
    });
};

// Delete all items confirmation
const confirmDeleteAllItems = () => {
    Swal.fire({
        title: "Are you sure you want to delete all items in your cart?",
        icon: "warning",
        showCancelButton: true,
        confirmButtonText: "Yes, delete all",
		customClass: {
		     popup: 'small-alert' // Add the custom CSS class here
		}
    }).then(result => {
        if (result.isConfirmed) deleteAllItems();
    });
};

// Buy all items and clear cart
const buyAllItems = () => {
    Swal.fire({
        icon: 'success',
        title: 'Thank you!',
        text: 'Your purchase is being processed.',
        confirmButtonText: 'OK',
        customClass: {
            popup: 'small-alert' // Add the custom CSS class here
        }
    });
    cart = [];
    addCartToHTML();
    addCartToMemory();
};


// Delete all items from cart
const deleteAllItems = () => {
    cart = [];
    addCartToHTML();
    addCartToMemory();
};

// Calculate total price of items in cart
const calculateTotalPrice = () => {
    return cart.reduce((total, item) => {
        let product = products.find(p => p.id == item.product_id);
        return total + (product.price * item.quantity);
    }, 0);
};



listCartHTML.addEventListener('click', (event) => {
    const positionClick = event.target;
    const productId = positionClick.parentElement.parentElement.dataset.id;
    const productInCart = cart.find(item => item.product_id === productId);

    // If minus button is clicked
    if (positionClick.classList.contains('minus')) {
        if (productInCart.quantity === 1) {
            cart.splice(cart.indexOf(productInCart), 1);
        } else {
            productInCart.quantity--;
        }
    } 
    // If plus button is clicked
    else if (positionClick.classList.contains('plus')) {
        fetch(`${window.location.origin}/ChefsMarket/products/availableQuantity/${productId}`)
            .then(response => response.json())
            .then(availableQuantity => {
                if (productInCart.quantity + 1 <= availableQuantity) {
                    productInCart.quantity++;
                    addCartToHTML();
                    addCartToMemory();
                } else {
                    // SweetAlert for limited quantity alert
                    Swal.fire({
                        icon: 'warning',
                        title: 'Limited Stock',
                        text: 'Sorry, the available quantity for this product is limited.',
                        confirmButtonText: 'OK',
						customClass: {
						       popup: 'small-alert' // Add the CSS class here
						}
                    });
                }
            })
            .catch(error => {
                console.error("Error fetching available quantity:", error);
            });
    }

    // Update cart in the UI and memory
    addCartToHTML();
    addCartToMemory();
});



// Delete all and buy all button event listeners
listCartHTML.addEventListener('click', (event) => {
    if (event.target.classList.contains('deleteAllBtn')) {
        confirmDeleteAllItems();
    } else if (event.target.classList.contains('buyAllBtn')) {
        confirmBuyAllItems();
    }
});
