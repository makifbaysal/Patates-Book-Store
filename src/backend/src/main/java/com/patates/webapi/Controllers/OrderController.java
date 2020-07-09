package com.patates.webapi.Controllers;

import com.patates.webapi.Models.Order.*;
import com.patates.webapi.Services.OrderServices.OrderService;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.concurrent.ExecutionException;

@RestController
@RequestMapping("/api/order")
public class OrderController {
    OrderService orderService = new OrderService();

    @RequestMapping(value = "/createOrder", method = RequestMethod.POST)
    @CacheEvict(value = "getBestSellerTen", allEntries = true)
    public String createOrder(@RequestBody CreateOrderInputDTO createOrderInputDTO) throws ExecutionException, InterruptedException {
        return orderService.createOrder(createOrderInputDTO);
    }

    @GetMapping(value = "/orderDetails")
    public OrderDetailsOutputDTO orderDetails(@RequestParam(value = "orderId", defaultValue = "") String orderId) throws ExecutionException, InterruptedException {
        return orderService.orderDetails(orderId);
    }

    @GetMapping(value = "/getOrders")
    public List<GetOrdersOutputDTO> getOrders(@RequestParam(value = "state", defaultValue = "") String state, @RequestParam(value = "userId", defaultValue = "") String userId) throws ExecutionException, InterruptedException {
        return orderService.getOrders(state, userId);
    }

    @RequestMapping(value = "/cancelOrder", method = RequestMethod.POST)
    public String cancelOrder(@RequestBody CancelOrderInputDTO cancelOrderInputDTO) throws ExecutionException, InterruptedException {
        return orderService.cancelOrder(cancelOrderInputDTO);
    }

    @RequestMapping(value = "/acceptOrder", method = RequestMethod.POST)
    public String acceptOrder(@RequestBody AcceptOrderInputDTO acceptOrderInputDTO) throws ExecutionException, InterruptedException {
        return orderService.acceptOrder(acceptOrderInputDTO);
    }

    @RequestMapping(value = "/refundOrder", method = RequestMethod.POST)
    public String refundOrderRequest(@RequestBody RefundOrderInputDTO refundOrderInputDTO) throws ExecutionException, InterruptedException {
        return orderService.refundOrder(refundOrderInputDTO);
    }
}
