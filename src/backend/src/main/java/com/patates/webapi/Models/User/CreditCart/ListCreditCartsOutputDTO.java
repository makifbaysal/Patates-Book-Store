package com.patates.webapi.Models.User.CreditCart;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ListCreditCartsOutputDTO {
    private String cartId;
    private String cartNumber;
    private String owner;
    private String date;

}
