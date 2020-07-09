package com.patates.webapi.Models.Order;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;
import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class OrderDetailsOutputDTO {
    private String orderNo;
    private String address;
    private String cartNo;
    private String shippingCompany;
    private Date date;
    private String coupon;
    private double percentageDiscount;
    private int state;
    private Double amountPaid;
    private List<OrderProductListingOutputDTO> products;
}
