import 'dart:async';

import 'package:app/enums/ServerState.dart';
import 'package:app/models/base_model.dart';
import 'package:app/utils/api.dart';
import 'package:openapi/api.dart';

class AdminProvider extends BaseModel {
  Future<List<AdminGetUserDetailsOutputDTO>> getUsers({String search}) async {
    setState(ServerState.Busy);
    try {
      var response = await api.admin.getUsers(search: search);
      setState(ServerState.Success);
      return response;
    } catch (e) {
      setState(ServerState.Error);
      return null;
    }
  }

  Future<AdminReportOutputDTO> getAdminReports() async {
    try {
      var response = await api.admin.getAdminReports();
      return response;
    } catch (e) {
      return null;
    }
  }

  Future<List<ListingCouponsOutputDTO>> getCouponCodes(String search) async {
    try {
      var response = await api.admin.getCouponCodes(search: search);
      return response;
    } catch (e) {
      return null;
    }
  }

  Future<String> addCoupon(
      {String description,
      String code,
      DateTime startTime,
      DateTime expireTime,
      String header,
      double percentageDiscount,
      double lowerLimit,
      int remainingQuantity,
      int startQuantity}) async {
    setState(ServerState.Busy);
    try {
      CreateCouponInputDTO coupon = CreateCouponInputDTO();
      coupon.description = description;
      coupon.code = code;
      coupon.startTime = startTime;
      coupon.expireTime = expireTime;
      coupon.header = header;
      coupon.percentageDiscount = percentageDiscount;
      coupon.lowerLimit = lowerLimit;
      coupon.remainingQuantity = remainingQuantity;
      coupon.startQuantity = startQuantity;

      var response = await api.admin.addCouponCode(coupon);
      setState(ServerState.Success);
      return response;
    } catch (e) {
      setState(ServerState.Error);
      return null;
    }
  }

  Future<String> deleteCoupon(String couponID) async {
    setState(ServerState.Busy);
    try {
      var response = await api.admin.deleteCouponCode(couponID);
      setState(ServerState.Success);
      return response;
    } catch (e) {
      setState(ServerState.Error);
      return null;
    }
  }

  Future<String> updateCouponCode(String id, String header, String code, String description, int remainingQuantity, int startQuantity,
      double lowerLimit, double percentageDiscount, DateTime expireTime, DateTime startTime) async {
    setState(ServerState.Busy);
    try {
      UpdateCouponInputDTO coupon = UpdateCouponInputDTO();
      coupon.id = id;
      coupon.header = header;
      coupon.code = code;
      coupon.description = description;
      coupon.remainingQuantity = remainingQuantity;
      coupon.startQuantity = startQuantity;
      coupon.lowerLimit = lowerLimit;
      coupon.percentageDiscount = percentageDiscount;
      coupon.expireTime = expireTime;
      coupon.startTime = startTime;

      var response = await api.admin.updateCouponCode(coupon);
      setState(ServerState.Success);
      return response;
    } catch (e) {
      setState(ServerState.Error);
      return null;
    }
  }

  Future<CouponCodeDetailsDTO> getCouponCodeDetails(String couponID) async {
    setState(ServerState.Busy);
    try {
      var response = await api.admin.getCouponCodeDetails(couponID);
      setState(ServerState.Success);
      return response;
    } catch (e) {
      setState(ServerState.Error);
      return null;
    }
  }

  Future<String> rejectOrder(String orderId) async {
    try {
      RejectOrderInputDTO order = RejectOrderInputDTO();
      order.orderId = orderId;
      var response = await api.admin.rejectOrder(order);

      return response;
    } catch (e) {
      return "Error";
    }
  }

  Future<String> confirmOrder(String orderId) async {
    try {
      AcceptOrderInputDTO order = AcceptOrderInputDTO();
      order.orderId = orderId;
      var response = await api.admin.confirmOrder(order);

      return response;
    } catch (e) {
      return "Error";
    }
  }

  Future<String> refundOrder(String orderId, bool status) async {
    try {
      RefundOrderAdminInputDTO order = RefundOrderAdminInputDTO();
      order.orderId = orderId;
      order.status = status;
      var response = await api.admin.refundOrder(order);
      return response;
    } catch (e) {
      return "Error";
    }
  }

  Future<List<SeeMessageOutputDTO>> getMessages() async {
    try {
      var response = await api.admin.seeMessages();
      return response;
    } catch (e) {
      return null;
    }
  }
}
