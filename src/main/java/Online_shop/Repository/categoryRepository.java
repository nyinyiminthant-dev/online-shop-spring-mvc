package Online_shop.Repository;

import java.sql.Connection; 
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;



import Online_shop.Model.categoryBean;


public class categoryRepository {

	
	public static int insertCategory(categoryBean bean) {
		int i = 0;
		Connection con = myConnection.getConnection();
		String sql = "INSERT INTO category (c_name, c_photo) VALUES (?,?)";
		try {
			PreparedStatement ps = con.prepareStatement(sql);
			
			ps.setString(1, bean.getC_name());
			ps.setString(2, bean.getC_photo());
			
			i = ps.executeUpdate();
			
			System.out.println("insert successful");
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		
		return i;
		
	}
	
	 public List<categoryBean> getCategories() {
		   List<categoryBean> beans = new ArrayList<categoryBean>();
		   Connection con = myConnection.getConnection();
		   String sql = "SELECT * FROM category";
		   try {
			PreparedStatement ps = con.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				categoryBean bean = new categoryBean();
				bean.setId(rs.getInt("id"));
				bean.setC_name(rs.getString("c_name"));
				bean.setC_photo(rs.getString("c_photo"));
				beans.add(bean);
				
			}
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		   return beans;
	   }
	 
	 
	 public int deleteCategoryById(int id) {
			int result = 0;
			Connection con = myConnection.getConnection();
			String sql ="DELETE FROM category WHERE id = ?";
			try {
				PreparedStatement ps = con.prepareStatement(sql);
				
				
				ps.setInt(1 , id);
				result = ps.executeUpdate();		
				
			}catch(Exception e) {
				result = 0;
				
			}
			
			return result;
		}
	
	 
	 public static boolean categoryExists(String c_name) {
	        boolean exists = false;
	        String sql = "SELECT COUNT(*) FROM category WHERE c_name = ?";

	        try (Connection con = myConnection.getConnection();
	             PreparedStatement ps = con.prepareStatement(sql)) {

	            ps.setString(1, c_name);
	            ResultSet rs = ps.executeQuery();

	            if (rs.next()) {
	                exists = rs.getInt(1) > 0; // If count is greater than 0, the email exists
	            }

	        } catch (SQLException e) {
	            System.out.println("Error checking email existence: " + e.getMessage());
	        }

	        return exists;
	    }
	 
	 
	 public categoryBean getById(int id) {
		  categoryBean bean = null;
		  Connection con = myConnection.getConnection();
		  String sql = "SELECT * FROM category WHERE id = ?";
		  try {
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, id);
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				bean = new categoryBean();
				bean.setId(rs.getInt("id"));
				bean.setC_name(rs.getString("c_name"));
				bean.setC_photo(rs.getString("c_photo"));
				//System.out.println("Get by id successful");
				
			}
		} catch (Exception e) {
			e.getMessage();
			//System.out.println("Get By Id Error : " + e.getMessage());
		}
		  return bean;
	  }
	 
	 
	 
	 public int updateCategory(categoryBean bean) {
		    int i = 0;
		    Connection con = myConnection.getConnection();

		    // Corrected SQL query for updating category
		    String sql = "UPDATE category SET c_name = ?, c_photo = ? WHERE id = ?";

		    try {
		        PreparedStatement ps = con.prepareStatement(sql);

		       
		        ps.setString(1, bean.getC_name());  
		        ps.setString(2, bean.getC_photo());  
		        ps.setInt(3, bean.getId());      

		        i = ps.executeUpdate();

		       
		        if (i > 0) {
		            System.out.println("Update successful");
		        } else {
		            System.out.println("No rows updated");
		        }
		    } catch (Exception e) {
		        System.out.println(e.getMessage());
		    }

		    return i; 
		}

	  
}
