package com.patates.webapi.Models.Admin;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ListingCouponsOutputDTO {
    private String couponId;
    private String header;
    private String code;
    private String description;
    private Date expireTime;
    private double percentageDiscount;
    private double remainingQuantity;
    private double startQuantity;

}
