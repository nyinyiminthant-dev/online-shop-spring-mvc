package Online_shop.Controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class homeController {

	@GetMapping(value="/")
	public String homePage() {
		return "index";
	}
	
	@GetMapping(value="/about")
	public String aboutPage() {
		return "about";
	}
	
	@GetMapping(value="/contact")
	public String contactPage() {
		return "contact";
	}
	

	
	

	
}
