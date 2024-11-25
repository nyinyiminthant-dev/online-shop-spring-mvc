package Online_shop.Model;

import lombok.Data;

@Data
public class cartBean {

	
	   private int id;
	    private int user_id;
	    private int product_id;
	   
	    private int quantity;
	    private int c_id;
	    
	    private String productName;
	    private String productPhoto;
	    private double productPrice;
	    private double totalPrice;
	    
}
