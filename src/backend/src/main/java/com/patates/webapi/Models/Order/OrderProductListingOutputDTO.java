package com.patates.webapi.Models.Order;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class OrderProductListingOutputDTO {
    private String productId;
    private String imageUrl;
    private String name;
    private String author;
    private int quantity;
    private double unitPrice;
}
