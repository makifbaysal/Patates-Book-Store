package com.patates.webapi.Models.User.CreditCart;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class CreditCartDetailsOutputDTO {
    private String userId;
    private String cartId;
    private String owner;
    private String cartNumber;
    private String date;
    private String cvc;

}
