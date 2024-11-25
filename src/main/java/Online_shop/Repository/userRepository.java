package Online_shop.Repository;

import java.sql.Connection;    
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import Online_shop.Model.loginBean;
import Online_shop.Model.userBean;



public class userRepository {
	public int insertUser(userBean bean) {
	    int i = 0;
	    Connection con = myConnection.getConnection();

	    // Email already exists check
	    if (emailExists(bean.getEmail())) {
	        System.out.println("Email already exists: " + bean.getEmail());
	        return i; // Return 0 if email already exists
	    }

	    String sql = "INSERT INTO user (email, password) VALUES (?, ?)";
	    try (PreparedStatement ps = con.prepareStatement(sql)) {
	        ps.setString(1, bean.getEmail());
	        ps.setString(2, bean.getPassword());
	        i = ps.executeUpdate();
	    } catch (Exception e) {
	        System.out.println("Error inserting user: " + e.getMessage());
	    }

	    return i;
	}

	
	
	 public boolean emailExists(String email) {
	        boolean exists = false;
	        String sql = "SELECT COUNT(*) FROM user WHERE email = ?";

	        try (Connection con = myConnection.getConnection();
	             PreparedStatement ps = con.prepareStatement(sql)) {

	            ps.setString(1, email);
	            ResultSet rs = ps.executeQuery();

	            if (rs.next()) {
	                exists = rs.getInt(1) > 0; // If count is greater than 0, the email exists
	            }

	        } catch (SQLException e) {
	            System.out.println("Error checking email existence: " + e.getMessage());
	        }

	        return exists;
	    }
	 
	 
	 
	 public userBean login(loginBean login) {
		    userBean user = null;
		    String sql = "SELECT * FROM user WHERE email = ? AND password = ?";
		    try (Connection con = myConnection.getConnection();
		         PreparedStatement ps = con.prepareStatement(sql)) {
		         
		        ps.setString(1, login.getEmail());
		        ps.setString(2, login.getPassword());
		        try (ResultSet rs = ps.executeQuery()) {
		            if (rs.next()) {
		                user = new userBean();
		                user.setId(rs.getInt("id"));
		                user.setEmail(rs.getString("email"));
		                user.setPassword(rs.getString("password"));
		                user.setRole(rs.getString("role"));  // Ensure the role is set here
		            }
		        }
		    } catch (SQLException e) {
		        e.printStackTrace();
		        System.out.println("Error logging in user: " + e.getMessage());
		    }
		    return user;
		}

	 
	 
   public List<userBean> getUsers() {
	   List<userBean> beans = new ArrayList<userBean>();
	   Connection con = myConnection.getConnection();
	   String sql = "SELECT * FROM user WHERE role = 'user'";
	   try {
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		while(rs.next()) {
			userBean bean = new userBean();
			bean.setId(rs.getInt("id"));
			bean.setEmail(rs.getString("email"));
			beans.add(bean);
		}
	} catch (Exception e) {
		System.out.println(e.getMessage());
	}
	   return beans;
   }
	 
	 
   public int deleteUserById(int id) {
			int result = 0;
			Connection con = myConnection.getConnection();
			String sql ="DELETE FROM user WHERE id = ?";
			try {
				PreparedStatement ps = con.prepareStatement(sql);
				//ps.setBoolean(1, book.is_delete());
				
				ps.setInt(1 , id);
				result = ps.executeUpdate();		
				
			}catch(Exception e) {
				result = 0;
				
			}
			
			return result;
		}
	
	 
}
