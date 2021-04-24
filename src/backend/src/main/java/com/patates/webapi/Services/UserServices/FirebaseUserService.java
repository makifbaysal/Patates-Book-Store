package com.patates.webapi.Services.UserServices;

import com.google.gson.Gson;
import com.patates.webapi.Models.Admin.ListingCouponsOutputDTO;
import com.patates.webapi.Models.Admin.UseCouponCodeOutputDTO;
import com.patates.webapi.Models.Product.ProductListingOutputDTO;
import com.patates.webapi.Models.Product.ShoppingCartProductListingOutputDTO;
import com.patates.webapi.Models.User.Address.*;
import com.patates.webapi.Models.User.Bookmark.AddBookmarkInputDTO;
import com.patates.webapi.Models.User.Bookmark.DeleteBookmarkInputDTO;
import com.patates.webapi.Models.User.Comment.*;
import com.patates.webapi.Models.User.CreditCart.*;
import com.patates.webapi.Models.User.ManageUser.*;
import com.patates.webapi.Models.User.ShoppingCart.AddToShoppingCartInputDTO;
import com.patates.webapi.Models.User.ShoppingCart.DeleteProductShoppingCartInputDTO;
import com.patates.webapi.Models.User.ShoppingCart.UpdateShoppingCartInputDTO;
import com.patates.webapi.Repositories.Firebase.UserRepository;
import com.patates.webapi.Services.PhotoServices.FirebasePhotoService;
import com.patates.webapi.Services.SearchServices.ElasticsearchServices;
import org.apache.commons.codec.binary.Base64;
import org.apache.http.NameValuePair;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.util.EntityUtils;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ExecutionException;

@Service
public class FirebaseUserService implements UserServices {
  private final UserRepository userRepository;
  private final FirebasePhotoService firebasePhotoService;
  private final ElasticsearchServices elasticsearchServices;

  public FirebaseUserService(
      UserRepository userRepository,
      FirebasePhotoService firebasePhotoService,
      ElasticsearchServices elasticsearchServices) {
    this.userRepository = userRepository;
    this.firebasePhotoService = firebasePhotoService;
    this.elasticsearchServices = elasticsearchServices;
  }

  public JSONObject parseIdToken(String idToken) throws JSONException {
    String[] split_string = idToken.split("\\.");
    String base64EncodedBody = split_string[1];
    Base64 base64Url = new Base64(true);
    return (new JSONObject(new String(base64Url.decode(base64EncodedBody))));
  }

  public String signUp(String email, String password) throws UnsupportedEncodingException {
    HttpPost post =
        new HttpPost("https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=APIKEY");

    List<NameValuePair> urlParameters = new ArrayList<>();
    urlParameters.add(new BasicNameValuePair("email", email));
    urlParameters.add(new BasicNameValuePair("password", password));
    urlParameters.add(new BasicNameValuePair("returnSecureToken", "true"));

    post.setEntity(new UrlEncodedFormEntity(urlParameters));

    try (CloseableHttpClient httpClient = HttpClients.createDefault();
        CloseableHttpResponse response = httpClient.execute(post)) {
      JSONObject jsonObject = new JSONObject(EntityUtils.toString(response.getEntity()));

      return jsonObject.getString("idToken");

    } catch (Exception e) {
      return "Error";
    }
  }

  public String emailVerification(String jwtToken) throws UnsupportedEncodingException {
    HttpPost post =
        new HttpPost("https://identitytoolkit.googleapis.com/v1/accounts:sendOobCode?key=APIKEY");

    List<NameValuePair> urlParameters = new ArrayList<>();
    urlParameters.add(new BasicNameValuePair("requestType", "VERIFY_EMAIL"));
    urlParameters.add(new BasicNameValuePair("idToken", jwtToken));

    post.setEntity(new UrlEncodedFormEntity(urlParameters));
    try (CloseableHttpClient httpClient = HttpClients.createDefault();
        CloseableHttpResponse response = httpClient.execute(post)) {
      return jwtToken;
    } catch (Exception e) {
      return "Error";
    }
  }

  /*
  public String deleteUser(String idToken) throws JSONException, UnsupportedEncodingException {
      HttpPost post = new HttpPost("https://identitytoolkit.googleapis.com/v1/accounts:delete?key=APIKEY");

      List<NameValuePair> urlParameters = new ArrayList<>();
      urlParameters.add(new BasicNameValuePair("idToken", idToken));


      post.setEntity(new UrlEncodedFormEntity(urlParameters));

      try (CloseableHttpClient httpClient = HttpClients.createDefault();
           CloseableHttpResponse response = httpClient.execute(post)) {
          return parseIdToken(idToken).getString("user_id");
      } catch (Exception e) {
          return "Error";
      }
  }
  */
  public String resetPassword(String email)
      throws UnsupportedEncodingException, ExecutionException, InterruptedException {
    if (!userRepository.accountExists(email)) {
      return "No such record";
    }
    HttpPost post =
        new HttpPost("https://identitytoolkit.googleapis.com/v1/accounts:sendOobCode?key=APIKEY");

    List<NameValuePair> urlParameters = new ArrayList<>();
    urlParameters.add(new BasicNameValuePair("requestType", "PASSWORD_RESET"));
    urlParameters.add(new BasicNameValuePair("email", email));

    post.setEntity(new UrlEncodedFormEntity(urlParameters));

    try (CloseableHttpClient httpClient = HttpClients.createDefault();
        CloseableHttpResponse response = httpClient.execute(post)) {

      return "Success";
    } catch (Exception e) {
      return "Error";
    }
  }

  public LoginOutputDTO login(LoginInputDTO loginInputDTO) throws UnsupportedEncodingException {

    LoginOutputDTO loginOutputDTO;
    boolean isAdmin;
    String name;
    HttpPost post =
        new HttpPost(
            "https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=APIKEY");

    List<NameValuePair> urlParameters = new ArrayList<>();

    urlParameters.add(new BasicNameValuePair("returnSecureToken", "true"));
    urlParameters.add(new BasicNameValuePair("email", loginInputDTO.getEmail()));
    urlParameters.add(new BasicNameValuePair("password", loginInputDTO.getPassword()));

    post.setEntity(new UrlEncodedFormEntity(urlParameters));

    try (CloseableHttpClient httpClient = HttpClients.createDefault();
        CloseableHttpResponse response = httpClient.execute(post)) {
      JSONObject jsonObject = new JSONObject(EntityUtils.toString(response.getEntity()));
      String idToken = jsonObject.getString("idToken");

      String userId = parseIdToken(idToken).getString("user_id");

      isAdmin = userRepository.loginIsAdmin(userId);

      name = userRepository.loginGetName(userId);

      if (userRepository.isUserActive(userId)) {
        loginOutputDTO = new LoginOutputDTO(idToken, isAdmin, "Success", name);
      } else {
        loginOutputDTO = new LoginOutputDTO(idToken, isAdmin, "Deactive", name);
      }

    } catch (Exception e) {
      loginOutputDTO = new LoginOutputDTO("Error");
    }
    return loginOutputDTO;
  }

  public String update(String email, String idToken) throws UnsupportedEncodingException {
    HttpPost post =
        new HttpPost("https://identitytoolkit.googleapis.com/v1/accounts:update?key=APIKEY");

    List<NameValuePair> urlParameters = new ArrayList<>();

    urlParameters.add(new BasicNameValuePair("returnSecureToken", "true"));
    urlParameters.add(new BasicNameValuePair("email", email));
    urlParameters.add(new BasicNameValuePair("idToken", idToken));

    post.setEntity(new UrlEncodedFormEntity(urlParameters));

    try (CloseableHttpClient httpClient = HttpClients.createDefault();
        CloseableHttpResponse response = httpClient.execute(post)) {
      JSONObject jsonObject = new JSONObject(EntityUtils.toString(response.getEntity()));

      if (jsonObject.has("idToken")) {

        return jsonObject.getString("idToken");

      } else {

        return idToken;
      }

    } catch (Exception e) {
      e.printStackTrace();
      return "Error";
    }
  }

  public String updatePassword(UpdatePasswordInputDTO user) throws UnsupportedEncodingException {
    HttpPost post =
        new HttpPost("https://identitytoolkit.googleapis.com/v1/accounts:update?key=APIKEY");

    List<NameValuePair> urlParameters = new ArrayList<>();

    urlParameters.add(new BasicNameValuePair("returnSecureToken", "true"));
    urlParameters.add(new BasicNameValuePair("password", user.getPassword()));
    urlParameters.add(new BasicNameValuePair("idToken", user.getIdToken()));

    post.setEntity(new UrlEncodedFormEntity(urlParameters));

    try (CloseableHttpClient httpClient = HttpClients.createDefault();
        CloseableHttpResponse response = httpClient.execute(post)) {

      JSONObject jsonObject = new JSONObject(EntityUtils.toString(response.getEntity()));

      return jsonObject.getString("idToken");

    } catch (Exception e) {

      return "Error";
    }
  }

  public String getUserIdFromIdToken(String idToken) throws JSONException {
    return parseIdToken(idToken).getString("user_id");
  }

  public String getEmailFromIdToken(String idToken) throws JSONException {
    return parseIdToken(idToken).getString("email");
  }

  public CreateUserOutputDTO createUser(CreateUserInputDTO user) throws IOException, JSONException {
    CreateUserOutputDTO createUserOutputDTO = new CreateUserOutputDTO();
    String idToken = signUp(user.getEmail(), user.getPassword());

    if (idToken.equals("Error")) {
      createUserOutputDTO.setStatus("Error");
      return createUserOutputDTO;
    } else {

      String userId = getUserIdFromIdToken(idToken);

      Map<String, Object> data = new HashMap<>();

      data.put("email", user.getEmail());

      data.put("name", user.getName());

      data.put("active", true);

      data.put("bookmarks", new ArrayList<String>());

      data.put("isAdmin", false);

      userRepository.createUser(userId, data);

      emailVerification(idToken);

      Gson gson = new Gson();
      elasticsearchServices.addUser(userId, gson.toJson(data));

      return (new CreateUserOutputDTO(user.getName(), idToken, "Success"));
    }
  }

  public String deactivateUser(DeleteUserInputDTO deleteUserInputDTO) {
    if (userRepository.deleteUser(deleteUserInputDTO.getUserId()).equals("Success")) {
      if (!elasticsearchServices.deleteUser(deleteUserInputDTO.getUserId())) {
        return "Error";
      }
    }
    return "Success";
  }

  public String updateUser(UpdateUserInputDTO user) throws IOException, JSONException {
    String idToken = update(user.getEmail(), user.getIdToken());

    Map<String, Object> data = new HashMap<>();
    if (!user.getPhone().equals("")) {
      data.put("phone", user.getPhone());
    }
    data.put("email", user.getEmail());

    data.put("name", user.getName());

    Gson gson = new Gson();

    if (!idToken.equals("Error")) {
      String userId = getUserIdFromIdToken(idToken);
      userRepository.updateUser(userId, data);
      elasticsearchServices.updateUser(userId, gson.toJson(data));
    }
    return idToken;
  }

  public String updateUserPassword(UpdatePasswordInputDTO user) throws IOException, JSONException {

    LoginOutputDTO login =
        login(new LoginInputDTO(getEmailFromIdToken(user.getIdToken()), user.getOldPassword()));
    if (login.getStatus().equals("Error")) {
      return "Error";
    }

    String update = updatePassword(user);

    if (update.equals("Error")) {
      return login.getIdToken();
    }
    return update;
  }

  public String uploadImage(MultipartFile file, String userId)
      throws IOException, ExecutionException, InterruptedException {
    String fileName = userRepository.getFileName(userId);
    String photoLink = firebasePhotoService.uploadImages(fileName, file, "users");
    elasticsearchServices.uploadUserImage(userId, photoLink);
    return userRepository.uploadImage(userId, photoLink);
  }

  public UserDetailsOutputDTO getUserDetail(String userId)
      throws ExecutionException, InterruptedException {
    return userRepository.getUserDetail(userId);
  }

  public String addToBookmark(AddBookmarkInputDTO addBookmarkInputDTO)
      throws ExecutionException, InterruptedException {
    return userRepository.addToBookmark(
        addBookmarkInputDTO.getUserId(), addBookmarkInputDTO.getProductId());
  }

  public String deleteFromBookmark(DeleteBookmarkInputDTO deleteBookmarkInputDTO)
      throws ExecutionException, InterruptedException {
    return userRepository.deleteFromBookmark(
        deleteBookmarkInputDTO.getUserId(), deleteBookmarkInputDTO.getProductId());
  }

  public List<ProductListingOutputDTO> getBookmark(String userId)
      throws ExecutionException, InterruptedException {
    return userRepository.getBookmark(userId);
  }

  public String addToShoppingCart(AddToShoppingCartInputDTO addToShoppingCartInputDTO)
      throws ExecutionException, InterruptedException {
    return userRepository.addToShoppingCart(addToShoppingCartInputDTO);
  }

  public List<ShoppingCartProductListingOutputDTO> getShoppingCart(String userId)
      throws ExecutionException, InterruptedException {
    return userRepository.getShoppingCart(userId);
  }

  public String updateShoppingCart(UpdateShoppingCartInputDTO updateShoppingCartInputDTO)
      throws ExecutionException, InterruptedException {
    return userRepository.updateShoppingCart(updateShoppingCartInputDTO);
  }

  public String deleteProductShoppingCart(
      DeleteProductShoppingCartInputDTO deleteProductShoppingCartInputDTO) {
    return userRepository.deleteProductShoppingCart(deleteProductShoppingCartInputDTO);
  }

  public String addAddress(AddAdressInputDTO addAddressInputDTO) {
    return userRepository.addAddress(addAddressInputDTO);
  }

  public String updateAddress(UpdateAddressInputDTO updateAddressInputDTO) {
    return userRepository.updateAddress(updateAddressInputDTO);
  }

  public String deleteAddress(DeleteAddressInputDTO deleteAddressInputDTO) {
    return userRepository.deleteAddress(deleteAddressInputDTO);
  }

  public List<ListAddressOutputDTO> getAddresses(String userId)
      throws ExecutionException, InterruptedException {
    return userRepository.getAddresses(userId);
  }

  public AddressDetailsOutputDTO addressDetails(String userId, String adressId)
      throws ExecutionException, InterruptedException {
    return userRepository.addressDetails(userId, adressId);
  }

  public String addCreditCart(AddCreditCartInputDTO addCreditCartInputDTO)
      throws ExecutionException, InterruptedException {

    String cartStatus =
        userRepository.creditCartExists(
            addCreditCartInputDTO.getCartNumber(),
            addCreditCartInputDTO.getOwner(),
            addCreditCartInputDTO.getDate(),
            addCreditCartInputDTO.getCvc());
    if (cartStatus.equals("Error")) {
      return "Error";
    } else {
      return userRepository.addCreditCart(addCreditCartInputDTO, cartStatus);
    }
  }

  public String updateCreditCart(UpdateCreditCartInputDTO updateCreditCartInputDTO)
      throws ExecutionException, InterruptedException {
    String cartStatus =
        userRepository.creditCartExists(
            updateCreditCartInputDTO.getCartNumber(),
            updateCreditCartInputDTO.getOwner(),
            updateCreditCartInputDTO.getDate(),
            updateCreditCartInputDTO.getCvc());
    if (cartStatus.equals("Error")) {
      return "Error";
    } else {
      return userRepository.updateCreditCart(updateCreditCartInputDTO, cartStatus);
    }
  }

  public String deleteCreditCart(DeleteCreditCartInputDTO deleteCreditCartInputDTO)
      throws ExecutionException, InterruptedException {
    return userRepository.deleteCreditCart(deleteCreditCartInputDTO);
  }

  public List<ListCreditCartsOutputDTO> getCreditCarts(String userId)
      throws ExecutionException, InterruptedException {
    return userRepository.getCreditCarts(userId);
  }

  public CreditCartDetailsOutputDTO creditCartDetails(String userId, String cartId)
      throws ExecutionException, InterruptedException {
    return userRepository.creditCartDetails(userId, cartId);
  }

  public String makeComment(MakeCommentInputDTO makeCommentInputDTO)
      throws ExecutionException, InterruptedException {
    return userRepository.makeComment(makeCommentInputDTO);
  }

  public List<UserCommentOutputDTO> getUserComments(String userId)
      throws ExecutionException, InterruptedException {
    return userRepository.getUserComments(userId);
  }

  public List<ListingCouponsOutputDTO> getAvailableCouponCodes()
      throws ExecutionException, InterruptedException {
    return userRepository.getAvailableCouponCodes();
  }

  public UseCouponCodeOutputDTO useCouponCode(String code)
      throws ExecutionException, InterruptedException {
    return userRepository.useCouponCode(code);
  }

  public String sendMessage(SendMessageInputDTO sendMessageInputDTO)
      throws ExecutionException, InterruptedException {
    return userRepository.sendMessage(sendMessageInputDTO);
  }

  public String deleteComment(DeleteCommentInputDTO deleteCommentInputDTO) {
    return userRepository.deleteComment(deleteCommentInputDTO);
  }

  public String updateComment(UpdateCommentInputDTO updateCommentInputDTO)
      throws ExecutionException, InterruptedException {
    return userRepository.updateComment(updateCommentInputDTO);
  }

  public CommentDetailsOutputDTO commentDetail(CommentDetailsInputDTO commentDetailsInputDTO)
      throws ExecutionException, InterruptedException {
    return userRepository.commentDetail(commentDetailsInputDTO);
  }
}
