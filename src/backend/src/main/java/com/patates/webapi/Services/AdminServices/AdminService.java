package com.patates.webapi.Services.AdminServices;

import com.google.firebase.messaging.FirebaseMessagingException;
import com.patates.webapi.Models.Admin.*;
import com.patates.webapi.Models.Order.AcceptOrderInputDTO;
import com.patates.webapi.Models.User.ManageUser.UserDetailsOutputDTO;
import com.patates.webapi.Repositories.Firebase.AdminRepository;
import com.patates.webapi.Services.NotificationServices.FirebaseNotificationService;
import com.patates.webapi.Services.OrderServices.OrderService;
import com.patates.webapi.Services.PaymentServices.PaymentService;
import com.patates.webapi.Services.SearchServices.ElasticsearchServices;
import org.json.JSONException;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;
import java.util.concurrent.ExecutionException;

@Service
public class AdminService {
  private final AdminRepository adminRepository;
  private final FirebaseNotificationService notificationService;
  private final PaymentService paymentService;
  private final ElasticsearchServices elasticsearchServices;
  private final OrderService orderService;

  public AdminService(
      AdminRepository adminRepository,
      FirebaseNotificationService notificationService,
      PaymentService paymentService,
      ElasticsearchServices elasticsearchServices,
      OrderService orderService) {
    this.adminRepository = adminRepository;
    this.notificationService = notificationService;
    this.paymentService = paymentService;
    this.elasticsearchServices = elasticsearchServices;
    this.orderService = orderService;
  }

  public AdminReportOutputDTO getAdminReports() throws ExecutionException, InterruptedException {
    return adminRepository.getAdminReports();
  }

  public List<AdminGetUserDetailsOutputDTO> getUsers(String search)
      throws IOException, JSONException, ExecutionException, InterruptedException {
    List<UserDetailsOutputDTO> userDetails =
        elasticsearchServices.httpUserSearchRequest(
            search.toLowerCase(Locale.forLanguageTag("tr")));
    List<AdminGetUserDetailsOutputDTO> returnList = new ArrayList<>();
    for (UserDetailsOutputDTO user : userDetails) {
      AdminGetUserDetailsOutputDTO adminGetUserDetailsOutputDTO =
          new AdminGetUserDetailsOutputDTO();
      adminGetUserDetailsOutputDTO.setEmail(user.getEmail());
      adminGetUserDetailsOutputDTO.setId(user.getId());
      adminGetUserDetailsOutputDTO.setImageUrl(user.getImageUrl());
      adminGetUserDetailsOutputDTO.setName(user.getName());
      adminGetUserDetailsOutputDTO.setPhone(user.getPhone());
      adminGetUserDetailsOutputDTO.setOrders(orderService.getOrders("", user.getId()));
      adminGetUserDetailsOutputDTO.setTotalAmount(adminRepository.getTotalAmountPaid(user.getId()));
      returnList.add(adminGetUserDetailsOutputDTO);
    }
    return returnList;
  }

  public String addCouponCode(CreateCouponInputDTO createCouponInputDTO)
      throws ExecutionException, InterruptedException, IOException, FirebaseMessagingException,
          ParseException {
    String status = adminRepository.addCouponCode(createCouponInputDTO);
    if (status.equals("Same code")) return status;

    return notificationService.sendNotifications("Yeni bir kampanyamız var!!!", status, "allUser");
  }

  public String deleteCouponCode(String couponId) {
    return adminRepository.deleteCouponCode(couponId);
  }

  public String updateCouponCode(UpdateCouponInputDTO updateCouponInputDTO) {
    return adminRepository.updateCouponCode(updateCouponInputDTO);
  }

  public List<ListingCouponsOutputDTO> getCouponCodes(String search)
      throws ExecutionException, InterruptedException {
    return adminRepository.getCouponCodes(search);
  }

  public CouponCodeDetailsDTO getCouponCodeDetails(String couponId)
      throws ExecutionException, InterruptedException {
    return adminRepository.getCouponCodeDetails(couponId);
  }

  public String confirmOrder(AcceptOrderInputDTO acceptOrderInputDTO)
      throws ExecutionException, InterruptedException {
    return adminRepository.confirmOrder(acceptOrderInputDTO);
  }

  public String rejectOrder(RejectOrderInputDTO rejectOrderInputDTO)
      throws ExecutionException, InterruptedException {
    ArrayList<String> returnList = adminRepository.rejectOrder(rejectOrderInputDTO);
    return paymentService.refund(returnList.get(0), Double.parseDouble(returnList.get(1)));
  }

  public String refundOrder(RefundOrderAdminInputDTO refundOrderAdminInputDTO)
      throws ExecutionException, InterruptedException {

    ArrayList<String> returnList = adminRepository.refundOrder(refundOrderAdminInputDTO);
    if (!returnList.isEmpty()) {
      return paymentService.refund(returnList.get(0), Double.parseDouble(returnList.get(1)));
    }

    return "Success";
  }

  public List<SeeMessageOutputDTO> seeMessages() throws ExecutionException, InterruptedException {
    return adminRepository.seeMessages();
  }

  public List<String> firebaseElasticDifferenceTest()
      throws ExecutionException, InterruptedException, JSONException {
    List<String> productListingOutputDTO = elasticsearchServices.productCheckTest();
    List<String> firebaseProducts = adminRepository.firebaseElasticDifferenceTest();

    List<String> differences = new ArrayList<>();

    for (String product : productListingOutputDTO) {
      if (!firebaseProducts.contains(product)) {
        differences.add(product);
      }
    }

    for (String product : firebaseProducts) {
      if (!productListingOutputDTO.contains(product) && !differences.contains(product)) {
        differences.add(product);
      }
    }

    return differences;
  }
}
