package com.patates.webapi.Models.User.CreditCart;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class DeleteCreditCartInputDTO {
    private String userId;
    private String cartId;

}
