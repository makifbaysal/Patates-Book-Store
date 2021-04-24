package com.patates.webapi.Services.SearchServices;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.patates.webapi.Models.Product.CreateProductOutputDTO;
import com.patates.webapi.Models.Product.ProductDetailOutputDTO;
import com.patates.webapi.Models.Product.ProductListingReturnOutputDTO;
import com.patates.webapi.Models.User.ManageUser.UserDetailsOutputDTO;
import org.json.JSONException;

import java.util.ArrayList;
import java.util.List;

public interface SearchServices {
  String httpPostRequest(String query, String body);

  String getProductElasticQuery(
      int size,
      int from,
      int lowestPage,
      int highestPage,
      ArrayList<String> category,
      ArrayList<String> languages,
      int lowestPrice,
      int highestPrice,
      String sort,
      String search);

  ProductListingReturnOutputDTO httpProductSearchRequest(String body) throws JSONException;

  List<UserDetailsOutputDTO> httpUserSearchRequest(String search) throws JSONException;

  boolean addProduct(String productId, CreateProductOutputDTO createProductOutputDTO)
      throws JsonProcessingException;

  boolean addUser(String userId, String body);

  boolean deleteProduct(String id);

  boolean deleteUser(String userId);

  boolean updateProduct(String id, String body);

  boolean updateUser(String id, String body);

  boolean updateProductImage(String productId, String photoLink);

  boolean uploadUserImage(String userId, String photoLink);

  ProductDetailOutputDTO getProductDetails(
      boolean bookmark, String productId, int commentCount, double star, int stock);
}
