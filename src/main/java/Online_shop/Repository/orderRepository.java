package Online_shop.Repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import Online_shop.Model.orderDetailBean;

public class orderRepository {

    // Method to insert an order
    public int insertOrder(int userId, String address, String paypaymentMethod) {
        String sql = "INSERT INTO `order` (user_id, address,paypaymentMethod) VALUES (?, ?,?)";
        int generatedOrderId = -1;

        try (Connection con = myConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS)) {

            // Set user ID and address
            ps.setInt(1, userId);
            ps.setString(2, address);
            ps.setString(3,paypaymentMethod);

            // Execute the insert statement
            int rowsAffected = ps.executeUpdate();

            if (rowsAffected > 0) {
                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) {
                        generatedOrderId = rs.getInt(1);
                    }
                }
            }

        } catch (SQLException e) {
            System.out.println("Insert Order error: " + e.getMessage());
        }

        return generatedOrderId;
    }

    public boolean insertOrderDetail(orderDetailBean orderDetail, int orderId) {
        String sql = "INSERT INTO order_detail (order_id, product_id, quantity, price) VALUES (?, ?, ?, ?)";
        try (Connection con = myConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            // Debugging
            System.out.println("Order ID: " + orderId);
            System.out.println("Product ID: " + orderDetail.getId());
            System.out.println("Quantity: " + orderDetail.getQuantity());
            System.out.println("Price: " + orderDetail.getPrice());

            // Set parameters for the prepared statement
            ps.setInt(1, orderId);
            ps.setInt(2, orderDetail.getId());
            ps.setInt(3, orderDetail.getQuantity());
            ps.setDouble(4, orderDetail.getPrice());

            int rowsAffected = ps.executeUpdate();

            return rowsAffected > 0;
        } catch (SQLException e) {
            System.out.println("Insert Order Detail error: " + e.getMessage());
            return false;
        }
    }


}
