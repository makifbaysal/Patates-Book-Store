package com.patates.webapi.Models.User.ShoppingCart;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class AddToShoppingCartInputDTO {
  private String productId;
  private String userId;
  private int quantity;
}
