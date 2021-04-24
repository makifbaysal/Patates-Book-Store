package com.patates.webapi.Models.ShippingCompany;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ShippingCompanyDetailsOutputDTO {
  private String id;
  private String imageUrl;
  private String name;
  private double price;
  private String website;
  private Date endDate;
  private String contactNumber;
}
