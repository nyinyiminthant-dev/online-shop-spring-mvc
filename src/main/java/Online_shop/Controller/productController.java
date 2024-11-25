package Online_shop.Controller;

import java.io.File;   
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import Online_shop.Model.categoryBean;
import Online_shop.Model.productBean;

import Online_shop.Repository.categoryRepository;

import Online_shop.Repository.productRepository;

@Controller
public class productController {
    
    @Autowired
    private productRepository productRepository;

    @Autowired
    private categoryRepository categoryrepository;
    

    
   

    @GetMapping(value = "/product")
    public ModelAndView product(@RequestParam(value = "c_id", defaultValue = "0") int categoryId) {
        ModelAndView mav = new ModelAndView("addProduct");

        // Retrieve product list based on the category (0 means all products)
        List<productBean> productList;
        if (categoryId == 0) {
            productList = productRepository.getProductsByCategoryId(categoryId); // Show all products
        } else {
            productList = productRepository.getProductsByCategoryId(categoryId); // Show products for the specific category
        }

        // Retrieve category list
        List<categoryBean> categoryList = categoryrepository.getCategories();

        // Add data to ModelAndView
        mav.addObject("productList", productList);
        mav.addObject("categoryList", categoryList);
        mav.addObject("productObj", new productBean()); // For adding new product if needed

        return mav;
    }


    @PostMapping(value = "/addProduct")
    public String addedProduct(@Valid @ModelAttribute("productObj") productBean bean, BindingResult br,
                               ModelMap map, RedirectAttributes redirectAttrs) {

    	
    	 if (productRepository.productExists(bean.getP_name())) {
 	        // Use RedirectAttributes to pass error message
 	    	redirectAttrs.addFlashAttribute("error", "Product already exists!");

 	        return "redirect:/product";  // Redirect to the category page
 	    }
    	
        // Validation errors checking
        if (br.hasErrors()) {
            map.addAttribute("categoryList", categoryrepository.getCategories());
            map.addAttribute("cerror", "Please fill in all required fields correctly.");
            return "addProduct";
        }

        // Check if category is selected
        if (bean.getC_id() == null || bean.getC_id() == 0) {
            map.addAttribute("categoryList", categoryrepository.getCategories());
            map.addAttribute("cerror", "Please select a category.");
            return "addProduct";
        }

        
        
        
        
        // Handle image file upload
	    MultipartFile[] images = bean.getPhoto();
	    if (images != null && images.length > 0) {
	        String uploadDir = "D:\\Manvanlesson\\Online_shop\\src\\main\\webapp\\upload";
	        File uploadFolder = new File(uploadDir);
	        if (!uploadFolder.exists()) {
	            uploadFolder.mkdirs();  // Create the folder if it doesn't exist
	        }

	        try {
	            StringBuilder photoPaths = new StringBuilder();
	            for (MultipartFile image : images) {
	                if (!image.isEmpty()) {
	                    // Save the file to the upload directory
	                    String fileName = image.getOriginalFilename();
	                    File dest = new File(uploadDir + File.separator + fileName);
	                    image.transferTo(dest);

	                    // Append the file name to the photoPaths string
	                    if (photoPaths.length() > 0) {
	                        photoPaths.append(",");
	                    }
	                    photoPaths.append(fileName);
	                }
	            }
	            bean.setP_photo(photoPaths.toString());  // Set the photo paths in the CategoryBean
	        } catch (IOException e) {
	            e.printStackTrace();
	            map.addAttribute("message", "Image upload failed.");
	            return "viewCategory";
	        }
	    }
        // Insert the product into the database
        int result = productRepository.insertProduct(bean);
        if (result <= 0) {
            map.addAttribute("categoryList", categoryrepository.getCategories());
            map.addAttribute("beans", productRepository.getProductsByCategoryId(bean.getC_id()));
            map.addAttribute("productObj", bean); // Keep entered data
            map.addAttribute("errorMessage", "Failed to add product. Please try again.");
            return "addProduct";
        }

        // Success case
        redirectAttrs.addFlashAttribute("successMessage", "Product added successfully!");
        return "redirect:/product";
    }
    
    @GetMapping(value = "/viewProducts")
    public String viewProductsByCategory(
            @RequestParam(value = "c_id", required = false) Integer categoryId,
            HttpSession session,
            ModelMap map) {

        // If categoryId is null or 0, use the one from the session
        if (categoryId == null || categoryId == 0) {
            categoryId = (Integer) session.getAttribute("categoryId");
            if (categoryId == null) {
                map.addAttribute("message", "Please select a valid category.");
                map.addAttribute("productList", new ArrayList<>()); // Empty list
                return "viewProducts";
            }
        }

        // Store the categoryId in the session
        session.setAttribute("categoryId", categoryId);

        // Retrieve products based on categoryId
        List<productBean> productList = productRepository.getProductsByCategoryId(categoryId);
        map.addAttribute("productList", productList);
        map.addAttribute("categoryId", categoryId);

        // Fetch the selected category
        categoryBean selectedCategory = categoryrepository.getById(categoryId);
        map.addAttribute("selectedCategory", selectedCategory);

        // Check if product list is empty
        if (productList.isEmpty()) {
            map.addAttribute("message", "No products found for this category.");
        }

        return "viewProducts";
    }


    
    
    @GetMapping("/deleteProduct/{id}")
    public String deleteProduct(@PathVariable("id") int id, HttpSession session) {
        productRepository.deleteProductById(id);

        // Retrieve categoryId from session for redirect
        Integer categoryId = (Integer) session.getAttribute("categoryId");
        if (categoryId == null) {
            categoryId = 0;
        }

        // Redirect to viewProducts with the categoryId from the session
        return "redirect:/viewProducts?c_id=" + categoryId;
    }


    @GetMapping(value = "/editProduct/{id}")
    public ModelAndView showEdit(@PathVariable int id) {
        productBean product = productRepository.getById(id);
        ModelAndView mav = new ModelAndView("editProduct");
        mav.addObject("productObj", product);
        System.out.println("Product Name: " + product.getP_name());
        System.out.println("Description: " + product.getDescription());
        System.out.println("Quantity: " + product.getQuantity());
        System.out.println("Price: " + product.getPrice());
        return mav;
    }

    @PostMapping(value = "/updateProduct/{id}")
    public String editProduct(@ModelAttribute("productObj") productBean bean, BindingResult br,
                              @PathVariable("id") int id, ModelMap map, RedirectAttributes redirectAttrs, HttpSession session) {

        if (br.hasErrors()) {
            map.addAttribute("productObj", bean);
            return "editProduct";
        }

        // Retrieve the existing product if no new image is uploaded
        if (bean.getPhoto() == null || bean.getPhoto().length == 0 || bean.getPhoto()[0].isEmpty()) {
            productBean existingProduct = productRepository.getById(id);
            if (existingProduct != null) {
                bean.setP_photo(existingProduct.getP_photo());

                // Check c_id and set from session if null
                if (bean.getC_id() == null) {
                    Integer sessionCId = (Integer) session.getAttribute("categoryId");
                    if (sessionCId != null) {
                        bean.setC_id(sessionCId);
                    } else {
                        bean.setC_id(existingProduct.getC_id());
                    }
                }
            }
        } else {
            MultipartFile imageFile = bean.getPhoto()[0];
            if (!imageFile.isEmpty()) {
                try {
                    String uploadDir = "D:\\Manvanlesson\\Online_shop\\src\\main\\webapp\\upload";
                    File uploadFolder = new File(uploadDir);
                    if (!uploadFolder.exists()) {
                        uploadFolder.mkdirs();
                    }

                    String fileName = imageFile.getOriginalFilename();
                    File destinationFile = new File(uploadFolder, fileName);
                    imageFile.transferTo(destinationFile);

                    bean.setP_photo(fileName);
                } catch (Exception e) {
                    map.addAttribute("error", "Image upload failed: " + e.getMessage());
                    return "editProduct";
                }
            }
        }

        // Debugging: Log c_id and p_photo values before update
        System.out.println("c_id: " + bean.getC_id());
        System.out.println("p_photo: " + bean.getP_photo());

        // Update product and check result
        int result = productRepository.updateProduct(bean);
        if (result == 0) {
            map.addAttribute("productObj", bean);
            map.addAttribute("error", "Failed to update the product.");
            return "editProduct";
        }

        // Set categoryId in session if not set already
        if (session.getAttribute("categoryId") == null) {
            session.setAttribute("categoryId", bean.getC_id());
        }

        // Redirect to /viewProducts with the categoryId from the session
        Integer categoryId = (Integer) session.getAttribute("categoryId");
        redirectAttrs.addFlashAttribute("successMessage", "Product updated successfully!");
        return "redirect:/viewProducts?c_id=" + categoryId;
    }

    
    
    
   

    
 

	/*
	 * @PostMapping("/addToCart") public String addToCart(@ModelAttribute
	 * productBean product, HttpSession session) { // Assuming you have a cart in
	 * session Cart cart = (Cart) session.getAttribute("cart"); if (cart == null) {
	 * cart = new Cart(); session.setAttribute("cart", cart); }
	 * 
	 * cart.addProduct(product); return "redirect:/products"; // Redirect back to
	 * product list page }
	 */
   
    @GetMapping(value = "/shop")
    public ModelAndView category(@RequestParam(value = "c_id", defaultValue = "0") int categoryId) {
        // Create ModelAndView instance with the category view name
        ModelAndView mav = new ModelAndView("category");

        // Retrieve product list based on the category (0 means all products)
        List<productBean> productList;
        if (categoryId == 0) {
            // Fetch all products if no specific category is selected
            productList = productRepository.getAllProducts();
        } else {
            // Fetch products for the selected category
            productList = productRepository.getProductsByCategoryId(categoryId);
        }

        // Retrieve the list of all categories
        List<categoryBean> categoryList = categoryrepository.getCategories();

        // Add data to ModelAndView for rendering in the JSP
        mav.addObject("productList", productList); // List of products
        mav.addObject("categoryList", categoryList); // List of categories
        mav.addObject("productObj", new productBean()); // For adding a new product if needed
        mav.addObject("selectedCategoryId", categoryId); // To pre-select the category in the JSP

        return mav; // Return ModelAndView to display the category.jsp page
    }
    
    
    @GetMapping("/viewProductsuser")
    public String viewProducts(@RequestParam("c_id") int categoryId, ModelMap map) {
        // Fetch products based on the category ID
        List<productBean> productList = productRepository.getProductsByCategoryId(categoryId);
        
        // Fetch category data if needed (for example, to show category name on the page)
        categoryBean selectedCategory = categoryrepository.getById(categoryId);
        
        // Add the product list and selected category to the model
        map.addAttribute("productList", productList);
        List<categoryBean> categoryList = categoryrepository.getCategories();
        map.addAttribute("categoryList", categoryList);
        map.addAttribute("selectedCategory", selectedCategory);
       

        return "category"; // Return the view name (the JSP for displaying products)
    }



}
