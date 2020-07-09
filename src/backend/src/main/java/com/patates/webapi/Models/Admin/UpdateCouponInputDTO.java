package com.patates.webapi.Models.Admin;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class UpdateCouponInputDTO {
    private String id;
    private String header;
    private String code;
    private String description;
    private int remainingQuantity;
    private int startQuantity;
    private double lowerLimit;
    private double percentageDiscount;
    private Date expireTime;
    private Date startTime;

}
