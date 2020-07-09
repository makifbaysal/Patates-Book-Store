package com.patates.webapi.Models.ShippingCompany;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ListingShippingCompaniesOutputDTO {
    private String companyId;
    private String imageUrl;
    private String name;
    private String contactNumber;
    private Date endDate;
    private double price;

}
