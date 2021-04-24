package com.patates.webapi.Models.Product;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class ProductListingOutputDTO implements Comparable {
  private String id;
  private String imageUrl;
  private String name;
  private String author;
  private double price;

  @Override
  public int compareTo(Object o) {

    if (price > ((ProductListingOutputDTO) o).price) {
      return 1;
    } else if (price < ((ProductListingOutputDTO) o).price) {
      return -1;
    }
    return 0;
  }
}
