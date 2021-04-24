package com.patates.webapi.Controllers;

import com.google.firebase.messaging.FirebaseMessagingException;
import com.patates.webapi.Models.Admin.*;
import com.patates.webapi.Models.Order.AcceptOrderInputDTO;
import com.patates.webapi.Services.AdminServices.AdminService;
import org.json.JSONException;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.web.bind.annotation.*;

import java.io.IOException;
import java.text.ParseException;
import java.util.List;
import java.util.concurrent.ExecutionException;

@RestController
@RequestMapping("/api/admin")
public class AdminController {
  private final AdminService adminService;

  public AdminController(AdminService adminService) {
    this.adminService = adminService;
  }

  @GetMapping(value = "/getAdminReports")
  public AdminReportOutputDTO getAdminReports() throws ExecutionException, InterruptedException {
    return adminService.getAdminReports();
  }

  @RequestMapping(value = "/getUsers", method = RequestMethod.POST)
  public List<AdminGetUserDetailsOutputDTO> getUsers(
      @RequestParam(value = "search", defaultValue = "") String search)
      throws IOException, JSONException, ExecutionException, InterruptedException {
    return adminService.getUsers(search);
  }

  @RequestMapping(value = "/addCouponCode", method = RequestMethod.POST)
  @CacheEvict(value = "getCouponCodes", allEntries = true)
  public String addCouponCode(@RequestBody CreateCouponInputDTO createCouponInputDTO)
      throws ExecutionException, InterruptedException, IOException, FirebaseMessagingException,
          ParseException {
    return adminService.addCouponCode(createCouponInputDTO);
  }

  @RequestMapping(value = "/deleteCouponCode", method = RequestMethod.POST)
  @CacheEvict(value = "getCouponCodes", allEntries = true)
  public String deleteCouponCode(@RequestParam String couponId) {
    return adminService.deleteCouponCode(couponId);
  }

  @RequestMapping(value = "/updateCouponCode", method = RequestMethod.POST)
  @CacheEvict(value = "getCouponCodes", allEntries = true)
  public String updateCouponCode(@RequestBody UpdateCouponInputDTO updateCouponInputDTO) {
    return adminService.updateCouponCode(updateCouponInputDTO);
  }

  @GetMapping(value = "/getCouponCodes")
  @Cacheable("getCouponCodes")
  public List<ListingCouponsOutputDTO> getCouponCodes(
      @RequestParam(value = "search", defaultValue = "") String search)
      throws ExecutionException, InterruptedException {
    return adminService.getCouponCodes(search);
  }

  @RequestMapping(value = "/getCouponCodeDetails", method = RequestMethod.POST)
  public CouponCodeDetailsDTO getCouponCodeDetails(@RequestParam String couponId)
      throws ExecutionException, InterruptedException {
    return adminService.getCouponCodeDetails(couponId);
  }

  @RequestMapping(value = "/confirmOrder", method = RequestMethod.POST)
  public String confirmOrder(@RequestBody AcceptOrderInputDTO acceptOrderInputDTO)
      throws ExecutionException, InterruptedException {
    return adminService.confirmOrder(acceptOrderInputDTO);
  }

  @RequestMapping(value = "/rejectOrder", method = RequestMethod.POST)
  public String rejectOrder(@RequestBody RejectOrderInputDTO rejectOrderInputDTO)
      throws ExecutionException, InterruptedException {
    return adminService.rejectOrder(rejectOrderInputDTO);
  }

  @RequestMapping(value = "/refundOrder", method = RequestMethod.POST)
  public String refundOrder(@RequestBody RefundOrderAdminInputDTO refundOrderAdminInputDTO)
      throws ExecutionException, InterruptedException {
    return adminService.refundOrder(refundOrderAdminInputDTO);
  }

  @RequestMapping(value = "/seeMessages", method = RequestMethod.POST)
  public List<SeeMessageOutputDTO> seeMessages() throws ExecutionException, InterruptedException {
    return adminService.seeMessages();
  }

  @RequestMapping(value = "/firebaseElasticDifferenceTest", method = RequestMethod.POST)
  public List<String> firebaseElasticDifferenceTest()
      throws ExecutionException, InterruptedException, JSONException {
    return adminService.firebaseElasticDifferenceTest();
  }
}
