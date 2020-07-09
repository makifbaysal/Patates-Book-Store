import 'dart:convert';

import 'package:app/enums/ServerState.dart';
import 'package:app/models/base_model.dart';
import 'package:app/utils/api.dart';
import 'package:app/utils/constants.dart';
import 'package:jaguar_jwt/jaguar_jwt.dart';
import 'package:openapi/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider extends BaseModel {
  final SharedPreferences pref;
  String idToken;
  String nameSurname;
  String email;
  String userId;
  bool isAdmin;

  double discountPercentage = 0;
  String couponCode;

  ListAddressOutputDTO selectedAddress;
  ListingShippingCompaniesOutputDTO selectedShippingCompany;
  ListCreditCartsOutputDTO selectedCart;

  UserProvider({this.pref}) {
    idToken = pref.getString(Constants.idToken) ?? null;
    nameSurname = pref.getString(Constants.nameSurname) ?? null;
    isAdmin = pref.getBool(Constants.isAdmin) ?? null;
    if (idToken != null) {
      decodeIdToken();
    }
  }

  decodeIdToken() {
    var decode = json.decode(B64urlEncRfc7515.decodeUtf8(idToken.split('.')[1]));
    userId = decode["user_id"];
    email = decode["email"];
  }

  Future<void> login(LoginInputDTO loginInputDTO) async {
    setState(ServerState.Busy);
    LoginOutputDTO response = await api.users.login(loginInputDTO);
    if (response.status == "Error" || response.status == "Deactive") {
      print(response);
      setState(ServerState.Error);
    } else {
      idToken = response.idToken;
      nameSurname = response.name;
      isAdmin = response.admin;
      await pref.setString(Constants.idToken, idToken);
      await pref.setString(Constants.nameSurname, nameSurname);
      await pref.setBool(Constants.isAdmin, isAdmin);
      decodeIdToken();
      setState(ServerState.Success);
    }
  }

  Future<void> signUp(CreateUserInputDTO createUserInputDTO) async {
    setState(ServerState.Busy);
    var response = await api.users.createUser(createUserInputDTO);
    if (response.status == "Error") {
      setState(ServerState.Error);
    } else {
      idToken = response.idToken;
      nameSurname = response.name;
      isAdmin = false;
      await pref.setString(Constants.idToken, idToken);
      await pref.setString(Constants.nameSurname, nameSurname);
      await pref.setBool(Constants.isAdmin, isAdmin);

      decodeIdToken();
      setState(ServerState.Success);
    }
  }

  Future<void> resetPassword(String email) async {
    setState(ServerState.Busy);
    PasswordResetInputDTO resetInputDTO = PasswordResetInputDTO();
    resetInputDTO.email = email;
    var response = await api.users.resetUserPasswordUpdate(resetInputDTO);
    if (response == "Success") {
      setState(ServerState.Success);
    } else {
      setState(ServerState.Error);
    }
  }

  logout() async {
    setState(ServerState.Busy);
    idToken = null;
    userId = null;
    email = null;
    nameSurname = null;

    discountPercentage = 0;
    couponCode = null;

    selectedAddress = null;
    selectedShippingCompany = null;
    selectedCart = null;
    await pref.remove(Constants.idToken);
    await pref.remove(Constants.nameSurname);
    await pref.remove(Constants.isAdmin);
    setState(ServerState.Success);
  }

  Future<List<ProductListingOutputDTO>> getBookmarks() async {
    setState(ServerState.Busy);
    try {
      var response = await api.users.getBookmark(userId);
      setState(ServerState.Success);
      return response;
    } catch (e) {
      setState(ServerState.Error);
      return [];
    }
  }

  Future<void> addBookmark(String productId) async {
    setState(ServerState.Busy);
    try {
      AddBookmarkInputDTO addBookmarkInputDTO = AddBookmarkInputDTO();
      addBookmarkInputDTO.userId = userId;
      addBookmarkInputDTO.productId = productId;
      var response = await api.users.addToBookmark(addBookmarkInputDTO);
      if (response == "Error") {
        setState(ServerState.Error);
      } else {
        setState(ServerState.Success);
      }
    } catch (e) {
      setState(ServerState.Error);
    }
  }

  Future<void> deleteFromBookmark(String productId) async {
    setState(ServerState.Busy);
    try {
      DeleteBookmarkInputDTO deleteBookmarkInputDTO = DeleteBookmarkInputDTO();
      deleteBookmarkInputDTO.userId = userId;
      deleteBookmarkInputDTO.productId = productId;
      var response = await api.users.deleteFromBookmark(deleteBookmarkInputDTO);
      if (response == "Error") {
        setState(ServerState.Error);
      } else {
        setState(ServerState.Success);
      }
    } catch (e) {
      setState(ServerState.Error);
    }
  }

  Future<void> deActiveUser({String user}) async {
    setState(ServerState.Busy);
    try {
      DeleteUserInputDTO deleteUserInputDTO = DeleteUserInputDTO();
      deleteUserInputDTO.userId = user == null ? this.userId : user;
      var response = await api.users.deactivateUser(deleteUserInputDTO);
      if (response == "Error") {
        setState(ServerState.Error);
      } else {
        setState(ServerState.Success);
      }
    } catch (e) {
      setState(ServerState.Error);
    }
  }

  Future<String> addToShoppingCard(String productId, int quantity) async {
    setState(ServerState.Busy);
    try {
      AddToShoppingCartInputDTO addToShoppingCartInputDTO = AddToShoppingCartInputDTO();
      addToShoppingCartInputDTO.userId = userId;
      addToShoppingCartInputDTO.productId = productId;
      addToShoppingCartInputDTO.quantity = quantity;

      var response = await api.users.addToShoppingCart(addToShoppingCartInputDTO);
      if (response == "Success") {
        setState(ServerState.Success);
        return "Success";
      } else {
        setState(ServerState.Error);
        return "Error";
      }
    } catch (e) {
      setState(ServerState.Error);
      return "Error";
    }
  }

  Future<String> updateUserPassword(String password, String oldPassword) async {
    setState(ServerState.Busy);
    try {
      UpdatePasswordInputDTO pass = UpdatePasswordInputDTO();
      pass.password = password;
      pass.oldPassword = oldPassword;
      pass.idToken = idToken;
      var response = await api.users.updateUserPassword(pass);
      if (response != "Error") {
        idToken = response;
        pref.setString(Constants.idToken, idToken);
        setState(ServerState.Success);
        return "Success";
      } else {
        setState(ServerState.Error);
        return "Error";
      }
    } catch (e) {
      setState(ServerState.Error);
      return "Error";
    }
  }

  Future<String> sendMessage(String message, String subject) async {
    setState(ServerState.Busy);
    try {
      SendMessageInputDTO msg = SendMessageInputDTO();
      msg.userId = userId;
      msg.message = message;
      msg.subject = subject;
      var response = await api.users.sendMessage(msg);
      if (response == "Success") {
        setState(ServerState.Success);
        return "Success";
      } else {
        setState(ServerState.Error);
        return "Error";
      }
    } catch (e) {
      setState(ServerState.Error);
      return "Error";
    }
  }

  Future<List<ShoppingCartProductListingOutputDTO>> getShoppingCard() async {
    try {
      var response = await api.users.getShoppingCart(userId);
      if (response != null) {
        return response;
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }

  Future<String> deleteProductShoppingCart(String productId) async {
    setState(ServerState.Busy);
    try {
      DeleteProductShoppingCartInputDTO deleteProductShoppingCartInputDTO = DeleteProductShoppingCartInputDTO();
      deleteProductShoppingCartInputDTO.userId = userId;
      deleteProductShoppingCartInputDTO.productId = productId;

      var response = await api.users.deleteProductShoppingCart(deleteProductShoppingCartInputDTO);
      if (response == "Success") {
        setState(ServerState.Success);
        couponCode = null;
        discountPercentage = 0;
        return "Success";
      } else {
        setState(ServerState.Error);
        return "Error";
      }
    } catch (e) {
      setState(ServerState.Error);
      return "Error";
    }
  }

  Future<String> updateShoppingCart(String productId, int value) async {
    setState(ServerState.Busy);
    try {
      UpdateShoppingCartInputDTO updateShoppingCartInputDTO = UpdateShoppingCartInputDTO();
      updateShoppingCartInputDTO.userId = userId;
      updateShoppingCartInputDTO.productId = productId;
      updateShoppingCartInputDTO.value = value;
      var response = await api.users.updateShoppingCart(updateShoppingCartInputDTO);
      if (response == "Success") {
        setState(ServerState.Success);
        if (value == -1) {
          couponCode = null;
          discountPercentage = 0;
        }
        return "Success";
      } else {
        setState(ServerState.Error);
        return "Error";
      }
    } catch (e) {
      setState(ServerState.Error);
      return "Error";
    }
  }

  Future<UseCouponCodeOutputDTO> userCouponCode(String couponCode, double price) async {
    setState(ServerState.Busy);
    try {
      var response = await api.users.useCouponCode(couponCode);
      if (response == null) {
        setState(ServerState.Error);
        return null;
      } else {
        setState(ServerState.Success);
        if (response.lowerLimit <= price) {
          this.couponCode = couponCode;
          this.discountPercentage = response.percentageDiscount;
        }
        return response;
      }
    } catch (e) {
      setState(ServerState.Error);
      return null;
    }
  }

  Future<String> addAddress(String header, String address, String city, String country, String zipCode) async {
    setState(ServerState.Busy);
    try {
      AddAdressInputDTO addAddress = AddAdressInputDTO();
      addAddress.userId = userId;
      addAddress.header = header;
      addAddress.address = address;
      addAddress.city = city;
      addAddress.county = country;
      addAddress.zipcode = zipCode;
      var response = await api.users.addAddress(addAddress);

      if (response == null) {
        setState(ServerState.Error);
        return null;
      } else {
        setState(ServerState.Success);
        return response;
      }
    } catch (e) {
      setState(ServerState.Error);
      return null;
    }
  }

  Future<List<ListAddressOutputDTO>> getUserAddress() async {
    try {
      var response = await api.users.getAddresses(userId);
      if (response != null) {
        return response;
      } else {
        return List();
      }
    } catch (e) {
      return List();
    }
  }

  Future<UserDetailsOutputDTO> getUserDetail() async {
    try {
      var response = await api.users.getUserDetail(userId: userId);
      if (response != null) {
        return response;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<String> updateUser(String name, String email, String phone) async {
    setState(ServerState.Busy);
    try {
      UpdateUserInputDTO updateUserInputDTO = UpdateUserInputDTO();
      updateUserInputDTO.idToken = idToken;
      updateUserInputDTO.name = name;
      updateUserInputDTO.email = email;
      updateUserInputDTO.phone = phone;

      var response = await api.users.updateUser(updateUserInputDTO);
      if (response == "Error") {
        setState(ServerState.Error);
        return "Error";
      } else {
        setState(ServerState.Success);
        nameSurname = name;
        idToken = response;
        decodeIdToken();
        pref.setString(Constants.idToken, response);
        return "Success";
      }
    } catch (e) {
      setState(ServerState.Error);
      return "Error";
    }
  }

  Future<CreditCartDetailsOutputDTO> creditCardDetails(String addressID) async {
    setState(ServerState.Busy);
    try {
      var response = await api.users.creditCartDetails(userId, addressID);
      if (response != null) {
        setState(ServerState.Success);
        return response;
      } else {
        setState(ServerState.Error);
        return null;
      }
    } catch (e) {
      setState(ServerState.Error);
      return null;
    }
  }

  Future<String> addCreditCard(String owner, String cardNumber, String date, String cvc) async {
    setState(ServerState.Busy);
    try {
      AddCreditCartInputDTO card = AddCreditCartInputDTO();
      card.userId = userId;
      card.owner = owner;
      card.cartNumber = cardNumber;
      card.date = date;
      card.cvc = cvc;

      var response = await api.users.addCreditCart(card);
      if (response != null) {
        setState(ServerState.Success);
        return response;
      } else {
        setState(ServerState.Error);
        return null;
      }
    } catch (e) {
      setState(ServerState.Error);
      return null;
    }
  }

  Future<String> updateCreditCard(String owner, String cardNumber, String date, String cvc, String cardID) async {
    setState(ServerState.Busy);
    try {
      UpdateCreditCartInputDTO card = UpdateCreditCartInputDTO();
      card.userId = userId;
      card.owner = owner;
      card.cartNumber = cardNumber;
      card.date = date;
      card.cvc = cvc;
      card.cartId = cardID;

      var response = await api.users.updateCreditCart(card);
      if (response != null) {
        setState(ServerState.Success);
        return response;
      } else {
        setState(ServerState.Error);
        return null;
      }
    } catch (e) {
      setState(ServerState.Error);
      return null;
    }
  }

  Future<AddressDetailsOutputDTO> getAddressDetail(String addressID) async {
    setState(ServerState.Busy);
    try {
      var response = await api.users.addressDetails(userId, addressID);
      if (response != null) {
        setState(ServerState.Error);
        return response;
      } else {
        setState(ServerState.Success);
        return null;
      }
    } catch (e) {
      setState(ServerState.Error);
      return null;
    }
  }

  Future<String> updateAddress(String header, String address, String city, String country, String zipCode, String addressID) async {
    setState(ServerState.Busy);
    try {
      UpdateAddressInputDTO updateAddress = UpdateAddressInputDTO();
      updateAddress.userId = userId;
      updateAddress.addressId = addressID;
      updateAddress.header = header;
      updateAddress.address = address;
      updateAddress.city = city;
      updateAddress.county = country;
      updateAddress.zipcode = zipCode;

      var response = await api.users.updateAddress(updateAddress);
      if (response != "Error") {
        setState(ServerState.Success);
        return "Success";
      } else {
        setState(ServerState.Error);
        return "Error";
      }
    } catch (e) {
      setState(ServerState.Error);
      return "Error";
    }
  }

  Future<String> deleteAddress(String addressID) async {
    setState(ServerState.Busy);
    try {
      DeleteAddressInputDTO dto = DeleteAddressInputDTO();
      dto.userId = userId;
      dto.addressId = addressID;

      var response = await api.users.deleteAddress(dto);
      if (response != "Error") {
        setState(ServerState.Success);
        return "Success";
      } else {
        setState(ServerState.Error);
        return "Error";
      }
    } catch (e) {
      setState(ServerState.Error);
      return "Error";
    }
  }

  Future<List<UserCommentOutputDTO>> getUserComments() async {
    try {
      var response = await api.users.getUserComments(userId);
      if (response != null) {
        return response;
      } else {
        return List();
      }
    } catch (e) {
      return List();
    }
  }

  Future<CommentDetailsOutputDTO> getCommentDetails(String commentID, String productID) async {
    setState(ServerState.Busy);
    try {
      CommentDetailsInputDTO dto = CommentDetailsInputDTO();
      dto.productId = productID;
      dto.commentId = commentID;

      var response = await api.users.commentDetail(dto);
      if (response != null) {
        setState(ServerState.Error);
        return response;
      } else {
        setState(ServerState.Success);
        return null;
      }
    } catch (e) {
      setState(ServerState.Error);
      return null;
    }
  }

  Future<String> deleteComment(String commentID, String productID) async {
    setState(ServerState.Busy);
    try {
      DeleteCommentInputDTO dto = DeleteCommentInputDTO();
      dto.commentId = commentID;
      dto.productId = productID;

      var response = await api.users.deleteComment(dto);
      if (response != "Error") {
        setState(ServerState.Success);
        return "Success";
      } else {
        setState(ServerState.Error);
        return "Error";
      }
    } catch (e) {
      setState(ServerState.Error);
      return "Error";
    }
  }

  Future<String> makeComment(String productID, String commentHeader, String comment, double star) async {
    setState(ServerState.Busy);
    try {
      MakeCommentInputDTO dto = MakeCommentInputDTO();
      dto.userId = userId;
      dto.productId = productID;
      dto.commentHeader = commentHeader;
      dto.comment = comment;
      dto.star = star;

      var response = await api.users.makeComment(dto);
      if (response == "Success") {
        setState(ServerState.Success);
        return "Success";
      } else {
        print(response);
        setState(ServerState.Error);
        return "Error";
      }
    } catch (e) {
      setState(ServerState.Error);
      return "Error";
    }
  }

  Future<String> updateComment(UpdateCommentInputDTO dto) async {
    setState(ServerState.Busy);
    try {
      var response = await api.users.updateComment(dto);
      if (response != "Error") {
        setState(ServerState.Success);
        return "Success";
      } else {
        setState(ServerState.Error);
        return "Error";
      }
    } catch (e) {
      setState(ServerState.Error);
      return "Error";
    }
  }

  Future<List<ListCreditCartsOutputDTO>> getCreditCards() async {
    try {
      var response = await api.users.getCreditCarts(userId);
      if (response != null) {
        return response;
      } else {
        return List();
      }
    } catch (e) {
      return List();
    }
  }

  Future<String> deleteCreditCart(String cartId) async {
    setState(ServerState.Busy);
    try {
      DeleteCreditCartInputDTO dto = DeleteCreditCartInputDTO();
      dto.userId = userId;
      dto.cartId = cartId;

      var response = await api.users.deleteCreditCart(dto);
      if (response != "Error") {
        setState(ServerState.Success);
        return "Success";
      } else {
        setState(ServerState.Error);
        return "Error";
      }
    } catch (e) {
      setState(ServerState.Error);
      return "Error";
    }
  }

  Future<List<ListingCouponsOutputDTO>> getAvailableCoupons() async {
    try {
      var response = await api.users.getAvailableCouponCodes();
      if (response != null) {
        return response;
      } else {
        return List();
      }
    } catch (e) {
      return List();
    }
  }

  //################ORDER#####################

  Future<String> createOrder(double amount) async {
    try {
      CreateOrderInputDTO createOrderInputDTO = CreateOrderInputDTO();
      createOrderInputDTO.userId = userId;
      createOrderInputDTO.addressId = selectedAddress.addressId;
      createOrderInputDTO.cartId = selectedCart.cartId;
      createOrderInputDTO.coupon = couponCode;
      createOrderInputDTO.shippingCompanyId = selectedShippingCompany.companyId;
      createOrderInputDTO.amountPaid = amount;

      var response = await api.order.createOrder(createOrderInputDTO);
      if (response == "Error") {
        return "Error";
      } else if (response == "Insufficient Funds") {
        return "Insufficient Funds";
      } else {
        selectedAddress = null;
        selectedShippingCompany = null;
        selectedCart = null;
        couponCode = null;
        discountPercentage = 0;
        return response;
      }
    } catch (e) {
      return "Error";
    }
  }

  Future<OrderDetailsOutputDTO> getOrderDetail(String orderId) async {
    try {
      var response = await api.order.orderDetails(orderId: orderId);
      if (response == null) {
        return null;
      } else {
        return response;
      }
    } catch (e) {
      return null;
    }
  }

  Future<List<GetOrdersOutputDTO>> getOrders(String state, {bool getALL = false}) async {
    try {
      var response = await api.order.getOrders(state: state, userId: getALL ? null : userId);
      return response;
    } catch (e) {
      return [];
    }
  }

  Future<String> cancelOrder(String orderId) async {
    try {
      CancelOrderInputDTO order = CancelOrderInputDTO();
      order.orderId = orderId;
      var response = await api.order.cancelOrder(order);

      return response;
    } catch (e) {
      return "Error";
    }
  }

  Future<String> acceptOrder(String orderId) async {
    try {
      AcceptOrderInputDTO order = AcceptOrderInputDTO();
      order.orderId = orderId;
      var response = await api.order.acceptOrder(order);

      return response;
    } catch (e) {
      return "Error";
    }
  }

  Future<String> refundOrder(String orderId) async {
    try {
      RefundOrderInputDTO order = RefundOrderInputDTO();
      order.orderId = orderId;
      var response = await api.order.refundOrderRequest(order);
      return response;
    } catch (e) {
      return "Error";
    }
  }
}
