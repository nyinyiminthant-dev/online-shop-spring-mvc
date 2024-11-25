package Online_shop.Model;

import java.util.List;

import lombok.Data;

@Data
public class orderBean {

	private List<orderDetailBean> orderDetails;
	private int id;
	private String  address;
	private String paypaymentMethod;
	 
}
