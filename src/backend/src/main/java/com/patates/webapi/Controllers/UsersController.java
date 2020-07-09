package com.patates.webapi.Controllers;

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
import com.patates.webapi.Services.UserServices.FirebaseUserService;
import org.json.JSONException;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.List;
import java.util.concurrent.ExecutionException;

@RestController
@RequestMapping("/api/user")
public class UsersController {
    FirebaseUserService userServices = new FirebaseUserService();

    @RequestMapping(value = "/create", method = RequestMethod.POST)
    public CreateUserOutputDTO createUser(@RequestBody CreateUserInputDTO user) throws IOException, JSONException {
        return userServices.createUser(user);
    }

    @RequestMapping(value = "/deactivate", method = RequestMethod.POST)
    public String deactivateUser(@RequestBody DeleteUserInputDTO idToken) {
        /*
        String userId = userServices.deleteUser(idToken.getIdToken());
        */
        return userServices.deactivateUser(idToken);
    }

    @RequestMapping(value = "/resetPassword", method = RequestMethod.POST)
    public String resetUserPasswordUpdate(@RequestBody PasswordResetInputDTO email) throws UnsupportedEncodingException, ExecutionException, InterruptedException {
        return userServices.resetPassword(email.getEmail());
    }

    @RequestMapping(value = "/login", method = RequestMethod.POST)
    public LoginOutputDTO login(@RequestBody LoginInputDTO loginInputDTO) throws UnsupportedEncodingException {
        return userServices.login(loginInputDTO);
    }

    @RequestMapping(value = "/update", method = RequestMethod.POST)
    public String updateUser(@RequestBody UpdateUserInputDTO user) throws IOException, JSONException {
        return userServices.updateUser(user);
    }

    @RequestMapping(value = "/updatePassword", method = RequestMethod.POST)
    public String updateUserPassword(@RequestBody UpdatePasswordInputDTO user) throws IOException, JSONException {
        return userServices.updateUserPassword(user);
    }

    @RequestMapping(consumes = MediaType.MULTIPART_FORM_DATA_VALUE, value = "/uploadImage", method = RequestMethod.POST)
    public String uploadImage(@RequestParam("file") MultipartFile file, @RequestParam String userId) throws IOException, ExecutionException, InterruptedException {
        return userServices.uploadImage(file, userId);
    }

    @GetMapping(value = "/getUserDetail")
    public UserDetailsOutputDTO getUserDetail(@RequestParam(value = "userId", defaultValue = "") String userId) throws ExecutionException, InterruptedException {
        return userServices.getUserDetail(userId);
    }

    @RequestMapping(value = "/addToBookmark", method = RequestMethod.POST)
    public String addToBookmark(@RequestBody AddBookmarkInputDTO addBookmarkInputDTO) throws ExecutionException, InterruptedException {
        return userServices.addToBookmark(addBookmarkInputDTO);
    }

    @RequestMapping(value = "/deleteFromBookmark", method = RequestMethod.POST)
    public String deleteFromBookmark(@RequestBody DeleteBookmarkInputDTO deleteBookmarkInputDTO) throws ExecutionException, InterruptedException {
        return userServices.deleteFromBookmark(deleteBookmarkInputDTO);
    }

    @RequestMapping(value = "/getBookmark", method = RequestMethod.POST)
    public List<ProductListingOutputDTO> getBookmark(@RequestParam(value = "userId") String userId) throws ExecutionException, InterruptedException {
        return userServices.getBookmark(userId);
    }

    @RequestMapping(value = "/addToShoppingCart", method = RequestMethod.POST)
    public String addToShoppingCart(@RequestBody AddToShoppingCartInputDTO addToShoppingCartInputDTO) throws ExecutionException, InterruptedException {
        return userServices.addToShoppingCart(addToShoppingCartInputDTO);
    }

    @GetMapping(value = "/getShoppingCart")
    public List<ShoppingCartProductListingOutputDTO> getShoppingCart(@RequestParam String userId) throws ExecutionException, InterruptedException {
        return userServices.getShoppingCart(userId);
    }

    @RequestMapping(value = "/updateShoppingCart", method = RequestMethod.POST)
    public String updateShoppingCart(@RequestBody UpdateShoppingCartInputDTO updateShoppingCartInputDTO) throws ExecutionException, InterruptedException {
        return userServices.updateShoppingCart(updateShoppingCartInputDTO);
    }

    @RequestMapping(value = "/deleteProductShoppingCart", method = RequestMethod.POST)
    public String deleteProductShoppingCart(@RequestBody DeleteProductShoppingCartInputDTO deleteProductShoppingCartInputDTO) {
        return userServices.deleteProductShoppingCart(deleteProductShoppingCartInputDTO);
    }

    @RequestMapping(value = "/addAddress", method = RequestMethod.POST)
    public String addAddress(@RequestBody AddAdressInputDTO addAddressInputDTO) {
        return userServices.addAddress(addAddressInputDTO);
    }

    @RequestMapping(value = "/updateAddress", method = RequestMethod.POST)
    public String updateAddress(@RequestBody UpdateAddressInputDTO updateAddressInputDTO) {
        return userServices.updateAddress(updateAddressInputDTO);
    }

    @RequestMapping(value = "/deleteAddress", method = RequestMethod.POST)
    public String deleteAddress(@RequestBody DeleteAddressInputDTO deleteAddressInputDTO) {
        return userServices.deleteAddress(deleteAddressInputDTO);
    }

    @GetMapping(value = "/getAddresses")
    public List<ListAddressOutputDTO> getAddresses(@RequestParam String userId) throws ExecutionException, InterruptedException {
        return userServices.getAddresses(userId);
    }

    @GetMapping(value = "/addressDetails")
    public AddressDetailsOutputDTO addressDetails(@RequestParam String userId, @RequestParam String adressId) throws ExecutionException, InterruptedException {
        return userServices.addressDetails(userId, adressId);
    }

    @RequestMapping(value = "/addCreditCart", method = RequestMethod.POST)
    public String addCreditCart(@RequestBody AddCreditCartInputDTO addCreditCartInputDTO) throws ExecutionException, InterruptedException {
        return userServices.addCreditCart(addCreditCartInputDTO);
    }

    @RequestMapping(value = "/updateCreditCart", method = RequestMethod.POST)
    public String updateCreditCart(@RequestBody UpdateCreditCartInputDTO updateCreditCartInputDTO) throws ExecutionException, InterruptedException {
        return userServices.updateCreditCart(updateCreditCartInputDTO);
    }

    @RequestMapping(value = "/deleteCreditCart", method = RequestMethod.POST)
    public String deleteCreditCart(@RequestBody DeleteCreditCartInputDTO deleteCreditCartInputDTO) throws ExecutionException, InterruptedException {
        return userServices.deleteCreditCart(deleteCreditCartInputDTO);
    }

    @GetMapping(value = "/getCreditCarts")
    public List<ListCreditCartsOutputDTO> getCreditCarts(@RequestParam String userId) throws ExecutionException, InterruptedException {
        return userServices.getCreditCarts(userId);

    }

    @GetMapping(value = "/creditCartDetails")
    public CreditCartDetailsOutputDTO creditCartDetails(@RequestParam String userId, @RequestParam String cartId) throws ExecutionException, InterruptedException {
        return userServices.creditCartDetails(userId, cartId);
    }

    @RequestMapping(value = "/makeComment", method = RequestMethod.POST)
    public String makeComment(@RequestBody MakeCommentInputDTO makeCommentInputDTO) throws ExecutionException, InterruptedException {
        return userServices.makeComment(makeCommentInputDTO);
    }

    @RequestMapping(value = "/commentDetail", method = RequestMethod.POST)
    public CommentDetailsOutputDTO commentDetail(@RequestBody CommentDetailsInputDTO commentDetailsInputDTO) throws ExecutionException, InterruptedException {
        return userServices.commentDetail(commentDetailsInputDTO);
    }

    @RequestMapping(value = "/deleteComment", method = RequestMethod.POST)
    public String deleteComment(@RequestBody DeleteCommentInputDTO deleteCommentInputDTO) throws ExecutionException, InterruptedException {
        return userServices.deleteComment(deleteCommentInputDTO);
    }

    @RequestMapping(value = "/updateComment", method = RequestMethod.POST)
    public String updateComment(@RequestBody UpdateCommentInputDTO updateCommentInputDTO) throws ExecutionException, InterruptedException {
        return userServices.updateComment(updateCommentInputDTO);
    }

    @GetMapping(value = "/getUserComments")
    public List<UserCommentOutputDTO> getUserComments(@RequestParam String userId) throws ExecutionException, InterruptedException {
        return userServices.getUserComments(userId);
    }

    @GetMapping(value = "/getAvailableCouponCodes")
    public List<ListingCouponsOutputDTO> getAvailableCouponCodes() throws ExecutionException, InterruptedException {
        return userServices.getAvailableCouponCodes();
    }

    @GetMapping(value = "/useCouponCode")
    public UseCouponCodeOutputDTO useCouponCode(@RequestParam String code) throws ExecutionException, InterruptedException {
        return userServices.useCouponCode(code);
    }

    @RequestMapping(value = "/sendMessage", method = RequestMethod.POST)
    public String sendMessage(@RequestBody SendMessageInputDTO sendMessageInputDTO) throws ExecutionException, InterruptedException {
        return userServices.sendMessage(sendMessageInputDTO);
    }

}

