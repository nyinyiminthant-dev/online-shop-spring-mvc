package Online_shop.Controller;

import javax.servlet.http.HttpSession; 

import org.springframework.stereotype.Controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
public class checkoutController {

	
	
	@GetMapping(value="/check")
	public String check(HttpSession session,RedirectAttributes redirectAttrs) {
		
		
		 if (session.getAttribute("user") == null) {
		        // Redirect to login page if the user is not logged in
			 
			 redirectAttrs.addFlashAttribute("winningMessage", "You must login to buy!");
		        redirectAttrs.addFlashAttribute("icon", "error");
		        return "redirect:/blogin";
		    }
		return "checkout";
	}
	
	
	
	
	@GetMapping(value="/thankyou")
	public String thankyouPage() {
		
		return "thankyou";
	}
	
	
	@GetMapping(value="/orderHistory")
	public String orderHistory() {
		
		return "orderHistory";
	}
}
