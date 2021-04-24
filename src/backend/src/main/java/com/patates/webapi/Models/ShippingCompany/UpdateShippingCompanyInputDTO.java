package com.patates.webapi.Models.ShippingCompany;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class UpdateShippingCompanyInputDTO {
  private String id;
  private String name;
  private double price;
  private String website;
  private String contactNumber;
  private Date endDate;
}
