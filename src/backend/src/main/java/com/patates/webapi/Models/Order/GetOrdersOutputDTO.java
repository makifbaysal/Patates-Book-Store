package com.patates.webapi.Models.Order;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class GetOrdersOutputDTO {
    String orderId;
    int quantity;
    double amountPaid;
    Date date;
    int state;
}
