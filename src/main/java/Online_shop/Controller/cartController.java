package Online_shop.Controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class cartController {
	
	
	@GetMapping(value="/cart")
	public String showCart() {
		
		return "cart";
	}
	
	/*
	 * @Autowired
	 * 
	 * private productRepository productrepo;
	 * 
	 * @PostMapping("addToCart") public String
	 * addtoCart(@RequestParam("productId")int productId,HttpSession session) {
	 * userBean uBean=(userBean) session.getAttribute("user"); int
	 * userId=uBean.getId(); int i=productrepo.inserttoCart(productId, userId);
	 * if(i>0) { int categoryId = productrepo.getCategoryIdByProductId(productId);
	 * return "redirect:/viewProductsuser?c_id=" + categoryId; } return null; }
	 * 
	 * @GetMapping("cart") public String showMyCart(HttpSession session,Model model)
	 * { userBean uBean=(userBean) session.getAttribute("user"); int
	 * userId=uBean.getId(); List<cartBean> cartList=productrepo.getCart(userId);
	 * model.addAttribute("cartList", cartList); return "cart"; }
	 */
}
