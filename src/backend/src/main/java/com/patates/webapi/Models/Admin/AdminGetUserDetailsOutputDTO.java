package com.patates.webapi.Models.Admin;

import com.patates.webapi.Models.Order.GetOrdersOutputDTO;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class AdminGetUserDetailsOutputDTO {
  private String id;
  private String name;
  private String email;
  private String imageUrl;
  private String phone;
  private List<GetOrdersOutputDTO> orders;
  private double totalAmount;
}
