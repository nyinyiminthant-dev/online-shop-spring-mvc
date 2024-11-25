package Online_shop.Controller;

import java.io.File;    
import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;



import Online_shop.Model.categoryBean;
import Online_shop.Repository.categoryRepository;



@Controller
public class categoryController {
	
	@Autowired
	private categoryRepository categoryrepository;

	@GetMapping(value = "/category")
	public ModelAndView viewCategory() {
	    ModelAndView mav = new ModelAndView("viewCategory"); // Specify the view name

	    // Retrieve category list from the repository
	    List<categoryBean> categoryList = categoryrepository.getCategories();

	    // Add the category list and new category object to ModelAndView
	    mav.addObject("categoryList", categoryList);
	    mav.addObject("categoryObj", new categoryBean());

	    return mav; // Return ModelAndView
	}


	@PostMapping("/addCategory")
	public String addCategory(
	        @Valid @ModelAttribute("categoryObj") categoryBean bean, BindingResult br,
	        ModelMap map, RedirectAttributes redirectAttrs, HttpSession session) {

	    // Check if the category already exists
	    if (categoryRepository.categoryExists(bean.getC_name())) {
	        // Use RedirectAttributes to pass error message
	    	redirectAttrs.addFlashAttribute("error", "Category already exists!");

	        return "redirect:/category";  // Redirect to the category page
	    }

	    // If there are validation errors, return to the viewCategory page with the error message
	    if (br.hasErrors()) {
	        map.addAttribute("message", "Please correct the errors below.");
	        return "viewCategory";
	    }

	    // Debugging the values before proceeding
	    System.out.println("Category Name in Controller: " + bean.getC_name());
	    System.out.println("Category Photo Paths in Controller: " + bean.getC_photo());

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
	            bean.setC_photo(photoPaths.toString());  // Set the photo paths in the CategoryBean
	        } catch (IOException e) {
	            e.printStackTrace();
	            map.addAttribute("message", "Image upload failed.");
	            return "viewCategory";
	        }
	    }

	    // Insert category into the database
	    int i = categoryRepository.insertCategory(bean);
	    if (i > 0) {
	        redirectAttrs.addFlashAttribute("successMessage", "Category added successfully!");
	        return "redirect:/category";  // Redirect to the category list page after successful insert
	    } else {
	        map.addAttribute("message", "Failed to add category!");
	        return "viewCategory";  // Return to the category form page if insert failed
	    }
	}

	
	@GetMapping("/deleteCategory/{categoryId}")
	public String deleteCategory(@PathVariable("categoryId") int categoryId, Model model) {
	    // Call repository method to delete category
	    categoryrepository.deleteCategoryById(categoryId);

	    // Add a success message to the model
	    model.addAttribute("message", "Category deleted successfully.");

	    // Redirect to the category list page after deletion
	    return "redirect:/category"; // Adjust URL if needed
	}

	
	
	  @GetMapping(value="/editCategory/{id}")
	  public ModelAndView showEdit(@PathVariable int id) {
		  categoryBean bean = categoryrepository.getById(id);
		 
		  ModelAndView mv = new ModelAndView("editCategory","categoryObj",bean);
		  
		  return mv;
	  }


	  @PostMapping(value = "/editcategory/{id}")
	  public String editCategory(@ModelAttribute("categoryObj") categoryBean bean, BindingResult br,
	                             @PathVariable("id") int id, ModelMap map, RedirectAttributes redirectAttrs) {

	      // Check for validation errors
	      if (br.hasErrors()) {
	          map.addAttribute("categoryObj", bean);
	          return "editCategory";
	      }

	      // Check if no new image is uploaded
	      if (bean.getPhoto() == null || bean.getPhoto().length == 0 || bean.getPhoto()[0].isEmpty()) {
	          // Retain the existing image if no new image is uploaded
	          categoryBean existingCategory = categoryrepository.getById(id);
	          bean.setC_photo(existingCategory.getC_photo());
	      } else {
	          // Handle image upload
	          MultipartFile[] images = bean.getPhoto();
	          if (images != null && images.length > 0) {
	              MultipartFile imageFile = images[0]; // Get the first uploaded file
	              if (!imageFile.isEmpty()) {
	                  try {
	                      String uploadDir = "D:\\Manvanlesson\\Online_shop\\src\\main\\webapp\\upload";
	                      File uploadFolder = new File(uploadDir);
	                      if (!uploadFolder.exists()) {
	                          uploadFolder.mkdirs(); // Create the folder if it doesn't exist
	                      }

	                      // Save the uploaded file
	                      String fileName = imageFile.getOriginalFilename();
	                      File destinationFile = new File(uploadFolder, fileName);
	                      imageFile.transferTo(destinationFile);

	                      // Set the new photo path
	                      bean.setC_photo(fileName);
	                  } catch (Exception e) {
	                      map.addAttribute("error", "Image upload failed: " + e.getMessage());
	                      return "editCategory";
	                  }
	              }
	          }
	      }

	      // Attempt to update the category
	      int result = categoryrepository.updateCategory(bean);

	      // Check if the update was successful
	      if (result == 0) {
	          map.addAttribute("categoryObj", bean);
	          map.addAttribute("error", "Failed to update the category.");
	          return "editCategory";
	      }

	      // Success: Redirect to the category list with a success message
	      redirectAttrs.addFlashAttribute("successMessage", "Category updated successfully.");
	      return "redirect:/category";
	  }


	  }


