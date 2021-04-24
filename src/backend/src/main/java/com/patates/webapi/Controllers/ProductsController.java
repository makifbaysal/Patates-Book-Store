package com.patates.webapi.Controllers;

import com.google.firebase.messaging.FirebaseMessagingException;
import com.patates.webapi.Models.Product.*;
import com.patates.webapi.Models.User.Comment.CommentOutputDTO;
import com.patates.webapi.Services.ProductServices.ProductService;
import org.json.JSONException;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.concurrent.ExecutionException;

@RestController
@RequestMapping("/api/product")
public class ProductsController {
  private final ProductService productService;

  public ProductsController(ProductService productService) {
    this.productService = productService;
  }

  @GetMapping("/viewProducts")
  public ProductListingReturnOutputDTO getProducts(
      @RequestParam(value = "from", defaultValue = "-1") int from,
      @RequestParam(value = "size", defaultValue = "-1") int size,
      @RequestParam(value = "highestPage", defaultValue = "-1") int highestPage,
      @RequestParam(value = "lowestPage", defaultValue = "-1") int lowestPage,
      @RequestParam(value = "category", defaultValue = "") ArrayList<String> category,
      @RequestParam(value = "languages", defaultValue = "") ArrayList<String> languages,
      @RequestParam(value = "lowestPrice", defaultValue = "-1") int lowestPrice,
      @RequestParam(value = "highestPrice", defaultValue = "-1") int highestPrice,
      @RequestParam(value = "sort", defaultValue = "") String sort,
      @RequestParam(value = "search", defaultValue = "") String search)
      throws IOException, JSONException, ExecutionException, InterruptedException {
    return productService.getProducts(
        from,
        size,
        highestPage,
        lowestPage,
        category,
        languages,
        lowestPrice,
        highestPrice,
        sort,
        search.toLowerCase(Locale.forLanguageTag("tr")));
  }

  @RequestMapping(
      consumes = MediaType.MULTIPART_FORM_DATA_VALUE,
      value = "/addProduct",
      method = RequestMethod.POST)
  @CacheEvict(value = "categoriesCount", allEntries = true)
  public String addProduct(
      @RequestParam("file") MultipartFile file,
      @RequestParam String description,
      @RequestParam double price,
      @RequestParam ArrayList<String> category,
      @RequestParam String name,
      @RequestParam String author,
      @RequestParam String language,
      @RequestParam int stock,
      @RequestParam int page)
      throws ExecutionException, InterruptedException, IOException, FirebaseMessagingException {
    return productService.addProduct(
        file, description, price, category, name, author, language, stock, page);
  }

  @RequestMapping(value = "/deleteProduct", method = RequestMethod.POST)
  @CacheEvict(value = "categoriesCount", allEntries = true)
  public String deleteProduct(@RequestBody DeleteProductInputDTO id) {
    return productService.deleteProduct(id);
  }

  @RequestMapping(value = "/updateProduct", method = RequestMethod.POST)
  @CacheEvict(value = "categoriesCount", allEntries = true)
  public String updateProduct(@RequestBody UpdateProductInputDTO product)
      throws IOException, ExecutionException, InterruptedException {
    return productService.updateProduct(product);
  }

  @RequestMapping(
      consumes = MediaType.MULTIPART_FORM_DATA_VALUE,
      value = "/updateProductImage",
      method = RequestMethod.POST)
  public String updateProductImage(
      @RequestParam("file") MultipartFile file, @RequestParam String productId)
      throws IOException, ExecutionException, InterruptedException {
    return productService.updateProductImage(file, productId);
  }

  @GetMapping("/categoriesCount")
  @Cacheable("categoriesCount")
  public Map<String, Integer> categoriesCount() throws ExecutionException, InterruptedException {
    return productService.categoriesCount();
  }

  @GetMapping("/productDetails")
  public ProductDetailOutputDTO productDetails(
      @RequestParam(value = "productId", defaultValue = "") String productId,
      @RequestParam(value = "userId", defaultValue = "") String userId)
      throws ExecutionException, InterruptedException {
    return productService.productDetails(productId, userId);
  }

  @GetMapping(value = "/getProductComments")
  public List<CommentOutputDTO> getProductComments(@RequestParam String productId)
      throws ExecutionException, InterruptedException {
    return productService.getProductComments(productId);
  }

  @GetMapping(value = "/getBestSellerTen")
  @Cacheable("getBestSellerTen")
  public List<ProductListingOutputDTO> getBestSellerTen()
      throws ExecutionException, InterruptedException {
    return productService.bestSellerTen();
  }

  @GetMapping(value = "/getWeeklyDealsTen")
  public List<ProductListingOutputDTO> getWeeklyDealsTen()
      throws ExecutionException, InterruptedException {
    return productService.weeklyDealsTen();
  }

  @GetMapping(value = "/getRelationalProducts")
  public List<ProductListingOutputDTO> getRelationalProducts(@RequestParam String productId)
      throws ExecutionException, InterruptedException {
    return productService.getRelationalProducts(productId);
  }
}
