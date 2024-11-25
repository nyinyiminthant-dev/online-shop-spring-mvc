package Online_shop.Model;



import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class categoryBean {

	
	private int id;
	
	
	private String c_name;
	
	
	private MultipartFile[] photo;
	private String c_photo;
}
