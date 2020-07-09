package com.patates.webapi.Repositories.Firebase;

import com.google.api.core.ApiFuture;
import com.google.cloud.firestore.*;
import com.patates.webapi.Models.Admin.ListingCouponsOutputDTO;
import com.patates.webapi.Models.Admin.UseCouponCodeOutputDTO;
import com.patates.webapi.Models.Product.ProductListingOutputDTO;
import com.patates.webapi.Models.Product.ShoppingCartProductListingOutputDTO;
import com.patates.webapi.Models.User.Address.*;
import com.patates.webapi.Models.User.Comment.*;
import com.patates.webapi.Models.User.CreditCart.*;
import com.patates.webapi.Models.User.ManageUser.SendMessageInputDTO;
import com.patates.webapi.Models.User.ManageUser.UserDetailsOutputDTO;
import com.patates.webapi.Models.User.ShoppingCart.AddToShoppingCartInputDTO;
import com.patates.webapi.Models.User.ShoppingCart.DeleteProductShoppingCartInputDTO;
import com.patates.webapi.Models.User.ShoppingCart.UpdateShoppingCartInputDTO;
import org.springframework.web.bind.annotation.RequestBody;

import java.util.*;
import java.util.concurrent.ExecutionException;

public class UserRepository extends FirebaseConnection {

    public void createUser(String userId, Map<String, Object> data) {

        DocumentReference docRef = db.collection("users").document(userId);
        docRef.set(data);
    }

    public boolean isUserActive(String userId) throws ExecutionException, InterruptedException {
        DocumentSnapshot documentSnapshot = db.collection("users").document(userId).get().get();
        return documentSnapshot.getBoolean("active");
    }


    public String deleteUser(String userId) {
        DocumentReference docRef = db.collection("users").document(userId);
        Map<String, Object> data = new HashMap<>();
        data.put("active", false);
        docRef.update(data);
        return "Success";
    }

    public void updateUser(String userId, Map<String, Object> data) {
        DocumentReference docRef = db.collection("users").document(userId);

        docRef.update(data);

    }

    public String uploadImage(String userId, String photoLink) {

        DocumentReference docRef = db.collection("users").document(userId);

        Map<String, Object> data = new HashMap<>();
        data.put("image-url", photoLink);
        docRef.update(data);

        return "Success";
    }


    public String getFileName(String id) throws ExecutionException, InterruptedException {

        ApiFuture<DocumentSnapshot> queryUser = db.collection("users").document(id).get();
        DocumentSnapshot documentSnapshot = queryUser.get();
        return documentSnapshot.getString("name").toLowerCase().replace(" ", "_");
    }

    public UserDetailsOutputDTO getUserDetail(String id) throws ExecutionException, InterruptedException {
        UserDetailsOutputDTO user = new UserDetailsOutputDTO();
        ApiFuture<DocumentSnapshot> queryUser = db.collection("users").document(id).get();
        DocumentSnapshot documentSnapshot = queryUser.get();

        user.setId(id);
        user.setEmail(documentSnapshot.getString("email"));
        if (documentSnapshot.contains("image-url")) {
            user.setImageUrl(documentSnapshot.getString("image-url"));
        }
        user.setName(documentSnapshot.getString("name"));
        user.setPhone(documentSnapshot.getString("phone"));
        return user;
    }

    public boolean loginIsAdmin(String userId) throws ExecutionException, InterruptedException {
        ApiFuture<DocumentSnapshot> queryUser = db.collection("users").document(userId).get();
        DocumentSnapshot documentSnapshot = queryUser.get();
        try {
            if (documentSnapshot.getBoolean("isAdmin")) {
                return true;
            }

        } catch (Exception e) {

        }
        return false;


    }

    public String loginGetName(String userId) throws ExecutionException, InterruptedException {
        ApiFuture<DocumentSnapshot> queryUser = db.collection("users").document(userId).get();
        DocumentSnapshot documentSnapshot = queryUser.get();

        return documentSnapshot.getString("name");
    }

    public String addToBookmark(String userId, String productId) throws ExecutionException, InterruptedException {
        ApiFuture<DocumentSnapshot> queryUser = db.collection("users").document(userId).get();
        DocumentSnapshot documentSnapshot = queryUser.get();
        ArrayList<String> oldBookmark = new ArrayList<>();

        try {
            oldBookmark = (ArrayList<String>) documentSnapshot.get("bookmarks");
            if (!oldBookmark.contains(productId)) {
                oldBookmark.add(productId);
            }
        } catch (Exception e) {
            oldBookmark = new ArrayList<>();
            oldBookmark.add(productId);

        }

        DocumentReference docRef = db.collection("users").document(userId);

        Map<String, Object> data = new HashMap<>();
        data.put("bookmarks", oldBookmark);

        docRef.update(data);

        return "Success";
    }

    public String deleteFromBookmark(String userId, String productId) throws ExecutionException, InterruptedException {
        ApiFuture<DocumentSnapshot> queryUser = db.collection("users").document(userId).get();
        DocumentSnapshot documentSnapshot = queryUser.get();
        ArrayList<String> oldBookmark = (ArrayList<String>) documentSnapshot.get("bookmarks");
        oldBookmark.remove(productId);

        DocumentReference docRef = db.collection("users").document(userId);

        Map<String, Object> data = new HashMap<>();
        data.put("bookmarks", oldBookmark);

        docRef.update(data);

        return "Success";
    }

    public List<ProductListingOutputDTO> getBookmark(String userId) throws ExecutionException, InterruptedException {
        List<ProductListingOutputDTO> returnList = new ArrayList<>();
        QuerySnapshot queryBookmarkSnapshot = db.collection("users").whereEqualTo(FieldPath.documentId(), userId).get().get();
        for (QueryDocumentSnapshot document : queryBookmarkSnapshot.getDocuments()) {
            for (String productId : (ArrayList<String>) document.get("bookmarks")) {

                DocumentSnapshot documentSnapshot = db.collection("products").document(productId).get().get();

                QuerySnapshot queryPrice = db.collection("products").document(productId).collection("price").get().get();

                returnList.add(new ProductListingOutputDTO(productId, documentSnapshot.getString("image-url"), documentSnapshot.getString("name"), documentSnapshot.getString("author"), queryPrice.getDocuments().get(queryPrice.getDocuments().size() - 1).getDouble("price")));

            }

        }
        return returnList;
    }

    public String addToShoppingCart(AddToShoppingCartInputDTO addToShoppingCartInputDTO) throws ExecutionException, InterruptedException {
        DocumentReference docRef = db.collection("users").document(addToShoppingCartInputDTO.getUserId());

        DocumentReference docRefShoppingCart = docRef.collection("shoppingCart").document(addToShoppingCartInputDTO.getProductId());

        if (docRefShoppingCart.get().get().exists()) {
            return "Same product in shopping cart";
        } else {
            Map<String, Object> data = new HashMap<>();
            data.put("quantity", addToShoppingCartInputDTO.getQuantity());
            docRefShoppingCart.set(data);
            return "Success";
        }
    }

    public List<ShoppingCartProductListingOutputDTO> getShoppingCart(String userId) throws ExecutionException, InterruptedException {
        List<ShoppingCartProductListingOutputDTO> shoppingCartProductList = new ArrayList<>();

        DocumentReference docRef = db.collection("users").document(userId);

        List<QueryDocumentSnapshot> documents = docRef.collection("shoppingCart").get().get().getDocuments();
        for (QueryDocumentSnapshot document : documents) {
            String productId = document.getId();
            DocumentReference productRef = db.collection("products").document(productId);
            DocumentSnapshot productDocument = productRef.get().get();

            List<QueryDocumentSnapshot> priceList = productRef.collection("price").get().get().getDocuments();

            shoppingCartProductList.add(new ShoppingCartProductListingOutputDTO(productId, productDocument.getString("image-url"), productDocument.getString("name"), productDocument.getString("author"), priceList.get(priceList.size() - 1).getDouble("price"), document.getLong("quantity").intValue()));


        }
        return shoppingCartProductList;
    }

    public String updateShoppingCart(UpdateShoppingCartInputDTO updateShoppingCartInputDTO) throws ExecutionException, InterruptedException {
        DocumentReference docRef = db.collection("users").document(updateShoppingCartInputDTO.getUserId());
        DocumentReference shoppingCartReference = docRef.collection("shoppingCart").document(updateShoppingCartInputDTO.getProductId());

        Map<String, Object> data = new HashMap<>();
        data.put("quantity", shoppingCartReference.get().get().getDouble("quantity").intValue() + updateShoppingCartInputDTO.getValue());
        shoppingCartReference.update(data);

        return "Success";

    }

    public String deleteProductShoppingCart(DeleteProductShoppingCartInputDTO deleteProductShoppingCartInputDTO) {
        DocumentReference docRef = db.collection("users").document(deleteProductShoppingCartInputDTO.getUserId());

        DocumentReference shoppingCartReference = docRef.collection("shoppingCart").document(deleteProductShoppingCartInputDTO.getProductId());

        shoppingCartReference.delete();

        return "Success";

    }

    public String addAddress(AddAdressInputDTO addAdressInputDTO) {
        DocumentReference docRef = db.collection("users").document(addAdressInputDTO.getUserId());

        DocumentReference docRefaddress = docRef.collection("addresses").document();

        Map<String, Object> data = new HashMap<>();
        data.put("address", addAdressInputDTO.getAddress());
        data.put("city", addAdressInputDTO.getCity());
        data.put("county", addAdressInputDTO.getCounty());
        data.put("header", addAdressInputDTO.getHeader());
        data.put("zipcode", addAdressInputDTO.getZipcode());
        docRefaddress.set(data);

        return "Success";

    }

    public String updateAddress(UpdateAddressInputDTO updateAddressInputDTO) {
        DocumentReference docRef = db.collection("users").document(updateAddressInputDTO.getUserId());

        DocumentReference docRefaddress = docRef.collection("addresses").document(updateAddressInputDTO.getAddressId());

        Map<String, Object> data = new HashMap<>();
        data.put("address", updateAddressInputDTO.getAddress());
        data.put("city", updateAddressInputDTO.getCity());
        data.put("county", updateAddressInputDTO.getCounty());
        data.put("header", updateAddressInputDTO.getHeader());
        data.put("zipcode", updateAddressInputDTO.getZipcode());
        docRefaddress.update(data);

        return "Success";

    }

    public String deleteAddress(DeleteAddressInputDTO deleteAddressInputDTO) {
        DocumentReference docRef = db.collection("users").document(deleteAddressInputDTO.getUserId());

        DocumentReference docRefaddress = docRef.collection("addresses").document(deleteAddressInputDTO.getAddressId());

        docRefaddress.delete();
        return "Success";

    }

    public List<ListAddressOutputDTO> getAddresses(String userId) throws ExecutionException, InterruptedException {
        List<ListAddressOutputDTO> listAddress = new ArrayList<>();
        DocumentReference docRef = db.collection("users").document(userId);

        List<QueryDocumentSnapshot> documentsList = docRef.collection("addresses").get().get().getDocuments();

        for (QueryDocumentSnapshot document : documentsList) {
            listAddress.add(new ListAddressOutputDTO(document.getId(), document.getString("header"), document.getString("address"), document.getString("city"), document.getString("county")));
        }
        return listAddress;

    }

    public AddressDetailsOutputDTO addressDetails(String userId, String addressId) throws ExecutionException, InterruptedException {
        DocumentReference docRef = db.collection("users").document(userId);

        DocumentSnapshot document = docRef.collection("addresses").document(addressId).get().get();

        return new AddressDetailsOutputDTO(addressId, document.getString("header"), document.getString("address"), document.getString("city"),
                document.getString("county"), document.getString("zipcode"));

    }

    public String addCreditCart(AddCreditCartInputDTO addCreditCartInputDTO, String cartStatus) {

        DocumentReference docRef = db.collection("users").document(addCreditCartInputDTO.getUserId());

        DocumentReference docRefCart = docRef.collection("creditCarts").document(cartStatus);

        Map<String, Object> data = new HashMap<>();
        data.put("owner", addCreditCartInputDTO.getOwner());
        data.put("cartNumber", addCreditCartInputDTO.getCartNumber());
        data.put("date", addCreditCartInputDTO.getDate());
        data.put("cvc", addCreditCartInputDTO.getCvc());
        docRefCart.set(data);

        return "Success";

    }

    public String creditCartExists(String cartNumber, String owner, String date, String cvc) throws ExecutionException, InterruptedException {
        List<QueryDocumentSnapshot> queryDocumentSnapshots = db.collection("creditCarts").whereEqualTo("cartNumber", cartNumber).whereEqualTo("owner", owner)
                .whereEqualTo("date", date).whereEqualTo("cvc", cvc).get().get().getDocuments();

        if (queryDocumentSnapshots.isEmpty()) {
            return "Error";
        } else {
            return queryDocumentSnapshots.get(0).getId();
        }
    }

    public String updateCreditCart(UpdateCreditCartInputDTO updateCreditCartInputDTO, String cartStatus) throws ExecutionException, InterruptedException {
        ApiFuture<String> futureTransaction = db.runTransaction(transaction -> {
            DocumentReference docRef = db.collection("users").document(updateCreditCartInputDTO.getUserId());

            DocumentReference docRefCart = docRef.collection("creditCarts").document(updateCreditCartInputDTO.getCartId());

            transaction.delete(docRefCart);

            DocumentReference docRefNewCart = docRef.collection("creditCarts").document(cartStatus);
            Map<String, Object> data = new HashMap<>();
            data.put("owner", updateCreditCartInputDTO.getOwner());
            data.put("cartNumber", updateCreditCartInputDTO.getCartNumber());
            data.put("date", updateCreditCartInputDTO.getDate());
            data.put("cvc", updateCreditCartInputDTO.getCvc());

            transaction.update(docRefNewCart, data);

            return "Success";
        });

        return futureTransaction.get();
    }

    public String deleteCreditCart(DeleteCreditCartInputDTO deleteCreditCartInputDTO) {
        DocumentReference docRef = db.collection("users").document(deleteCreditCartInputDTO.getUserId());

        DocumentReference docRefCart = docRef.collection("creditCarts").document(deleteCreditCartInputDTO.getCartId());

        docRefCart.delete();
        return "Success";

    }

    public List<ListCreditCartsOutputDTO> getCreditCarts(String userId) throws ExecutionException, InterruptedException {
        List<ListCreditCartsOutputDTO> listCarts = new ArrayList<>();
        DocumentReference docRef = db.collection("users").document(userId);

        List<QueryDocumentSnapshot> documentsList = docRef.collection("creditCarts").get().get().getDocuments();

        for (QueryDocumentSnapshot document : documentsList) {
            listCarts.add(new ListCreditCartsOutputDTO(document.getId(), document.getString("cartNumber"), document.getString("owner"), document.getString("date")));
        }
        return listCarts;

    }

    public CreditCartDetailsOutputDTO creditCartDetails(String userId, String cartId) throws ExecutionException, InterruptedException {
        DocumentReference docRef = db.collection("users").document(userId);

        DocumentSnapshot document = docRef.collection("creditCarts").document(cartId).get().get();

        return new CreditCartDetailsOutputDTO(userId, cartId, document.getString("owner"), document.getString("cartNumber"), document.getString("date"),
                document.getString("cvc"));

    }

    public String makeComment(@RequestBody MakeCommentInputDTO makeCommentInputDTO) {

        DocumentReference docProductRef = db.collection("products").document(makeCommentInputDTO.getProductId()).collection("comments").document();
        Map<String, Object> data = new HashMap<>();
        data.put("userId", makeCommentInputDTO.getUserId());
        data.put("star", makeCommentInputDTO.getStar());
        data.put("commentHeader", makeCommentInputDTO.getCommentHeader());
        data.put("comment", makeCommentInputDTO.getComment());
        docProductRef.set(data);
        return "Success";

    }

    public List<UserCommentOutputDTO> getUserComments(String userId) throws ExecutionException, InterruptedException {
        List<UserCommentOutputDTO> comments = new ArrayList<>();

        List<QueryDocumentSnapshot> productDocuments = db.collection("products").get().get().getDocuments();

        for (QueryDocumentSnapshot product : productDocuments) {
            List<QueryDocumentSnapshot> commentDocuments = product.getReference().collection("comments").get().get().getDocuments();

            for (QueryDocumentSnapshot comment : commentDocuments) {
                if (comment.getString("userId").equals(userId)) {
                    UserCommentOutputDTO userComment = new UserCommentOutputDTO();
                    userComment.setProductId(product.getId());
                    userComment.setCommentId(comment.getId());
                    userComment.setComment(comment.getString("comment"));
                    userComment.setCommentHeader(comment.getString("commentHeader"));
                    userComment.setStar(comment.getDouble("star"));
                    userComment.setName(db.collection("users").document(userId).get().get().getString("name"));
                    userComment.setProductName(product.getString("name"));
                    comments.add(userComment);
                }
            }
        }

        return comments;
    }


    public List<ListingCouponsOutputDTO> getAvailableCouponCodes() throws ExecutionException, InterruptedException {

        ArrayList<ListingCouponsOutputDTO> listOfCouponCodes = new ArrayList();

        List<QueryDocumentSnapshot> documents = db.collection("couponCodes").whereEqualTo("state", true).get().get().getDocuments();

        for (QueryDocumentSnapshot document : documents) {
            if (document.getDate("startTime").compareTo(new Date()) != 1 && document.getDate("expireTime").compareTo(new Date()) != -1 && document.getLong("remainingQuantity").intValue() > 0) {
                listOfCouponCodes.add(new ListingCouponsOutputDTO(document.getId(), document.getString("header"), document.getString("code"), document.getString("description"), document.getDate("expireTime"), document.getDouble("percentageDiscount"), document.getDouble("remainingQuantity"), document.getDouble("startQuantity")));
            }
        }

        return listOfCouponCodes;
    }

    public UseCouponCodeOutputDTO useCouponCode(String code) throws ExecutionException, InterruptedException {
        code = code.toUpperCase(Locale.forLanguageTag("tr"));
        List<QueryDocumentSnapshot> documents = db.collection("couponCodes").whereEqualTo("state", true).whereEqualTo("code", code).get().get().getDocuments();
        if (documents.isEmpty() || documents.get(0).getLong("remainingQuantity").intValue() <= 0 || documents.get(0).getDate("expireTime").compareTo(new Date()) != 1 || documents.get(0).getDate("startTime").compareTo(new Date()) != -1) {
            return null;
        } else {
            return new UseCouponCodeOutputDTO(documents.get(0).getDouble("lowerLimit"), documents.get(0).getDouble("percentageDiscount"));
        }
    }

    public String sendMessage(SendMessageInputDTO sendMessageInputDTO) throws ExecutionException, InterruptedException {
        DocumentReference messageReference = db.collection("messages").document();

        Map<String, Object> data = new HashMap<>();
        data.put("userId", sendMessageInputDTO.getUserId());
        data.put("message", sendMessageInputDTO.getMessage());
        data.put("subject", sendMessageInputDTO.getSubject());
        messageReference.set(data);

        return "Success";
    }

    public String deleteComment(DeleteCommentInputDTO deleteCommentInputDTO) {
        DocumentReference docProductRef = db.collection("products").document(deleteCommentInputDTO.getProductId()).collection("comments").document(deleteCommentInputDTO.getCommentId());
        docProductRef.delete();
        return "Success";
    }

    public String updateComment(UpdateCommentInputDTO updateCommentInputDTO) throws ExecutionException, InterruptedException {

        DocumentReference docProductRef = db.collection("products").document(updateCommentInputDTO.getProductId()).collection("comments").document(updateCommentInputDTO.getCommentId());
        Map<String, Object> data = new HashMap<>();
        data.put("star", updateCommentInputDTO.getStar());
        data.put("commentHeader", updateCommentInputDTO.getCommentHeader());
        data.put("comment", updateCommentInputDTO.getComment());
        docProductRef.update(data);
        return "Success";

    }

    public CommentDetailsOutputDTO commentDetail(CommentDetailsInputDTO commentDetailsInputDTO) throws ExecutionException, InterruptedException {
        DocumentReference commentRef = db.collection("products").document(commentDetailsInputDTO.getProductId()).collection("comments").document(commentDetailsInputDTO.getCommentId());

        DocumentSnapshot comment = commentRef.get().get();

        CommentDetailsOutputDTO userCommentOutputDTO = new CommentDetailsOutputDTO();

        userCommentOutputDTO.setProductId(commentDetailsInputDTO.getProductId());
        userCommentOutputDTO.setCommentId(commentDetailsInputDTO.getCommentId());
        userCommentOutputDTO.setComment(comment.getString("comment"));
        userCommentOutputDTO.setCommentHeader(comment.getString("commentHeader"));
        userCommentOutputDTO.setStar(comment.getDouble("star"));

        return userCommentOutputDTO;
    }

    public boolean accountExists(String email) throws ExecutionException, InterruptedException {
        List<QueryDocumentSnapshot> user = db.collection("users").whereEqualTo("email", email).get().get().getDocuments();
        return !user.isEmpty();
    }
}

