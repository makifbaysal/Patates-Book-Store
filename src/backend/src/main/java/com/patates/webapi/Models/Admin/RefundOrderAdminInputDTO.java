package com.patates.webapi.Models.Admin;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class RefundOrderAdminInputDTO {
    private String orderId;
    private Boolean status;
}
