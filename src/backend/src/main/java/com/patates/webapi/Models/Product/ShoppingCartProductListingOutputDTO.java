package com.patates.webapi.Models.Product;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ShoppingCartProductListingOutputDTO {
  private String id;
  private String imageUrl;
  private String name;
  private String author;
  private double price;
  private int quantity;
}
