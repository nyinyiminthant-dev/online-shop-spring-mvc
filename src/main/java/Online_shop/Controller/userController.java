package Online_shop.Controller;



import java.util.List;


import javax.servlet.http.HttpSession; 
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired; 
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;



import Online_shop.Model.loginBean;
import Online_shop.Model.userBean;
import Online_shop.Repository.userRepository;


@Controller
public class userController {

	@Autowired
	private userRepository userRepository;
	
	@GetMapping(value="/register")
	public ModelAndView registerForm() {
		userBean bean = new userBean();
		ModelAndView mv = new ModelAndView("registerform","userObj", bean);
		return mv;
		
	}
	
	@PostMapping(value = "/register")
	public String register(@ModelAttribute("userObj") userBean bean, RedirectAttributes redirectAttrs) {
	    if (userRepository.emailExists(bean.getEmail())) {
	        redirectAttrs.addFlashAttribute("errorMessage", "Email already exists. Please use a different email.");
	        return "redirect:/register"; // Redirect to registration page
	    }

	    int result = userRepository.insertUser(bean);
	    if (result > 0) {
	        redirectAttrs.addFlashAttribute("successMessage", "Registered successfully!");
	        return "redirect:/login";
	    } else {
	        redirectAttrs.addFlashAttribute("errorMessage", "Registration failed. Please try again.");
	        return "redirect:/register";
	    }
	}



	@GetMapping(value="/login")
	public ModelAndView login () {
		userBean bean = new userBean();
		ModelAndView mv = new ModelAndView("login","userObj",bean);
		return mv;
	}

	
	@PostMapping(value = "/dologin")
	public String doLogin(@Valid @ModelAttribute("userObj") loginBean login, 
	                      BindingResult bindingResult, 
	                      Model model, 
	                      HttpSession session, 
	                      RedirectAttributes redirectAttrs) {
		
		
		 if (login.getEmail().isEmpty()) {
		        bindingResult.rejectValue("email", "email.empty", "Email is required.");
		    }
		 
		 
		 if (login.getPassword().isEmpty()) {
		        bindingResult.rejectValue("password", "password.empty", "Password is required.");
		    }
	    if (bindingResult.hasErrors()) {
	        // Return to the login page if there are validation errors
	        return "login";
	    }

	    userBean obj = userRepository.login(login);

	    if (obj == null) {
	        // Determine if the error is due to an invalid email or incorrect password
	        boolean emailExists = userRepository.emailExists(login.getEmail());
	        
	        if (!emailExists) {
	            model.addAttribute("emailError", "Incorrect email");
	        } else {
	            model.addAttribute("passwordError", "Incorrect password.");
	        }
	        
	        return "login";
	    } 

	    // If login is successful, set session attributes and redirect based on role
	    session.setAttribute("user", obj); // Store user information in session
	    
	    model.addAttribute("user", obj);
	    model.addAttribute("email", obj.getEmail());

	    switch (obj.getRole()) {
	        case "admin":
	            return "admin";
	        
	        default:
	            redirectAttrs.addFlashAttribute("successMessage", "Login successfully!");
	            return "redirect:/";  // Redirect to homepage after successful login
	    }
	}

	  @GetMapping(value="/admin")
	    public String goAdminHomePage(HttpSession session, Model model) {
	        // Retrieve the logged-in user information
	        userBean user = (userBean) session.getAttribute("user");

	        // Check if the user session is valid
	        if (user == null) {
	            // Redirect to login if user is not found in session
	            return "redirect:/login";
	        }

	        // Add user details to the model for JSP access
	        model.addAttribute("user", user);
	        model.addAttribute("email", user.getEmail());

	        return "admin"; // Return the 'admin.jsp' view
	    }
	@GetMapping("/viewUsers")
	public ModelAndView viewUsers() {
	    // Fetch the list of users from the repository
	    List<userBean> userList = userRepository.getUsers();

	    // Create a ModelAndView object with the JSP page and add the user list
	    ModelAndView mv = new ModelAndView("viewUsers");
	    mv.addObject("userList", userList);
	    return mv;
	}
	
	  @GetMapping("/delete/{userId}")
	    public String deleteUser(@PathVariable("userId") int userId, Model model) {
	        // Call repository method to delete user
	        userRepository.deleteUserById(userId);

	        // Add a success message to the model
	        model.addAttribute("message", "User deleted successfully.");

	        // Redirect to the user list page after deletion
	        return "redirect:/viewUsers"; // Adjust URL if needed
	    }

	
	
	
	@GetMapping(value="/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return"redirect:/";
	}
	
	
	@GetMapping(value="/blogin")
	public ModelAndView tobuylogin () {
		userBean bean = new userBean();
		ModelAndView mv = new ModelAndView("blogin","userObj",bean);
		return mv;
	}
	
	
	
	
	
	
	@PostMapping(value = "/bdologin")
	public String bdoLogin(@Valid @ModelAttribute("userObj") loginBean login, 
	                      BindingResult bindingResult, 
	                      Model model, 
	                      HttpSession session, 
	                      RedirectAttributes redirectAttrs) {
		
		
		 if (login.getEmail().isEmpty()) {
		        bindingResult.rejectValue("email", "email.empty", "Email is required.");
		    }
		 
		 
		 if (login.getPassword().isEmpty()) {
		        bindingResult.rejectValue("password", "password.empty", "Password is required.");
		    }
	    if (bindingResult.hasErrors()) {
	        // Return to the login page if there are validation errors
	        return "blogin";
	    }

	    userBean obj = userRepository.login(login);

	    if (obj == null) {
	        // Determine if the error is due to an invalid email or incorrect password
	        boolean emailExists = userRepository.emailExists(login.getEmail());
	        
	        if (!emailExists) {
	            model.addAttribute("emailError", "Incorrect email");
	        } else {
	            model.addAttribute("passwordError", "Incorrect password.");
	        }
	        
	        return "blogin";
	    } 

	    // If login is successful, set session attributes and redirect based on role
	    session.setAttribute("user", obj); // Store user information in session
	    
	    model.addAttribute("user", obj);
	    model.addAttribute("email", obj.getEmail());

	    switch (obj.getRole()) {
	        case "admin":
	            return "admin";
	        
	        default:
	            redirectAttrs.addFlashAttribute("successMessage", "Login successfully!");
	            return "redirect:/shop";  // Redirect to homepage after successful login
	    }
	}
}
