/**
 * 
 */// Select DOM elements
const form = document.getElementById('form');
const firstname = document.getElementById('firstname');
const lastname = document.getElementById('lastname');
const email = document.getElementById('email');
const password = document.getElementById('password');
const password2 = document.getElementById('password2');
const role = document.getElementById('role');

// Listen for form submit event
form.addEventListener('submit', function (event) {
    // Prevent form submission by default
    event.preventDefault();

    // Perform validation and only submit if all fields are valid
    if (validateForm()) {
        form.submit();  // Submit the form if validation passes
    }
});

// Validation function to check all fields
function validateForm() {
    let isValid = true;

    // Validate first name
    if (!validateFirstName(firstname.value)) {
        setError(firstname, 'First Name is required and should only contain letters.');
        isValid = false;
    } else {
        setSuccess(firstname);
    }

    // Validate last name
    if (!validateLastName(lastname.value)) {
        setError(lastname, 'Last Name is required and should only contain letters.');
        isValid = false;
    } else {
        setSuccess(lastname);
    }

    // Validate email
    if (!validateEmail(email.value)) {
        setError(email, 'Valid Email is required.');
        isValid = false;
    } else {
        setSuccess(email);
    }

    // Validate password
    if (!validatePassword(password.value)) {
        setError(password, 'Password must contain at least 8 characters, including a number, a lowercase, an uppercase, and a special character.');
        isValid = false;
    } else {
        setSuccess(password);
    }

    // Confirm password
    if (password.value !== password2.value) {
        setError(password2, 'Passwords must match.');
        isValid = false;
    } else {
        setSuccess(password2);
    }

    // Validate role selection
    if (role.value === "") {
        setError(role, 'Role is required. Please select a role.');
        isValid = false;
    } else {
        setSuccess(role);
    }

    return isValid;
}

// Validation for First Name (only letters, no spaces)
function validateFirstName(firstname) {
    const firstnameRegExp = /^[A-Za-z]+$/;
    return firstnameRegExp.test(firstname.trim());
}

// Validation for Last Name (letters and spaces allowed)
function validateLastName(lastname) {
    const lastnameRegExp = /^[A-Za-z ]+$/;
    return lastnameRegExp.test(lastname.trim());
}

// Email validation using regular expression
function validateEmail(email) {
    const emailRegExp = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    return emailRegExp.test(email.trim());
}



// Strong password validation
function validatePassword(password) {
    const passwordRegExp = /^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*[.,!?;:+\-%=<>\$€£¥@#&*_^~|()[\]{}"'\\]).{8,}$/;
    return passwordRegExp.test(password);
}



// Display error message and highlight input field
function setError(element, message) {
    const inputControl = element.parentElement;
    const errorDisplay = inputControl.querySelector('.error');

    errorDisplay.innerText = message;
    inputControl.classList.add('error');
    inputControl.classList.remove('success');
}

// Clear error message and highlight success for valid input
function setSuccess(element) {
    const inputControl = element.parentElement;
    const errorDisplay = inputControl.querySelector('.error');

    errorDisplay.innerText = '';
    inputControl.classList.add('success');
    inputControl.classList.remove('error');
}