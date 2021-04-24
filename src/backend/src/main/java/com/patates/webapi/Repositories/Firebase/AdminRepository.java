package com.patates.webapi.Repositories.Firebase;

import com.google.api.core.ApiFuture;
import com.google.cloud.firestore.DocumentReference;
import com.google.cloud.firestore.DocumentSnapshot;
import com.google.cloud.firestore.QueryDocumentSnapshot;
import com.google.cloud.firestore.QuerySnapshot;
import com.patates.webapi.Enums.OrderEnum;
import com.patates.webapi.Models.Admin.*;
import com.patates.webapi.Models.Order.AcceptOrderInputDTO;
import org.springframework.stereotype.Repository;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.concurrent.ExecutionException;

@Repository
public class AdminRepository extends FirebaseConnection {

  public Map.Entry<String, Integer> getMaxEntry(HashMap<String, Integer> ourMap) {
    Map.Entry<String, Integer> maxCategoryEntry = null;
    for (Map.Entry<String, Integer> entry : ourMap.entrySet()) {
      if (maxCategoryEntry == null || entry.getValue().compareTo(maxCategoryEntry.getValue()) > 0) {
        maxCategoryEntry = entry;
      }
    }

    return maxCategoryEntry;
  }

  public int getTotalUsers() throws ExecutionException, InterruptedException {
    QuerySnapshot querySnapshot =
        db.collection("users")
            .whereEqualTo("active", true)
            .whereEqualTo("isAdmin", false)
            .get()
            .get();
    return querySnapshot.size();
  }

  public double getTotalAmountPaid(String userId) throws ExecutionException, InterruptedException {
    List<QueryDocumentSnapshot> documents = db.collection("orders").get().get().getDocuments();
    double totalAmount = 0;
    for (QueryDocumentSnapshot document : documents) {
      if (document.getString("userId").equals(userId)) {
        totalAmount += document.getDouble("amountPaid");
      }
    }

    return totalAmount;
  }

  public int getTotalOrders() throws ExecutionException, InterruptedException {
    QuerySnapshot querySnapshotOrders =
        db.collection("orders").whereEqualTo("state", OrderEnum.Shipped.getValue()).get().get();
    return querySnapshotOrders.size();
  }

  public int getTotalUsedCouponCodes() throws ExecutionException, InterruptedException {

    int totalCouponCodes = 0;
    ApiFuture<QuerySnapshot> queryCoupons = db.collection("couponCodes").get();
    QuerySnapshot queryCouponsSnapshot = queryCoupons.get();

    List<QueryDocumentSnapshot> couponDocuments = queryCouponsSnapshot.getDocuments();
    for (QueryDocumentSnapshot document : couponDocuments) {
      totalCouponCodes += document.getLong("startQuantity") - document.getLong("remainingQuantity");
    }

    return totalCouponCodes;
  }

  public AdminReportOutputDTO getAdminReports() throws ExecutionException, InterruptedException {

    AdminReportOutputDTO adminReportOutputDTO = new AdminReportOutputDTO();

    adminReportOutputDTO.setTotalUser(getTotalUsers());
    adminReportOutputDTO.setTotalOrder(getTotalOrders());
    adminReportOutputDTO.setUsedCoupon(getTotalUsedCouponCodes());

    /* GET ORDER INFORMATION */
    HashMap<String, Integer> categoryCount = new HashMap<>();
    HashMap<String, Integer> shippingCount = new HashMap<>();
    HashMap<String, Integer> userOrderCount = new HashMap<>();
    double totalRevenue = 0;
    ApiFuture<QuerySnapshot> query =
        db.collection("orders").whereEqualTo("state", OrderEnum.Shipped.getValue()).get();
    QuerySnapshot querySnapshotOrder = query.get();

    List<QueryDocumentSnapshot> documents = querySnapshotOrder.getDocuments();
    for (QueryDocumentSnapshot document : documents) {
      String cargoId = document.getString("shippingCompanyId");

      String userId = document.getString("userId");

      DocumentSnapshot queryUserOrder = db.collection("users").document(userId).get().get();
      String userOrderName = queryUserOrder.getString("name");

      try {
        userOrderCount.put(userOrderName, userOrderCount.get(userOrderName) + 1);
      } catch (Exception e) {
        userOrderCount.put(userOrderName, 1);
      }

      DocumentSnapshot queryShippingCompany =
          db.collection("shippingCompanies").document(cargoId).get().get();
      String shippingCompanyName = queryShippingCompany.getString("name");
      try {
        shippingCount.put(shippingCompanyName, shippingCount.get(shippingCompanyName) + 1);

      } catch (Exception e) {
        shippingCount.put(shippingCompanyName, 1);
      }

      totalRevenue += document.getDouble("amountPaid");

      List<QueryDocumentSnapshot> documentsPrice =
          document.getReference().collection("products").get().get().getDocuments();

      for (QueryDocumentSnapshot documentPrice : documentsPrice) {
        DocumentSnapshot documentSnapshot =
            db.collection("products").document(documentPrice.getId()).get().get();
        for (String cat : (List<String>) documentSnapshot.get("category")) {
          try {
            categoryCount.put(cat, categoryCount.get(cat) + 1);
          } catch (Exception e) {
            categoryCount.put(cat, 1);
          }
        }
      }
    }

    Map.Entry<String, Integer> maxCategoryEntry = getMaxEntry(categoryCount);
    Map.Entry<String, Integer> maxShippingEntry = getMaxEntry(shippingCount);
    Map.Entry<String, Integer> maxUserOrderEntry = getMaxEntry(userOrderCount);

    if (!(maxCategoryEntry == null)) {
      adminReportOutputDTO.setMostOrderCategory(maxCategoryEntry.getKey());
      adminReportOutputDTO.setMostOrderCategoryCount(maxCategoryEntry.getValue());
    }

    if (!(maxShippingEntry == null)) {
      adminReportOutputDTO.setMostOrderShippingCompany(maxShippingEntry.getKey());
      adminReportOutputDTO.setMostOrderShippingCompanyCount(maxShippingEntry.getValue());
    }

    if (!(maxUserOrderEntry == null)) {

      adminReportOutputDTO.setMostOrderUser(maxUserOrderEntry.getKey());
      adminReportOutputDTO.setMostOrderUserCount(maxUserOrderEntry.getValue());
    }

    adminReportOutputDTO.setTotalRevenue(totalRevenue);

    return adminReportOutputDTO;
  }

  public String addCouponCode(CreateCouponInputDTO createCouponInputDTO)
      throws ExecutionException, InterruptedException, ParseException {
    DateFormat dateFormat = new SimpleDateFormat("dd.MM.yyyy");
    DocumentReference docRef = db.collection("couponCodes").document();
    List<QueryDocumentSnapshot> documents =
        db.collection("couponCodes")
            .whereEqualTo("state", true)
            .whereEqualTo("code", createCouponInputDTO.getCode())
            .get()
            .get()
            .getDocuments();
    if (documents.isEmpty()) {
      Map<String, Object> data = new HashMap<>();

      data.put("header", createCouponInputDTO.getHeader());
      data.put("code", createCouponInputDTO.getCode());
      data.put("description", createCouponInputDTO.getDescription());
      data.put("expireTime", createCouponInputDTO.getExpireTime());
      data.put("lowerLimit", createCouponInputDTO.getLowerLimit());
      data.put("remainingQuantity", createCouponInputDTO.getRemainingQuantity());
      data.put("startQuantity", createCouponInputDTO.getStartQuantity());
      data.put("percentageDiscount", createCouponInputDTO.getPercentageDiscount());
      data.put("startTime", createCouponInputDTO.getStartTime());
      data.put("state", true);

      docRef.set(data);
      return "Patates'te sepetinizde "
          + createCouponInputDTO.getLowerLimit()
          + "₺ ve üzeri alışverişlerinizde geçerli"
          + " %"
          + createCouponInputDTO.getPercentageDiscount().intValue()
          + " indirim şansını yakalamak için \""
          + createCouponInputDTO.getCode()
          + "\" kodunu "
          + dateFormat.format(createCouponInputDTO.getStartTime())
          + " - "
          + dateFormat.format(createCouponInputDTO.getExpireTime())
          + " tarihleri arasında kullanabilirsiniz.";
    } else {
      return "Same code";
    }
  }

  public String deleteCouponCode(String couponId) {
    DocumentReference docRef = db.collection("couponCodes").document(couponId);

    docRef.update("state", false);

    return "Success";
  }

  public String updateCouponCode(UpdateCouponInputDTO updateCouponInputDTO) {

    DocumentReference docRef = db.collection("couponCodes").document(updateCouponInputDTO.getId());

    Map<String, Object> data = new HashMap<>();

    data.put("header", updateCouponInputDTO.getHeader());
    data.put("code", updateCouponInputDTO.getCode());
    data.put("description", updateCouponInputDTO.getDescription());
    data.put("expireTime", updateCouponInputDTO.getExpireTime());
    data.put("lowerLimit", updateCouponInputDTO.getLowerLimit());
    data.put("remainingQuantity", updateCouponInputDTO.getRemainingQuantity());
    data.put("startQuantity", updateCouponInputDTO.getStartQuantity());
    data.put("percentageDiscount", updateCouponInputDTO.getPercentageDiscount());
    data.put("startTime", updateCouponInputDTO.getStartTime());
    data.put("state", true);

    docRef.set(data);
    return docRef.getId();
  }

  public List<ListingCouponsOutputDTO> getCouponCodes(String search)
      throws ExecutionException, InterruptedException {
    search = search.toUpperCase(Locale.forLanguageTag("tr"));
    ArrayList<ListingCouponsOutputDTO> listOfCouponCodes = new ArrayList();

    List<QueryDocumentSnapshot> documents;
    if (search.equals("")) {
      documents =
          db.collection("couponCodes").whereEqualTo("state", true).get().get().getDocuments();
    } else {
      documents =
          db.collection("couponCodes")
              .whereEqualTo("state", true)
              .whereEqualTo("code", search)
              .get()
              .get()
              .getDocuments();
    }

    for (QueryDocumentSnapshot document : documents) {
      listOfCouponCodes.add(
          new ListingCouponsOutputDTO(
              document.getId(),
              document.getString("header"),
              document.getString("code"),
              document.getString("description"),
              document.getDate("expireTime"),
              document.getDouble("percentageDiscount"),
              document.getDouble("remainingQuantity"),
              document.getDouble("startQuantity")));
    }

    return listOfCouponCodes;
  }

  public CouponCodeDetailsDTO getCouponCodeDetails(String couponId)
      throws ExecutionException, InterruptedException {

    DocumentSnapshot document = db.collection("couponCodes").document(couponId).get().get();
    return new CouponCodeDetailsDTO(
        document.getId(),
        document.getString("header"),
        document.getString("code"),
        document.getString("description"),
        document.getLong("remainingQuantity").intValue(),
        document.getLong("startQuantity").intValue(),
        document.getDouble("lowerLimit"),
        document.getDouble("percentageDiscount"),
        document.getDate("expireTime"),
        document.getDate("startTime"));
  }

  public String confirmOrder(AcceptOrderInputDTO acceptOrderInputDTO)
      throws ExecutionException, InterruptedException {
    try {
      ApiFuture<String> futureTransaction =
          db.runTransaction(
              transaction -> {
                DocumentReference orderReference =
                    db.collection("orders").document(acceptOrderInputDTO.getOrderId());

                Map<String, Object> data = new HashMap<>();
                data.put("state", OrderEnum.Accepted.getValue());

                data.put("confirmDate", new Date());
                transaction.update(orderReference, data);

                List<QueryDocumentSnapshot> products =
                    orderReference.collection("products").get().get().getDocuments();

                for (QueryDocumentSnapshot product : products) {
                  DocumentReference productReference =
                      db.collection("products").document(product.getId());
                  data.clear();
                  data = new HashMap<>();
                  if (product.getLong("quantity").intValue()
                      > productReference.get().get().getLong("stock").intValue()) {
                    throw new Error();
                  }
                  data.put(
                      "stock",
                      productReference.get().get().getLong("stock").intValue()
                          - product.getLong("quantity").intValue());

                  transaction.update(productReference, data);
                }

                return "Success";
              });
      return futureTransaction.get();
    } catch (Exception e) {
      return "Error";
    }
  }

  public ArrayList<String> rejectOrder(RejectOrderInputDTO rejectOrderInputDTO)
      throws ExecutionException, InterruptedException {

    DocumentReference orderReference =
        db.collection("orders").document(rejectOrderInputDTO.getOrderId());

    Map<String, Object> data = new HashMap<>();

    data.put("state", OrderEnum.Denied.getValue());
    data.put("deniedDate", new Date());
    orderReference.update(data);
    ArrayList<String> returnList = new ArrayList<>();
    returnList.add(orderReference.get().get().getString("cartId"));
    returnList.add(Double.toString(orderReference.get().get().getDouble("amountPaid")));

    return returnList;
  }

  public ArrayList<String> refundOrder(RefundOrderAdminInputDTO refundOrderAdminInputDTO)
      throws ExecutionException, InterruptedException {
    DocumentReference orderReference =
        db.collection("orders").document(refundOrderAdminInputDTO.getOrderId());
    Map<String, Object> data = new HashMap<>();
    ArrayList<String> returnList = new ArrayList<>();
    if (refundOrderAdminInputDTO.getStatus()) {
      data.put("state", OrderEnum.Cancelled.getValue());
      data.put("refundDate", new Date());
      orderReference.update(data);
      returnList.add(orderReference.get().get().getString("cartId"));
      returnList.add(Double.toString(orderReference.get().get().getDouble("amountPaid")));

    } else {
      data.put("state", OrderEnum.Shipped.getValue());
      data.put("deniedRefundDate", new Date());
      orderReference.update(data);
    }

    return returnList;
  }

  public List<SeeMessageOutputDTO> seeMessages() throws ExecutionException, InterruptedException {
    List<QueryDocumentSnapshot> documents = db.collection("messages").get().get().getDocuments();
    List<SeeMessageOutputDTO> messages = new ArrayList<>();
    for (QueryDocumentSnapshot document : documents) {
      SeeMessageOutputDTO seeMessageOutputDTO = new SeeMessageOutputDTO();

      seeMessageOutputDTO.setMessage(document.getString("message"));
      seeMessageOutputDTO.setEmail(
          db.collection("users")
              .document(document.getString("userId"))
              .get()
              .get()
              .getString("email"));
      seeMessageOutputDTO.setSubject(document.getString("subject"));
      messages.add(seeMessageOutputDTO);
    }
    return messages;
  }

  public List<String> firebaseElasticDifferenceTest()
      throws ExecutionException, InterruptedException {
    List<QueryDocumentSnapshot> documents = db.collection("products").get().get().getDocuments();
    List<String> products = new ArrayList<>();
    for (QueryDocumentSnapshot document : documents) {
      products.add(document.getId());
    }
    return products;
  }
}
