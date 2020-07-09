package com.patates.webapi.Services.ProductServices;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.firebase.messaging.FirebaseMessagingException;
import com.patates.webapi.Models.Product.*;
import com.patates.webapi.Models.User.Comment.CommentOutputDTO;
import com.patates.webapi.Repositories.Firebase.ProductRepository;
import com.patates.webapi.Services.NotificationServices.FirebaseNotificationService;
import com.patates.webapi.Services.PhotoServices.FirebasePhotoService;
import com.patates.webapi.Services.SearchServices.ElasticsearchServices;
import org.json.JSONException;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ExecutionException;

public class ProductService {
    ProductRepository productRepository = new ProductRepository();
    ElasticsearchServices elasticsearchServices = new ElasticsearchServices();
    FirebasePhotoService photoServices = new FirebasePhotoService();
    FirebaseNotificationService notificationService = new FirebaseNotificationService();

    public ProductListingReturnOutputDTO getProducts(int from, int size, int highestPage, int lowestPage, ArrayList<String> category, ArrayList<String> languages, int lowestPrice, int highestPrice, String sort, String search) throws IOException, JSONException, ExecutionException, InterruptedException {
        String requestBody = elasticsearchServices.getProductElasticQuery(size, from, lowestPage, highestPage, category, languages, lowestPrice, highestPrice, sort, search);
        return elasticsearchServices.httpProductSearchRequest(requestBody);
    }

    public String addProduct(MultipartFile file, String description, double price, ArrayList<String> category, String name, String author, String language, int stock, int page) throws ExecutionException, InterruptedException, IOException, FirebaseMessagingException {
        String photoLink = photoServices.uploadImages(name.toLowerCase().replace(" ", "_"), file, "products");
        String productId = productRepository.addProduct(description, category, price, name, author, language, stock, page, photoLink);
        if (!elasticsearchServices.addProduct(productId, new CreateProductOutputDTO(description, category, price, name, author, language, photoLink, stock, page, true))) {
            return "Error";
        }
        String message = name + " artık Patates'te sizlerle indirimli fiyatlar için kampanyalarımızı takip edin :)";
        notificationService.sendNotifications("Yeni bir kitapımız var!!!", message, "newBook");
        return productId;
    }


    public String deleteProduct(DeleteProductInputDTO id) {
        productRepository.deleteProduct(id.getId());
        if (!elasticsearchServices.deleteProduct(id.getId())) {
            return "Error";
        }
        return "Success";
    }

    public String updateProduct(UpdateProductInputDTO product) throws IOException, ExecutionException, InterruptedException {

        Map<String, Object> data = new HashMap<>();
        data.put("name", product.getName());
        data.put("category", product.getCategory());
        data.put("page", product.getPage());
        data.put("author", product.getAuthor());
        data.put("description", product.getDescription());
        data.put("stock", product.getStock());
        data.put("language", product.getLanguage());
        data.put("state", true);

        ObjectMapper mapper = new ObjectMapper();
        String body = mapper.writeValueAsString(data);

        if (productRepository.updateProduct(product, data).equals("Success")) {
            if (!elasticsearchServices.updateProduct(product.getId(), body)) {
                return "Error";
            }
        }
        return "Success";
    }

    public String updateProductImage(MultipartFile file, String productId) throws IOException, ExecutionException, InterruptedException {
        String fileName = productRepository.getFileName(productId);
        String photoLink = photoServices.uploadImages(fileName, file, "products");
        if (productRepository.updateProductImage(productId, photoLink).equals("Success")) {
            if (!elasticsearchServices.updateProductImage(productId, photoLink)) {
                return "Error";
            }
        }
        return "Success";
    }

    public Map<String, Integer> categoriesCount() throws ExecutionException, InterruptedException {
        return productRepository.categoriesCount();
    }

    public ProductDetailOutputDTO productDetails(String productId, String userId) throws ExecutionException, InterruptedException {
        List<String> returnList = productRepository.getReviewsOfProduct(productId);
        int stock = productRepository.getStock(productId);
        if (userId.equals("")) {
            return elasticsearchServices.getProductDetails(false, productId, Integer.parseInt(returnList.get(0)), Double.parseDouble(returnList.get(1)), stock);
        }
        return elasticsearchServices.getProductDetails(productRepository.isExistsInUserBookmark(productId, userId), productId, Integer.parseInt(returnList.get(0)), Double.parseDouble(returnList.get(1)), stock);
    }

    public List<CommentOutputDTO> getProductComments(String productId) throws ExecutionException, InterruptedException {
        return productRepository.getProductComments(productId);
    }

    public List<ProductListingOutputDTO> bestSellerTen() throws ExecutionException, InterruptedException {
        return productRepository.bestSellerTen();
    }

    public List<ProductListingOutputDTO> weeklyDealsTen() throws ExecutionException, InterruptedException {
        return productRepository.weeklyDealsTen();
    }

    public List<ProductListingOutputDTO> getRelationalProducts(@RequestParam String productId) throws ExecutionException, InterruptedException {
        return productRepository.getRelationalProducts(productId);
    }


}
