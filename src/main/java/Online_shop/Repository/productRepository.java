package Online_shop.Repository;

import java.sql.Connection;  
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import Online_shop.Model.cartBean;
import Online_shop.Model.productBean;

public class productRepository {

	public int insertProduct(productBean bean) {
	    int i = 0;
	    String sql = "INSERT INTO product (p_name, description, price,quantity, p_photo, c_id) VALUES (?, ?, ?, ?, ?,?)";
	    try (Connection con = myConnection.getConnection();
	         PreparedStatement ps = con.prepareStatement(sql)) {

	        // Set product details from the bean
	        ps.setString(1, bean.getP_name());
	        ps.setString(2, bean.getDescription());
	        ps.setDouble(3, bean.getPrice());
	        ps.setInt(4, bean.getQuantity());
	        ps.setString(5, bean.getP_photo());
	        ps.setInt(6, bean.getC_id()); // Set the selected category ID

	        // Execute the insert query
	        i = ps.executeUpdate();
	    } catch (Exception e) {
	        e.printStackTrace();
	    }

	    return i;
	}


	 public boolean productExists(String p_name) {
	        boolean exists = false;
	        String sql = "SELECT COUNT(*) FROM product WHERE p_name = ?";

	        try (Connection con = myConnection.getConnection();
	             PreparedStatement ps = con.prepareStatement(sql)) {

	            ps.setString(1, p_name);
	            ResultSet rs = ps.executeQuery();

	            if (rs.next()) {
	                exists = rs.getInt(1) > 0; // If count is greater than 0, the email exists
	            }

	        } catch (SQLException e) {
	            System.out.println("Error checking email existence: " + e.getMessage());
	        }

	        return exists;
	    }
	
	
	 public List<productBean> getProductsByCategoryId(int categoryId) {
	        List<productBean> products = new ArrayList<>();
	        String query = "SELECT * FROM product WHERE c_id = ?";

	        try (Connection conn = myConnection.getConnection();
	             PreparedStatement ps = conn.prepareStatement(query)) {

	            ps.setInt(1, categoryId);
	            ResultSet rs = ps.executeQuery();

	            while (rs.next()) {
	                productBean product = new productBean();
	                product.setId(rs.getInt("id"));
	                product.setP_name(rs.getString("p_name"));
	                product.setDescription(rs.getString("description"));
	                product.setPrice(rs.getDouble("price"));
	                product.setQuantity(rs.getInt("quantity"));
	                product.setP_photo(rs.getString("p_photo"));
	                products.add(product);
	            }
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }

	        return products;
	    }
	
	 
	 public int deleteProductById(int id) {
			int result = 0;
			Connection con = myConnection.getConnection();
			String sql ="DELETE FROM product WHERE id = ?";
			try {
				PreparedStatement ps = con.prepareStatement(sql);
				
				
				ps.setInt(1 , id);
				result = ps.executeUpdate();		
				
			}catch(Exception e) {
				result = 0;
				
			}
			
			return result;
		}
	 
	 
	 public productBean getById(int id) {
		  productBean bean = null;
		  Connection con = myConnection.getConnection();
		  String sql = "SELECT * FROM product WHERE id = ?";
		  try {
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, id);
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				bean = new productBean();
				bean.setId(rs.getInt("id"));
				bean.setP_name(rs.getString("p_name"));
				bean.setP_photo(rs.getString("p_photo"));
				bean.setDescription(rs.getString("description"));
				bean.setQuantity(rs.getInt("quantity"));
				bean.setPrice(rs.getDouble("price"));
				//System.out.println("Get by id successful");
				
			}
		} catch (Exception e) {
			e.getMessage();
			//System.out.println("Get By Id Error : " + e.getMessage());
		}
		  return bean;
	  }
	 
	 
	 
	 public int updateProduct(productBean bean) {
		    int i = 0;
		    Connection con = myConnection.getConnection();

		    String sql = "UPDATE product SET p_name = ?, description = ?, price = ?, quantity = ?, p_photo = ?, c_id = ? WHERE id = ?";

		    try {
		        PreparedStatement ps = con.prepareStatement(sql);
		        ps.setString(1, bean.getP_name());
		        ps.setString(2, bean.getDescription());
		        ps.setDouble(3, bean.getPrice());
		        ps.setInt(4, bean.getQuantity());
		        ps.setString(5, bean.getP_photo());

		        // Handle c_id, set to NULL if bean.getC_id() is null
		        if (bean.getC_id() == null) {
		            ps.setNull(6, java.sql.Types.INTEGER);
		        } else {
		            ps.setInt(6, bean.getC_id());
		        }

		        ps.setInt(7, bean.getId());

		        i = ps.executeUpdate();

		        if (i > 0) {
		            System.out.println("Update successful");
		        } else {
		            System.out.println("No rows updated");
		        }
		    } catch (Exception e) {
		        System.out.println("Update Error: " + e.getMessage());
		        System.out.println("Update failed");
		    }

		    return i;
		}


	public List<productBean> getAllProducts() {
		 List<productBean> products = new ArrayList<>();
	        String query = "SELECT * FROM product";

	        try (Connection conn = myConnection.getConnection();
	             PreparedStatement ps = conn.prepareStatement(query)) {

	           
	            ResultSet rs = ps.executeQuery();

	            while (rs.next()) {
	                productBean product = new productBean();
	                product.setId(rs.getInt("id"));
	                product.setP_name(rs.getString("p_name"));
	                product.setDescription(rs.getString("description"));
	                product.setPrice(rs.getDouble("price"));
	                product.setQuantity(rs.getInt("quantity"));
	                product.setP_photo(rs.getString("p_photo"));
	                products.add(product);
	            }
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }

	        return products;
	}

	
	
	
	public int inserttoCart(int productId,int userId) {
	    int i=0;
	    Connection con=myConnection.getConnection();
	    String query="SELECT * FROM cart WHERE product_id=? AND user_id=?;";
	    try {
	      PreparedStatement ps=con.prepareStatement(query);
	      ps.setInt(1, productId);
	      ps.setInt(2, userId);
	      ResultSet rs=ps.executeQuery();
	      if(rs.next()) {
	        int quantity=rs.getInt("quantity");
	        quantity++;
	         query="UPDATE cart SET quantity=? WHERE product_id=?;";
	         ps=con.prepareStatement(query);
	        ps.setInt(1, quantity);
	        ps.setInt(2, productId);
	        i=ps.executeUpdate();
	      }else {
	          query="INSERT INTO cart (product_id,user_id) VALUES (?,?);";
	         ps=con.prepareStatement(query);
	        ps.setInt(1, productId);
	        ps.setInt(2, userId);
	        i=ps.executeUpdate();
	      }
	    } catch (SQLException e) {
	      // TODO Auto-generated catch block
	      e.printStackTrace();
	    }
	    return i;
	  }
	
	public int getCategoryIdByProductId(int productId) {
		int categoryId=0;
		Connection con=myConnection.getConnection();
	    String query="SELECT c_id FROM product WHERE id=?;";
	    try {
			PreparedStatement ps=con.prepareStatement(query);
			ps.setInt(1, productId);
			ResultSet rs=ps.executeQuery();
			if(rs.next()) {
				categoryId=rs.getInt(1);
			}
		} catch (SQLException e) {
			System.out.println("Get Category Id Error "+e.getMessage());
		}
		return categoryId;
	}
	
	public List<cartBean> getCart(int userId){
		List<cartBean> cartList=new ArrayList<cartBean>();
		cartBean cBean=null;
		Connection con=myConnection.getConnection();
	    String query="SElECT * FROM cart INNER JOIN product ON cart.product_id=product.id WHERE user_id=?;";
		try {
			PreparedStatement ps=con.prepareStatement(query);
			ps.setInt(1, userId);
			ResultSet rs=ps.executeQuery();
			while(rs.next()) {
				cBean=new cartBean();
				cBean.setProduct_id(rs.getInt("product_id"));
				cBean.setProductName(rs.getString("p_name"));
				cBean.setProductPhoto(rs.getString("p_photo"));
				cBean.setProductPrice(rs.getDouble("price"));
				cBean.setQuantity(rs.getInt("quantity"));
				int productQuantity=rs.getInt("quantity");
				double productPrice=rs.getDouble("price");
				double totalPrice=productPrice * productQuantity;
				cBean.setTotalPrice(totalPrice);
				cartList.add(cBean);
			}
		} catch (SQLException e) {
			System.out.println("Get Cart Error "+e.getMessage());
		}
	    return cartList;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
