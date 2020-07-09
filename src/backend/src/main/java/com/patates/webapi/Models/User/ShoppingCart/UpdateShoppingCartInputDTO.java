package com.patates.webapi.Models.User.ShoppingCart;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class UpdateShoppingCartInputDTO {
    private String userId;
    private String productId;
    private int value;
}
