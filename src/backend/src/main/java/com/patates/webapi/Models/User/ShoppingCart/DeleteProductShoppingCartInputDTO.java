package com.patates.webapi.Models.User.ShoppingCart;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class DeleteProductShoppingCartInputDTO {
    private String userId;
    private String productId;

}
