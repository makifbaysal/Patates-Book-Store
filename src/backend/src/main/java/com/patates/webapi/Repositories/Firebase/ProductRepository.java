package com.patates.webapi.Repositories.Firebase;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.google.api.core.ApiFuture;
import com.google.cloud.firestore.*;
import com.patates.webapi.Models.Product.ProductListingOutputDTO;
import com.patates.webapi.Models.Product.UpdateProductInputDTO;
import com.patates.webapi.Models.User.Comment.CommentOutputDTO;
import org.springframework.stereotype.Repository;

import java.io.IOException;
import java.util.*;
import java.util.concurrent.ExecutionException;
import java.util.stream.Collectors;

@Repository
public class ProductRepository extends FirebaseConnection {

  private Map<String, Integer> sortByValue(Map<String, Integer> unsortMap, final boolean order) {
    List<Map.Entry<String, Integer>> list = new LinkedList<>(unsortMap.entrySet());

    // Sorting the list based on values
    list.sort(
        (o1, o2) ->
            order
                ? o1.getValue().compareTo(o2.getValue()) == 0
                    ? o1.getKey().compareTo(o2.getKey())
                    : o1.getValue().compareTo(o2.getValue())
                : o2.getValue().compareTo(o1.getValue()) == 0
                    ? o2.getKey().compareTo(o1.getKey())
                    : o2.getValue().compareTo(o1.getValue()));
    return list.stream()
        .collect(
            Collectors.toMap(
                Map.Entry::getKey, Map.Entry::getValue, (a, b) -> b, LinkedHashMap::new));
  }

  public List<String> getReviewsOfProduct(String productId)
      throws ExecutionException, InterruptedException {
    QuerySnapshot querySnapshot =
        db.collection("products").document(productId).collection("comments").get().get();
    List<String> result = new ArrayList<>();

    result.add(String.valueOf(querySnapshot.size()));

    List<QueryDocumentSnapshot> documentLists = querySnapshot.getDocuments();
    double totalStar = 0;
    for (QueryDocumentSnapshot document : documentLists) {
      totalStar += document.getDouble("star");
    }

    if (String.valueOf(querySnapshot.size()).equals("0")) {
      result.add("0");
    } else {
      result.add(String.valueOf(totalStar / querySnapshot.size()));
    }
    return result;
  }

  public void newCategoryCheck(ArrayList<String> category)
      throws ExecutionException, InterruptedException {
    ApiFuture<QuerySnapshot> queryCategories = db.collection("categories").get();
    QuerySnapshot querySnapshotCategories = queryCategories.get();
    List<QueryDocumentSnapshot> documentsCategories = querySnapshotCategories.getDocuments();
    boolean checkadd;
    for (String addCategory : category) {
      checkadd = false;
      for (QueryDocumentSnapshot document : documentsCategories) {
        if (document.getString("name").equals(addCategory)) {
          checkadd = true;
        }
      }
      if (!checkadd) {
        DocumentReference docRefForCategoryAdd = db.collection("categories").document();
        Map<String, Object> data = new HashMap<>();
        data.put("name", addCategory);
        docRefForCategoryAdd.set(data);
      }
    }
  }

  public String addProduct(
      String description,
      ArrayList<String> category,
      double price,
      String name,
      String author,
      String language,
      int stock,
      int page,
      String photoLink)
      throws IOException, ExecutionException, InterruptedException {

    newCategoryCheck(category);

    DocumentReference docRef = db.collection("products").document();

    Map<String, Object> data = new HashMap<>();
    data.put("category", category);
    data.put("author", author);
    data.put("name", name);
    data.put("description", description);
    data.put("stock", stock);
    data.put("page", page);
    data.put("image-url", photoLink);
    data.put("language", language);
    data.put("state", true);

    docRef.set(data);

    DocumentReference priceRef = docRef.collection("price").document(new Date().toString());

    Map<String, Object> priceData = new HashMap<>();

    priceData.put("price", price);

    priceRef.set(priceData);

    return docRef.getId();
  }

  public String deleteProduct(String id) {
    DocumentReference docRef = db.collection("products").document(id);

    docRef.update("state", false);

    return "Success";
  }

  public String updateProduct(UpdateProductInputDTO product, Map<String, Object> data)
      throws JsonProcessingException, ExecutionException, InterruptedException {

    newCategoryCheck(product.getCategory());

    DocumentReference docRef = db.collection("products").document(product.getId());

    docRef.update(data);

    DocumentReference priceRef = docRef.collection("price").document(new Date().toString());

    Map<String, Object> priceData = new HashMap<>();

    priceData.put("price", product.getPrice());
    data.put("price", product.getPrice());

    priceRef.set(priceData);

    return "Success";
  }

  public Map<String, Integer> categoriesCount() throws ExecutionException, InterruptedException {

    Map<String, Integer> categoriesCount = new HashMap();

    ApiFuture<QuerySnapshot> queryCategories = db.collection("categories").get();
    QuerySnapshot querySnapshotCategories = queryCategories.get();
    List<QueryDocumentSnapshot> documentsCategories = querySnapshotCategories.getDocuments();
    for (QueryDocumentSnapshot document : documentsCategories) {
      categoriesCount.put(document.getString("name"), 0);
    }

    ApiFuture<QuerySnapshot> query = db.collection("products").get();
    QuerySnapshot querySnapshot = query.get();

    List<QueryDocumentSnapshot> documents = querySnapshot.getDocuments();
    for (QueryDocumentSnapshot document : documents) {
      if (document.getBoolean("state")) {
        ArrayList<String> categories = (ArrayList<String>) document.getData().get("category");
        for (String category : categories) {
          categoriesCount.put(category, categoriesCount.get(category) + 1);
        }
      }
    }

    categoriesCount.entrySet().removeIf(tempCategory -> tempCategory.getValue() <= 0);

    return categoriesCount;
  }

  public String updateProductImage(String productId, String photoLink)
      throws ExecutionException, InterruptedException, IOException {
    DocumentReference docRef = db.collection("products").document(productId);

    Map<String, Object> data = new HashMap<>();
    data.put("image-url", photoLink);
    docRef.update(data);
    return "Success";
  }

  public String getFileName(String id) throws ExecutionException, InterruptedException {
    ApiFuture<DocumentSnapshot> queryProduct = db.collection("products").document(id).get();
    DocumentSnapshot documentSnapshot = queryProduct.get();
    return documentSnapshot.getString("name").toLowerCase().replace(" ", "_");
  }

  public boolean isExistsInUserBookmark(String productId, String userId)
      throws ExecutionException, InterruptedException {
    QuerySnapshot queryBookmarkSnapshot =
        db.collection("users")
            .whereArrayContains("bookmarks", productId)
            .whereEqualTo(FieldPath.documentId(), userId)
            .get()
            .get();

    return queryBookmarkSnapshot.size() != 0;
  }

  public List<CommentOutputDTO> getProductComments(String productId)
      throws ExecutionException, InterruptedException {
    List<CommentOutputDTO> comments = new ArrayList<>();

    List<QueryDocumentSnapshot> commentDocuments =
        db.collection("products")
            .document(productId)
            .collection("comments")
            .get()
            .get()
            .getDocuments();

    for (QueryDocumentSnapshot document : commentDocuments) {
      CommentOutputDTO newComment = new CommentOutputDTO();
      newComment.setCommentId(document.getId());
      newComment.setComment(document.getString("comment"));
      newComment.setCommentHeader(document.getString("commentHeader"));
      newComment.setStar(document.getDouble("star"));
      newComment.setName(
          db.collection("users")
              .document(document.getString("userId"))
              .get()
              .get()
              .getString("name"));

      comments.add(newComment);
    }

    return comments;
  }

  public List<ProductListingOutputDTO> bestSellerTen()
      throws ExecutionException, InterruptedException {
    List<QueryDocumentSnapshot> orders = db.collection("orders").get().get().getDocuments();
    Map<String, Integer> productCount = new HashMap<>();
    for (QueryDocumentSnapshot order : orders) {
      List<QueryDocumentSnapshot> products =
          order.getReference().collection("products").get().get().getDocuments();
      for (QueryDocumentSnapshot product : products) {
        productCount.put(product.getId(), productCount.getOrDefault(product.getId(), 0) + 1);
      }
    }
    productCount = sortByValue(productCount, false);

    List<ProductListingOutputDTO> returnProducts = new ArrayList<>();
    int count = 0;
    for (Map.Entry<String, Integer> entry : productCount.entrySet()) {
      if (count != 10) {
        String key = entry.getKey();

        DocumentSnapshot document = db.collection("products").document(key).get().get();
        ProductListingOutputDTO productListingOutputDTO = new ProductListingOutputDTO();

        productListingOutputDTO.setAuthor(document.getString("author"));
        productListingOutputDTO.setId(key);
        productListingOutputDTO.setImageUrl(document.getString("image-url"));
        productListingOutputDTO.setName(document.getString("name"));
        List<QueryDocumentSnapshot> prices =
            document.getReference().collection("price").get().get().getDocuments();
        productListingOutputDTO.setPrice(prices.get(prices.size() - 1).getDouble("price"));
        returnProducts.add(productListingOutputDTO);
        count++;
      } else {
        break;
      }
    }

    return returnProducts;
  }

  public List<ProductListingOutputDTO> weeklyDealsTen()
      throws ExecutionException, InterruptedException {

    List<QueryDocumentSnapshot> weeklyProducts =
        db.collection("products").whereEqualTo("weeklyDeal", true).get().get().getDocuments();
    List<ProductListingOutputDTO> returnProducts = new ArrayList<>();
    for (QueryDocumentSnapshot document : weeklyProducts) {
      ProductListingOutputDTO productListingOutputDTO = new ProductListingOutputDTO();
      productListingOutputDTO.setAuthor(document.getString("author"));
      productListingOutputDTO.setId(document.getId());
      productListingOutputDTO.setImageUrl(document.getString("image-url"));
      productListingOutputDTO.setName(document.getString("name"));
      List<QueryDocumentSnapshot> prices =
          document.getReference().collection("price").get().get().getDocuments();
      productListingOutputDTO.setPrice(prices.get(prices.size() - 1).getDouble("price"));
      returnProducts.add(productListingOutputDTO);
    }
    return returnProducts;
  }

  public List<ProductListingOutputDTO> getRelationalProducts(String productId)
      throws ExecutionException, InterruptedException {

    List<QueryDocumentSnapshot> orderProducts = db.collection("orders").get().get().getDocuments();
    List<ProductListingOutputDTO> returnProducts = new ArrayList<>();
    for (QueryDocumentSnapshot order : orderProducts) {
      if (order.getReference().collection("products").document(productId).get().get().exists()) {
        List<QueryDocumentSnapshot> products =
            order.getReference().collection("products").get().get().getDocuments();
        for (QueryDocumentSnapshot document : products) {
          if (!document.getId().equals(productId)) {
            DocumentSnapshot productDocument =
                db.collection("products").document(document.getId()).get().get();
            ProductListingOutputDTO productListingOutputDTO = new ProductListingOutputDTO();
            productListingOutputDTO.setAuthor(productDocument.getString("author"));
            productListingOutputDTO.setId(document.getId());
            productListingOutputDTO.setImageUrl(productDocument.getString("image-url"));
            productListingOutputDTO.setName(productDocument.getString("name"));

            List<QueryDocumentSnapshot> prices =
                productDocument.getReference().collection("price").get().get().getDocuments();
            productListingOutputDTO.setPrice(prices.get(prices.size() - 1).getDouble("price"));
            if (!returnProducts.stream().anyMatch(o -> o.getId().equals(document.getId()))) {
              returnProducts.add(productListingOutputDTO);
            }
          }
        }
      }
    }

    if (returnProducts.size() < 5) {
      return returnProducts;
    }
    Collections.shuffle(returnProducts);
    return returnProducts.subList(0, 5);
  }

  public int getStock(String productId) throws ExecutionException, InterruptedException {
    return db.collection("products").document(productId).get().get().getLong("stock").intValue();
  }
}
