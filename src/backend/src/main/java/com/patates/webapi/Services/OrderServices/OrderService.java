package com.patates.webapi.Services.OrderServices;

import com.patates.webapi.Models.Order.*;
import com.patates.webapi.Repositories.Firebase.OrderRepository;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestBody;

import java.util.List;
import java.util.concurrent.ExecutionException;

@Service
public class OrderService {
  private final OrderRepository orderRepository;

  public OrderService(OrderRepository orderRepository) {
    this.orderRepository = orderRepository;
  }

  public String createOrder(@RequestBody CreateOrderInputDTO createOrderInputDTO)
      throws ExecutionException, InterruptedException {
    return orderRepository.createOrder(createOrderInputDTO);
  }

  public OrderDetailsOutputDTO orderDetails(String orderId)
      throws ExecutionException, InterruptedException {
    return orderRepository.orderDetails(orderId);
  }

  public List<GetOrdersOutputDTO> getOrders(String state, String userId)
      throws ExecutionException, InterruptedException {
    return orderRepository.getOrders(state, userId);
  }

  public String cancelOrder(CancelOrderInputDTO cancelOrderInputDTO)
      throws ExecutionException, InterruptedException {
    return orderRepository.cancelOrder(cancelOrderInputDTO);
  }

  public String acceptOrder(AcceptOrderInputDTO acceptOrderInputDTO)
      throws ExecutionException, InterruptedException {
    return orderRepository.acceptOrder(acceptOrderInputDTO);
  }

  public String refundOrder(RefundOrderInputDTO refundOrderInputDTO)
      throws ExecutionException, InterruptedException {
    return orderRepository.refundOrder(refundOrderInputDTO);
  }
}
