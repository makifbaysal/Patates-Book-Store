package com.patates.webapi.Repositories.Firebase;

import com.google.api.core.ApiFuture;
import com.google.cloud.firestore.DocumentReference;
import com.google.cloud.firestore.DocumentSnapshot;
import com.google.cloud.firestore.QueryDocumentSnapshot;
import com.patates.webapi.Enums.OrderEnum;
import com.patates.webapi.Models.Order.*;
import org.springframework.web.bind.annotation.RequestBody;

import java.util.*;
import java.util.concurrent.ExecutionException;

public class OrderRepository extends FirebaseConnection {
    PaymentRepository paymentRepository = new PaymentRepository();

    public String createOrder(@RequestBody CreateOrderInputDTO createOrderInputDTO) throws ExecutionException, InterruptedException {
        ApiFuture<String> futureTransaction = db.runTransaction(transaction -> {
            Map<String, Object> data = new HashMap<>();
            double couponDiscount = 0;
            if (createOrderInputDTO.getCoupon() != null) {
                List<QueryDocumentSnapshot> documentsCodes = db.collection("couponCodes").whereEqualTo("state", true).whereEqualTo("code", createOrderInputDTO.getCoupon()).get().get().getDocuments();
                if (documentsCodes.isEmpty()) {
                    return "Invalid Code";
                } else {
                    if (documentsCodes.get(0).getDate("expireTime").compareTo(new Date()) != 1 || documentsCodes.get(0).getDate("startTime").compareTo(new Date()) != -1 || documentsCodes.get(0).getLong("remainingQuantity") <= 0) {
                        return "Invalid Code";
                    }
                }

                DocumentReference docCodeRef = documentsCodes.get(0).getReference();


                data.put("remainingQuantity", documentsCodes.get(0).getLong("remainingQuantity").intValue() - 1);
                transaction.update(docCodeRef, data);
                couponDiscount = documentsCodes.get(0).getDouble("percentageDiscount");
            }

            if (!paymentRepository.makePayment(createOrderInputDTO.getCartId(), createOrderInputDTO.getAmountPaid())) {
                return "Insufficient Funds";
            }

            DocumentReference docRef = db.collection("orders").document();

            data.clear();
            data = new HashMap<>();

            data.put("userId", createOrderInputDTO.getUserId());

            DocumentSnapshot addressDetail = db.collection("users").document(createOrderInputDTO.getUserId()).collection("addresses").document(createOrderInputDTO.getAddressId()).get().get();

            data.put("address", addressDetail.getString("address") + " " + addressDetail.getString("county") + "/" + addressDetail.getString("city"));
            data.put("cartId", createOrderInputDTO.getCartId());
            if (createOrderInputDTO.getCoupon() != null) {
                data.put("coupon", createOrderInputDTO.getCoupon());
                data.put("couponDiscount", couponDiscount);
            }

            data.put("amountPaid", createOrderInputDTO.getAmountPaid());
            data.put("state", OrderEnum.WaitingForApproval.getValue());
            data.put("shippingCompanyId", createOrderInputDTO.getShippingCompanyId());
            data.put("date", new Date());

            transaction.set(docRef, data);

            DocumentReference userRef = db.collection("users").document(createOrderInputDTO.getUserId());

            List<QueryDocumentSnapshot> productList = userRef.collection("shoppingCart").get().get().getDocuments();

            for (QueryDocumentSnapshot document : productList) {

                DocumentReference orderProductRef = docRef.collection("products").document(document.getId());

                DocumentReference productRef = db.collection("products").document(document.getId());

                List<QueryDocumentSnapshot> priceList = productRef.collection("price").get().get().getDocuments();

                double price = priceList.get(priceList.size() - 1).getDouble("price");

                Map<String, Object> orderProductData = new HashMap<>();

                orderProductData.put("quantity", document.getLong("quantity").intValue());
                orderProductData.put("price", price);

                transaction.set(orderProductRef, orderProductData);

                transaction.delete(document.getReference());
            }

            return docRef.getId();

        });

        return futureTransaction.get();
    }

    public OrderDetailsOutputDTO orderDetails(String orderId) throws ExecutionException, InterruptedException {
        OrderDetailsOutputDTO orderDetailsOutputDTO = new OrderDetailsOutputDTO();

        DocumentSnapshot orderDocument = db.collection("orders").document(orderId).get().get();

        orderDetailsOutputDTO.setAddress(orderDocument.getString("address"));
        orderDetailsOutputDTO.setAmountPaid(orderDocument.getDouble("amountPaid"));


        if (orderDocument.getString("coupon") != null && orderDocument.getDouble("couponDiscount") != null) {
            orderDetailsOutputDTO.setCoupon(orderDocument.getString("coupon"));
            orderDetailsOutputDTO.setPercentageDiscount(orderDocument.getDouble("couponDiscount"));
        }

        DocumentSnapshot cartDocument = db.collection("creditCarts").document(orderDocument.getString("cartId")).get().get();
        orderDetailsOutputDTO.setCartNo(cartDocument.getString("cartNumber"));

        orderDetailsOutputDTO.setDate(orderDocument.getDate("date"));

        DocumentSnapshot shippingCompanyDocument = db.collection("shippingCompanies").document(orderDocument.getString("shippingCompanyId")).get().get();

        orderDetailsOutputDTO.setShippingCompany(shippingCompanyDocument.getString("name"));
        orderDetailsOutputDTO.setState(orderDocument.getLong("state").intValue());

        orderDetailsOutputDTO.setOrderNo(orderDocument.getId());


        List<QueryDocumentSnapshot> products = orderDocument.getReference().collection("products").get().get().getDocuments();


        List<OrderProductListingOutputDTO> orderProducts = new ArrayList<>();

        for (QueryDocumentSnapshot product : products) {
            OrderProductListingOutputDTO orderProduct = new OrderProductListingOutputDTO();

            orderProduct.setQuantity(product.getLong("quantity").intValue());
            orderProduct.setUnitPrice(product.getDouble("price"));

            DocumentSnapshot productDocument = db.collection("products").document(product.getId()).get().get();
            orderProduct.setProductId(product.getId());
            orderProduct.setName(productDocument.getString("name"));
            orderProduct.setAuthor(productDocument.getString("author"));
            orderProduct.setImageUrl(productDocument.getString("image-url"));
            orderProducts.add(orderProduct);
        }


        orderDetailsOutputDTO.setProducts(orderProducts);
        return orderDetailsOutputDTO;

    }

    public List<GetOrdersOutputDTO> getOrders(String state, String userId) throws ExecutionException, InterruptedException {
        List<GetOrdersOutputDTO> orderLists = new ArrayList<>();
        List<QueryDocumentSnapshot> orders;
        if (state.equals("") && userId.equals("")) {
            orders = db.collection("orders").get().get().getDocuments();
        } else if (!state.equals("") && userId.equals("")) {
            orders = db.collection("orders").whereEqualTo("state", Integer.parseInt(state)).get().get().getDocuments();
        } else if (state.equals("") && !userId.equals("")) {
            orders = db.collection("orders").whereEqualTo("userId", userId).get().get().getDocuments();
        } else {
            orders = db.collection("orders").whereEqualTo("state", Integer.parseInt(state)).whereEqualTo("userId", userId).get().get().getDocuments();
        }

        for (QueryDocumentSnapshot order : orders) {
            GetOrdersOutputDTO addOrder = new GetOrdersOutputDTO();

            addOrder.setAmountPaid(order.getDouble("amountPaid"));
            addOrder.setDate(order.getDate("date"));
            addOrder.setOrderId(order.getId());
            addOrder.setState(order.getLong("state").intValue());
            addOrder.setQuantity(order.getReference().collection("products").get().get().size());

            orderLists.add(addOrder);
        }
        return orderLists;

    }

    public String cancelOrder(CancelOrderInputDTO cancelOrderInputDTO) throws ExecutionException, InterruptedException {
        DocumentReference orderReference = db.collection("orders").document(cancelOrderInputDTO.getOrderId());

        Map<String, Object> data = new HashMap<>();

        data.put("state", OrderEnum.Cancelled.getValue());
        data.put("cancelDate", new Date());
        orderReference.update(data);

        return paymentRepository.refund(orderReference.get().get().getString("cartId"), orderReference.get().get().getDouble("amountPaid"));

    }

    public String acceptOrder(AcceptOrderInputDTO acceptOrderInputDTO) {
        DocumentReference orderReference = db.collection("orders").document(acceptOrderInputDTO.getOrderId());

        Map<String, Object> data = new HashMap<>();

        data.put("state", OrderEnum.Shipped.getValue());

        data.put("acceptDate", new Date());
        orderReference.update(data);
        return "Success";

    }

    public String refundOrder(RefundOrderInputDTO refundOrderInputDTO) throws ExecutionException, InterruptedException {
        DocumentReference orderReference = db.collection("orders").document(refundOrderInputDTO.getOrderId());

        Map<String, Object> data = new HashMap<>();

        data.put("state", OrderEnum.Refund.getValue());

        data.put("refundRequestDate", new Date());
        orderReference.update(data);
        return "Success";
    }

}
