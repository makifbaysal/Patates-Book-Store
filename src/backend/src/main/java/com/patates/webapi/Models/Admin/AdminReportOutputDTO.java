package com.patates.webapi.Models.Admin;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class AdminReportOutputDTO {
    private int totalUser;
    private int totalOrder;
    private double totalRevenue;
    private String mostOrderCategory;
    private int mostOrderCategoryCount;
    private String mostOrderShippingCompany;
    private int mostOrderShippingCompanyCount;
    private int usedCoupon;
    private String mostOrderUser;
    private int mostOrderUserCount;

}
