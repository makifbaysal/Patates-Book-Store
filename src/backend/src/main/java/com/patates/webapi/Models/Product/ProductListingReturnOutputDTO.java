package com.patates.webapi.Models.Product;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ProductListingReturnOutputDTO {
    private List<ProductListingOutputDTO> products;
    private int productCount;

}
