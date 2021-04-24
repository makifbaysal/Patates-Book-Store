package com.patates.webapi.Services.SearchServices;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.patates.webapi.Models.Product.CreateProductOutputDTO;
import com.patates.webapi.Models.Product.ProductDetailOutputDTO;
import com.patates.webapi.Models.Product.ProductListingOutputDTO;
import com.patates.webapi.Models.Product.ProductListingReturnOutputDTO;
import com.patates.webapi.Models.User.ManageUser.UserDetailsOutputDTO;
import org.apache.http.HttpEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class ElasticsearchServices implements SearchServices {

  public String httpPostRequest(String query, String body) {
    HttpPost httpPost = new HttpPost("elasticsearchurl/" + query);
    CloseableHttpResponse response = null;
    httpPost.setHeader("Content-type", "application/json");
    try {
      StringEntity stringEntity = new StringEntity(body, "UTF-8");
      httpPost.getRequestLine();
      httpPost.setEntity(stringEntity);
      CloseableHttpClient httpClient = HttpClients.createDefault();
      response = httpClient.execute(httpPost);
      if (response.getStatusLine().getStatusCode() < 400)
        return EntityUtils.toString(response.getEntity());

    } catch (Exception e) {

    }
    return "Error";
  }

  public List<String> productCheckTest() {
    HttpGet request = new HttpGet("elasticsearchurl/products/_doc/_search?size=1000");
    CloseableHttpResponse response = null;
    List<String> products = new ArrayList<>();
    try {
      CloseableHttpClient httpClient = HttpClients.createDefault();
      response = httpClient.execute(request);
      if (response.getStatusLine().getStatusCode() < 400) {

        JSONObject json = new JSONObject(EntityUtils.toString(response.getEntity()));
        String hits = json.get("hits").toString();
        json = new JSONObject(hits);

        JSONArray jsonArray = (JSONArray) json.get("hits");

        for (int i = 0; i < jsonArray.length(); i++) {
          json = (JSONObject) jsonArray.get(i);
          products.add(json.getString("_id"));
        }
      }

    } catch (Exception e) {
      e.printStackTrace();
    }
    return products;
  }

  public String getProductElasticQuery(
      int size,
      int from,
      int lowestPage,
      int highestPage,
      ArrayList<String> category,
      ArrayList<String> languages,
      int lowestPrice,
      int highestPrice,
      String sort,
      String search) {
    StringBuilder body = new StringBuilder("{\"query\":{\"bool\":{\"must\":[");

    if (!category.isEmpty()) {
      body.append("{\"terms\":{\"category.keyword\":[\"");
      body.append(String.join("\",\"", category));
      body.append("\"]}}");
    }
    if (!languages.isEmpty()) {
      if (body.charAt(body.length() - 1) != '[') body.append(',');
      body.append("{\"terms\":{\"language.keyword\":[\"");
      body.append(String.join("\",\"", languages));
      body.append("\"]}}");
    }
    if (lowestPrice != -1 || highestPrice != -1) {
      if (body.charAt(body.length() - 1) != '[') body.append(',');
      body.append("{\"range\":{\"price\":{\"gte\":");
      body.append(lowestPrice);
      body.append(",\"lte\":");
      body.append(highestPrice);
      body.append("}}}");
    }
    if (lowestPage != -1 || highestPage != -1) {
      if (body.charAt(body.length() - 1) != '[') body.append(',');
      body.append("{\"range\":{\"page\":{\"gte\":");
      body.append(lowestPage);
      body.append(",\"lte\":");
      body.append(highestPage);
      body.append("}}}");
    }
    if (body.charAt(body.length() - 1) != '[') body.append(',');

    body.append("{\"bool\":{\"should\":[{\"wildcard\":{\"author.lowercase\":\"*");
    body.append(search);
    body.append("*\"}},{\"wildcard\":{\"name.lowercase\":\"*");
    body.append(search);
    body.append(
        "*\"}}]}}"
            + ",\n"
            + "        {\n"
            + "          \"match\": {\n"
            + "            \"state\": true\n"
            + "          }\n"
            + "        }"
            + "]}}");
    if (!sort.equals("")) {
      if (body.charAt(body.length() - 1) != '[') body.append(',');
      body.append("\"sort\":{\"price\":{\"order\":\"");
      body.append(sort);
      body.append("\"}}");
    }
    body.append(",\"size\":");
    body.append(size);
    body.append(", \"from\":");
    body.append(from);
    body.append("}");
    return body.toString();
  }

  public ProductListingReturnOutputDTO httpProductSearchRequest(String body) throws JSONException {

    ProductListingReturnOutputDTO productListingReturnOutputDTO =
        new ProductListingReturnOutputDTO();
    List<ProductListingOutputDTO> productLists = new ArrayList<>();
    String strResponse = httpPostRequest("products/_doc/_search", body);
    int queryHit = 0;
    if (!strResponse.equals("Error")) {
      JSONObject json = new JSONObject(strResponse);

      queryHit =
          new JSONObject(
                  new JSONObject(
                          new JSONObject(json.get("hits").toString()).get("total").toString())
                      .toString())
              .getInt("value");

      json = new JSONObject(json.get("hits").toString());
      JSONArray jsonArray = (JSONArray) json.get("hits");

      String id;
      String image_url;
      String name;
      String author;
      double price;

      for (int i = 0; i < jsonArray.length(); i++) {
        json = (JSONObject) jsonArray.get(i);
        id = (String) json.get("_id");
        json = new JSONObject(json.get("_source").toString());
        image_url = (String) json.get("imageUrl");
        name = (String) json.get("name");
        author = (String) json.get("author");
        price = json.getDouble("price");
        productLists.add(new ProductListingOutputDTO(id, image_url, name, author, price));
      }
    }
    productListingReturnOutputDTO.setProducts(productLists);
    productListingReturnOutputDTO.setProductCount(queryHit);
    return productListingReturnOutputDTO;
  }

  public List<UserDetailsOutputDTO> httpUserSearchRequest(String search) throws JSONException {
    String body =
        "{\n"
            + "  \"query\": {\n"
            + "    \"bool\": {\n"
            + "      \"must_not\": [\n"
            + "        {\n"
            + "          \"match\": {\n"
            + "            \"isAdmin\": true\n"
            + "          }\n"
            + "        }\n"
            + "      ],\n"
            + "      \"must\":[{\n"
            + "        \"wildcard\":{\n"
            + "          \"name.lowercase\":\"*"
            + search
            + "*\"\n"
            + "        }\n"
            + "      },{\n"
            + "        \"match\":{\n"
            + "          \"active\":true\n"
            + "       }\n"
            + "      }]\n"
            + "    }\n"
            + "  }\n"
            + "}\n";

    List<UserDetailsOutputDTO> userList = new ArrayList<>();

    String strResponse = httpPostRequest("users/_doc/_search", body);
    if (!strResponse.equals("Error")) {

      JSONObject json = new JSONObject(strResponse);
      json = new JSONObject(json.get("hits").toString());
      JSONArray jsonArray = (JSONArray) json.get("hits");
      String id;
      String name;
      String email;
      String imageUrl = null;
      String phone = null;

      for (int i = 0; i < jsonArray.length(); i++) {
        json = (JSONObject) jsonArray.get(i);
        id = json.getString("_id");
        json = new JSONObject(json.get("_source").toString());
        try {
          imageUrl = json.getString("imageUrl");
        } catch (Exception e) {

        }
        try {
          phone = json.getString("phone");
        } catch (Exception e) {

        }
        name = json.getString("name");
        email = json.getString("email");

        userList.add(new UserDetailsOutputDTO(id, name, email, imageUrl, phone));
      }
    }

    return userList;
  }

  public boolean addProduct(String productId, CreateProductOutputDTO createProductOutputDTO)
      throws JsonProcessingException {
    ObjectMapper mapper = new ObjectMapper();

    String body = mapper.writeValueAsString(createProductOutputDTO);

    String response = httpPostRequest("products/_doc/" + productId, body);
    return !response.equals("Error");
  }

  public boolean addUser(String userId, String body) {

    String response = httpPostRequest("users/_doc/" + userId, body);
    return !response.equals("Error");
  }

  public boolean deleteProduct(String id) {
    String body = "{\n" + " \"doc\":{\n" + "    \"state\":false\n" + "}\n" + "}";

    String response = httpPostRequest("products/_doc/" + id + "/_update", body);
    return !response.equals("Error");
  }

  public boolean deleteUser(String userId) {
    String body = "{\n" + " \"doc\":{\n" + "    \"active\":false\n" + "}\n" + "}";

    String response = httpPostRequest("users/_doc/" + userId + "/_update", body);
    return !response.equals("Error");
  }

  public boolean updateProduct(String id, String body) {

    body = "{\"doc\":" + body + "}";

    String response = httpPostRequest("products/_doc/" + id + "/_update", body);
    return !response.equals("Error");
  }

  public boolean updateUser(String id, String body) {
    body = "{\"doc\":" + body + "}";
    String response = httpPostRequest("users/_doc/" + id + "/_update", body);
    return !response.equals("Error");
  }

  public boolean updateProductImage(String productId, String photoLink) {
    String body = "{\n" + " \"doc\":{\n" + "    \"imageUrl\":\"" + photoLink + "\"\n" + "}\n" + "}";

    String response = httpPostRequest("products/_doc/" + productId + "/_update", body);
    return !response.equals("Error");
  }

  public boolean uploadUserImage(String userId, String photoLink) {
    String body = "{\n" + " \"doc\":{\n" + "    \"imageUrl\":\"" + photoLink + "\"\n" + "}\n" + "}";

    String response = httpPostRequest("users/_doc/" + userId + "/_update", body);
    return !response.equals("Error");
  }

  public ProductDetailOutputDTO getProductDetails(
      boolean bookmark, String productId, int commentCount, double star, int stock) {
    ProductDetailOutputDTO productDetailOutputDTO = new ProductDetailOutputDTO();

    productDetailOutputDTO.setBookmark(bookmark);

    String url = "elasticsearchurl/products/_doc/" + productId;
    HttpGet request = new HttpGet(url);
    ArrayList<String> tempCategory = new ArrayList<>();

    try (CloseableHttpClient httpClient = HttpClients.createDefault();
        CloseableHttpResponse response = httpClient.execute(request)) {

      HttpEntity entity = response.getEntity();

      if (entity != null) {
        String result = EntityUtils.toString(entity);
        JSONObject json = new JSONObject(result);
        json = new JSONObject(json.get("_source").toString());

        productDetailOutputDTO.setAuthor(json.getString("author"));
        productDetailOutputDTO.setDescription(json.getString("description"));

        JSONArray jsonArray = (JSONArray) json.get("category");
        for (int i = 0; i < jsonArray.length(); i++) {
          tempCategory.add((String) jsonArray.get(i));
        }
        productDetailOutputDTO.setCategory(tempCategory);

        productDetailOutputDTO.setPrice(json.getDouble("price"));
        productDetailOutputDTO.setName(json.getString("name"));
        productDetailOutputDTO.setLanguage(json.getString("language"));
        productDetailOutputDTO.setImageUrl(json.getString("imageUrl"));
        productDetailOutputDTO.setStock(stock);
        productDetailOutputDTO.setPage(json.getInt("page"));
        productDetailOutputDTO.setStar(star);
        productDetailOutputDTO.setCommentCount(commentCount);
      }
      return productDetailOutputDTO;
    } catch (Exception e) {
      return productDetailOutputDTO;
    }
  }
}
