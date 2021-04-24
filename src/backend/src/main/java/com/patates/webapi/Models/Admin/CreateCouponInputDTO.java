package com.patates.webapi.Models.Admin;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class CreateCouponInputDTO {
  private String header;
  private String code;
  private String description;
  private int remainingQuantity;
  private int startQuantity;
  private Double lowerLimit;
  private Double percentageDiscount;
  private Date expireTime;
  private Date startTime;
}
