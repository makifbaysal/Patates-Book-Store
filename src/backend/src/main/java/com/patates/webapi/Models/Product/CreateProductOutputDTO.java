package com.patates.webapi.Models.Product;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.ArrayList;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class CreateProductOutputDTO {
  private String description;
  private ArrayList<String> category;
  private double price;
  private String name;
  private String author;
  private String language;
  private String imageUrl;
  private int stock;
  private int page;
  private boolean state;
}
