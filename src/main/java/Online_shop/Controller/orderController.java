package Online_shop.Controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;

import Online_shop.Model.orderBean;
import Online_shop.Model.orderDetailBean;
import Online_shop.Model.userBean;
import Online_shop.Repository.orderRepository;

@Controller
public class orderController {

    @Autowired
    HttpSession session;

    @Autowired
    orderRepository orderRepository;

    @PostMapping(value = "/update_order", consumes = "application/json", produces = "application/json")
    public ResponseEntity<Map<String, String>> updateOrder(@RequestBody orderBean orderRequest,
                                                            HttpServletRequest request) {
        System.out.println("Received Content-Type: " + request.getContentType());

        Map<String, String> response = new HashMap<>();
        try {
            userBean userBean = (userBean) session.getAttribute("user");

            if (userBean == null) {
                response.put("status", "error");
                response.put("message", "User is not logged in or session expired.");
                return ResponseEntity.badRequest().body(response);
            }

            int userId = userBean.getId();
            String address = orderRequest.getAddress();
            String paypaymentMethod = orderRequest.getPaypaymentMethod();

            if (address == null || address.isEmpty()) {
                response.put("status", "error");
                response.put("message", "Address is required.");
                return ResponseEntity.badRequest().body(response);
            }

            // Insert the order and get the generated order ID
            int orderId = orderRepository.insertOrder(userId, address,paypaymentMethod);

            if (orderId > 0) {
                // Now add order details (assuming orderRequest has the correct order details)
                for (orderDetailBean detail : orderRequest.getOrderDetails()) {
                    detail.setOrder_id(orderId); // Set the generated order ID in order details
                    boolean isInserted = orderRepository.insertOrderDetail(detail, orderId);

                    if (!isInserted) {
                        response.put("status", "error");
                        response.put("message", "Failed to insert order details.");
                        return ResponseEntity.badRequest().body(response);
                    }
                }

                response.put("status", "success");
                response.put("message", "Order successfully created with ID: " + orderId);
            } else {
                response.put("status", "error");
                response.put("message", "Failed to create order.");
            }

            return ResponseEntity.ok(response);

        } catch (Exception e) {
            e.printStackTrace();
            response.put("status", "error");
            response.put("message", "An error occurred while processing the order.");
            return ResponseEntity.status(500).body(response);
        }
    }
}
