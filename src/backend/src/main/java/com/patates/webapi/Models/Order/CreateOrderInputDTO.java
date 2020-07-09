package com.patates.webapi.Models.Order;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class CreateOrderInputDTO {
    private String userId;
    private String addressId;
    private String cartId;
    private String coupon;
    private String shippingCompanyId;
    private Double amountPaid;
}
