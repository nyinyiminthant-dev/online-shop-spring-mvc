package Online_shop.Model;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class productBean {
	private int id;
	private String p_name;
	private String description;
	private double price;
	private int quantity;
	
	  private MultipartFile[] photo;  
	    private String p_photo; 
	
	private Integer c_id;
	private String c_name;
}
