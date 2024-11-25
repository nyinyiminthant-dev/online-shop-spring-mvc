package Online_shop.Model;

import javax.validation.constraints.NotEmpty;

import lombok.Data;

@Data
public class userBean {

	private int id;
	@NotEmpty(message="Fill the email")
	private String email;
	@NotEmpty(message="Fill the password")
	private String password;
	private String confirmPassword;
	private String role;
}
