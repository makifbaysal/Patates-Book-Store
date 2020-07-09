part of openapi.api;



class UsersControllerApi {
  final ApiClient apiClient;

  UsersControllerApi([ApiClient apiClient]) : apiClient = apiClient ?? defaultApiClient;

  ///  with HTTP info returned
  ///
  /// 
  Future<Response> addAddressWithHttpInfo(AddAdressInputDTO addAdressInputDTO) async {
    Object postBody = addAdressInputDTO;

    // verify required params are set
    if(addAdressInputDTO == null) {
     throw ApiException(400, "Missing required param: addAdressInputDTO");
    }

    // create path and map variables
    String path = "/api/user/addAddress".replaceAll("{format}","json");

    // query params
    List<QueryParam> queryParams = [];
    Map<String, String> headerParams = {};
    Map<String, String> formParams = {};

    List<String> contentTypes = ["application/json"];

    String contentType = contentTypes.isNotEmpty ? contentTypes[0] : "application/json";
    List<String> authNames = [];

    if(contentType.startsWith("multipart/form-data")) {
      bool hasFields = false;
      MultipartRequest mp = MultipartRequest(null, null);
      if(hasFields)
        postBody = mp;
    }
    else {
    }

    var response = await apiClient.invokeAPI(path,
                                             'POST',
                                             queryParams,
                                             postBody,
                                             headerParams,
                                             formParams,
                                             contentType,
                                             authNames);
    return response;
  }

  /// 
  ///
  /// 
  Future<String> addAddress(AddAdressInputDTO addAdressInputDTO) async {
    Response response = await addAddressWithHttpInfo(addAdressInputDTO);
    if(response.statusCode >= 400) {
      throw ApiException(response.statusCode, _decodeBodyBytes(response));
    } else if(response.body != null) {
      return apiClient.deserialize(_decodeBodyBytes(response), 'String') as String;
    } else {
      return null;
    }
  }

  ///  with HTTP info returned
  ///
  /// 
  Future<Response> addCreditCartWithHttpInfo(AddCreditCartInputDTO addCreditCartInputDTO) async {
    Object postBody = addCreditCartInputDTO;

    // verify required params are set
    if(addCreditCartInputDTO == null) {
     throw ApiException(400, "Missing required param: addCreditCartInputDTO");
    }

    // create path and map variables
    String path = "/api/user/addCreditCart".replaceAll("{format}","json");

    // query params
    List<QueryParam> queryParams = [];
    Map<String, String> headerParams = {};
    Map<String, String> formParams = {};

    List<String> contentTypes = ["application/json"];

    String contentType = contentTypes.isNotEmpty ? contentTypes[0] : "application/json";
    List<String> authNames = [];

    if(contentType.startsWith("multipart/form-data")) {
      bool hasFields = false;
      MultipartRequest mp = MultipartRequest(null, null);
      if(hasFields)
        postBody = mp;
    }
    else {
    }

    var response = await apiClient.invokeAPI(path,
                                             'POST',
                                             queryParams,
                                             postBody,
                                             headerParams,
                                             formParams,
                                             contentType,
                                             authNames);
    return response;
  }

  /// 
  ///
  /// 
  Future<String> addCreditCart(AddCreditCartInputDTO addCreditCartInputDTO) async {
    Response response = await addCreditCartWithHttpInfo(addCreditCartInputDTO);
    if(response.statusCode >= 400) {
      throw ApiException(response.statusCode, _decodeBodyBytes(response));
    } else if(response.body != null) {
      return apiClient.deserialize(_decodeBodyBytes(response), 'String') as String;
    } else {
      return null;
    }
  }

  ///  with HTTP info returned
  ///
  /// 
  Future<Response> addToBookmarkWithHttpInfo(AddBookmarkInputDTO addBookmarkInputDTO) async {
    Object postBody = addBookmarkInputDTO;

    // verify required params are set
    if(addBookmarkInputDTO == null) {
     throw ApiException(400, "Missing required param: addBookmarkInputDTO");
    }

    // create path and map variables
    String path = "/api/user/addToBookmark".replaceAll("{format}","json");

    // query params
    List<QueryParam> queryParams = [];
    Map<String, String> headerParams = {};
    Map<String, String> formParams = {};

    List<String> contentTypes = ["application/json"];

    String contentType = contentTypes.isNotEmpty ? contentTypes[0] : "application/json";
    List<String> authNames = [];

    if(contentType.startsWith("multipart/form-data")) {
      bool hasFields = false;
      MultipartRequest mp = MultipartRequest(null, null);
      if(hasFields)
        postBody = mp;
    }
    else {
    }

    var response = await apiClient.invokeAPI(path,
                                             'POST',
                                             queryParams,
                                             postBody,
                                             headerParams,
                                             formParams,
                                             contentType,
                                             authNames);
    return response;
  }

  /// 
  ///
  /// 
  Future<String> addToBookmark(AddBookmarkInputDTO addBookmarkInputDTO) async {
    Response response = await addToBookmarkWithHttpInfo(addBookmarkInputDTO);
    if(response.statusCode >= 400) {
      throw ApiException(response.statusCode, _decodeBodyBytes(response));
    } else if(response.body != null) {
      return apiClient.deserialize(_decodeBodyBytes(response), 'String') as String;
    } else {
      return null;
    }
  }

  ///  with HTTP info returned
  ///
  /// 
  Future<Response> addToShoppingCartWithHttpInfo(AddToShoppingCartInputDTO addToShoppingCartInputDTO) async {
    Object postBody = addToShoppingCartInputDTO;

    // verify required params are set
    if(addToShoppingCartInputDTO == null) {
     throw ApiException(400, "Missing required param: addToShoppingCartInputDTO");
    }

    // create path and map variables
    String path = "/api/user/addToShoppingCart".replaceAll("{format}","json");

    // query params
    List<QueryParam> queryParams = [];
    Map<String, String> headerParams = {};
    Map<String, String> formParams = {};

    List<String> contentTypes = ["application/json"];

    String contentType = contentTypes.isNotEmpty ? contentTypes[0] : "application/json";
    List<String> authNames = [];

    if(contentType.startsWith("multipart/form-data")) {
      bool hasFields = false;
      MultipartRequest mp = MultipartRequest(null, null);
      if(hasFields)
        postBody = mp;
    }
    else {
    }

    var response = await apiClient.invokeAPI(path,
                                             'POST',
                                             queryParams,
                                             postBody,
                                             headerParams,
                                             formParams,
                                             contentType,
                                             authNames);
    return response;
  }

  /// 
  ///
  /// 
  Future<String> addToShoppingCart(AddToShoppingCartInputDTO addToShoppingCartInputDTO) async {
    Response response = await addToShoppingCartWithHttpInfo(addToShoppingCartInputDTO);
    if(response.statusCode >= 400) {
      throw ApiException(response.statusCode, _decodeBodyBytes(response));
    } else if(response.body != null) {
      return apiClient.deserialize(_decodeBodyBytes(response), 'String') as String;
    } else {
      return null;
    }
  }

  ///  with HTTP info returned
  ///
  /// 
  Future<Response> addressDetailsWithHttpInfo(String userId, String adressId) async {
    Object postBody;

    // verify required params are set
    if(userId == null) {
     throw ApiException(400, "Missing required param: userId");
    }
    if(adressId == null) {
     throw ApiException(400, "Missing required param: adressId");
    }

    // create path and map variables
    String path = "/api/user/addressDetails".replaceAll("{format}","json");

    // query params
    List<QueryParam> queryParams = [];
    Map<String, String> headerParams = {};
    Map<String, String> formParams = {};
      queryParams.addAll(_convertParametersForCollectionFormat("", "userId", userId));
      queryParams.addAll(_convertParametersForCollectionFormat("", "adressId", adressId));

    List<String> contentTypes = [];

    String contentType = contentTypes.isNotEmpty ? contentTypes[0] : "application/json";
    List<String> authNames = [];

    if(contentType.startsWith("multipart/form-data")) {
      bool hasFields = false;
      MultipartRequest mp = MultipartRequest(null, null);
      if(hasFields)
        postBody = mp;
    }
    else {
    }

    var response = await apiClient.invokeAPI(path,
                                             'GET',
                                             queryParams,
                                             postBody,
                                             headerParams,
                                             formParams,
                                             contentType,
                                             authNames);
    return response;
  }

  /// 
  ///
  /// 
  Future<AddressDetailsOutputDTO> addressDetails(String userId, String adressId) async {
    Response response = await addressDetailsWithHttpInfo(userId, adressId);
    if(response.statusCode >= 400) {
      throw ApiException(response.statusCode, _decodeBodyBytes(response));
    } else if(response.body != null) {
      return apiClient.deserialize(_decodeBodyBytes(response), 'AddressDetailsOutputDTO') as AddressDetailsOutputDTO;
    } else {
      return null;
    }
  }

  ///  with HTTP info returned
  ///
  /// 
  Future<Response> commentDetailWithHttpInfo(CommentDetailsInputDTO commentDetailsInputDTO) async {
    Object postBody = commentDetailsInputDTO;

    // verify required params are set
    if(commentDetailsInputDTO == null) {
     throw ApiException(400, "Missing required param: commentDetailsInputDTO");
    }

    // create path and map variables
    String path = "/api/user/commentDetail".replaceAll("{format}","json");

    // query params
    List<QueryParam> queryParams = [];
    Map<String, String> headerParams = {};
    Map<String, String> formParams = {};

    List<String> contentTypes = ["application/json"];

    String contentType = contentTypes.isNotEmpty ? contentTypes[0] : "application/json";
    List<String> authNames = [];

    if(contentType.startsWith("multipart/form-data")) {
      bool hasFields = false;
      MultipartRequest mp = MultipartRequest(null, null);
      if(hasFields)
        postBody = mp;
    }
    else {
    }

    var response = await apiClient.invokeAPI(path,
                                             'POST',
                                             queryParams,
                                             postBody,
                                             headerParams,
                                             formParams,
                                             contentType,
                                             authNames);
    return response;
  }

  /// 
  ///
  /// 
  Future<CommentDetailsOutputDTO> commentDetail(CommentDetailsInputDTO commentDetailsInputDTO) async {
    Response response = await commentDetailWithHttpInfo(commentDetailsInputDTO);
    if(response.statusCode >= 400) {
      throw ApiException(response.statusCode, _decodeBodyBytes(response));
    } else if(response.body != null) {
      return apiClient.deserialize(_decodeBodyBytes(response), 'CommentDetailsOutputDTO') as CommentDetailsOutputDTO;
    } else {
      return null;
    }
  }

  ///  with HTTP info returned
  ///
  /// 
  Future<Response> createUserWithHttpInfo(CreateUserInputDTO createUserInputDTO) async {
    Object postBody = createUserInputDTO;

    // verify required params are set
    if(createUserInputDTO == null) {
     throw ApiException(400, "Missing required param: createUserInputDTO");
    }

    // create path and map variables
    String path = "/api/user/create".replaceAll("{format}","json");

    // query params
    List<QueryParam> queryParams = [];
    Map<String, String> headerParams = {};
    Map<String, String> formParams = {};

    List<String> contentTypes = ["application/json"];

    String contentType = contentTypes.isNotEmpty ? contentTypes[0] : "application/json";
    List<String> authNames = [];

    if(contentType.startsWith("multipart/form-data")) {
      bool hasFields = false;
      MultipartRequest mp = MultipartRequest(null, null);
      if(hasFields)
        postBody = mp;
    }
    else {
    }

    var response = await apiClient.invokeAPI(path,
                                             'POST',
                                             queryParams,
                                             postBody,
                                             headerParams,
                                             formParams,
                                             contentType,
                                             authNames);
    return response;
  }

  /// 
  ///
  /// 
  Future<CreateUserOutputDTO> createUser(CreateUserInputDTO createUserInputDTO) async {
    Response response = await createUserWithHttpInfo(createUserInputDTO);
    if(response.statusCode >= 400) {
      throw ApiException(response.statusCode, _decodeBodyBytes(response));
    } else if(response.body != null) {
      return apiClient.deserialize(_decodeBodyBytes(response), 'CreateUserOutputDTO') as CreateUserOutputDTO;
    } else {
      return null;
    }
  }

  ///  with HTTP info returned
  ///
  /// 
  Future<Response> creditCartDetailsWithHttpInfo(String userId, String cartId) async {
    Object postBody;

    // verify required params are set
    if(userId == null) {
     throw ApiException(400, "Missing required param: userId");
    }
    if(cartId == null) {
     throw ApiException(400, "Missing required param: cartId");
    }

    // create path and map variables
    String path = "/api/user/creditCartDetails".replaceAll("{format}","json");

    // query params
    List<QueryParam> queryParams = [];
    Map<String, String> headerParams = {};
    Map<String, String> formParams = {};
      queryParams.addAll(_convertParametersForCollectionFormat("", "userId", userId));
      queryParams.addAll(_convertParametersForCollectionFormat("", "cartId", cartId));

    List<String> contentTypes = [];

    String contentType = contentTypes.isNotEmpty ? contentTypes[0] : "application/json";
    List<String> authNames = [];

    if(contentType.startsWith("multipart/form-data")) {
      bool hasFields = false;
      MultipartRequest mp = MultipartRequest(null, null);
      if(hasFields)
        postBody = mp;
    }
    else {
    }

    var response = await apiClient.invokeAPI(path,
                                             'GET',
                                             queryParams,
                                             postBody,
                                             headerParams,
                                             formParams,
                                             contentType,
                                             authNames);
    return response;
  }

  /// 
  ///
  /// 
  Future<CreditCartDetailsOutputDTO> creditCartDetails(String userId, String cartId) async {
    Response response = await creditCartDetailsWithHttpInfo(userId, cartId);
    if(response.statusCode >= 400) {
      throw ApiException(response.statusCode, _decodeBodyBytes(response));
    } else if(response.body != null) {
      return apiClient.deserialize(_decodeBodyBytes(response), 'CreditCartDetailsOutputDTO') as CreditCartDetailsOutputDTO;
    } else {
      return null;
    }
  }

  ///  with HTTP info returned
  ///
  /// 
  Future<Response> deactivateUserWithHttpInfo(DeleteUserInputDTO deleteUserInputDTO) async {
    Object postBody = deleteUserInputDTO;

    // verify required params are set
    if(deleteUserInputDTO == null) {
     throw ApiException(400, "Missing required param: deleteUserInputDTO");
    }

    // create path and map variables
    String path = "/api/user/deactivate".replaceAll("{format}","json");

    // query params
    List<QueryParam> queryParams = [];
    Map<String, String> headerParams = {};
    Map<String, String> formParams = {};

    List<String> contentTypes = ["application/json"];

    String contentType = contentTypes.isNotEmpty ? contentTypes[0] : "application/json";
    List<String> authNames = [];

    if(contentType.startsWith("multipart/form-data")) {
      bool hasFields = false;
      MultipartRequest mp = MultipartRequest(null, null);
      if(hasFields)
        postBody = mp;
    }
    else {
    }

    var response = await apiClient.invokeAPI(path,
                                             'POST',
                                             queryParams,
                                             postBody,
                                             headerParams,
                                             formParams,
                                             contentType,
                                             authNames);
    return response;
  }

  /// 
  ///
  /// 
  Future<String> deactivateUser(DeleteUserInputDTO deleteUserInputDTO) async {
    Response response = await deactivateUserWithHttpInfo(deleteUserInputDTO);
    if(response.statusCode >= 400) {
      throw ApiException(response.statusCode, _decodeBodyBytes(response));
    } else if(response.body != null) {
      return apiClient.deserialize(_decodeBodyBytes(response), 'String') as String;
    } else {
      return null;
    }
  }

  ///  with HTTP info returned
  ///
  /// 
  Future<Response> deleteAddressWithHttpInfo(DeleteAddressInputDTO deleteAddressInputDTO) async {
    Object postBody = deleteAddressInputDTO;

    // verify required params are set
    if(deleteAddressInputDTO == null) {
     throw ApiException(400, "Missing required param: deleteAddressInputDTO");
    }

    // create path and map variables
    String path = "/api/user/deleteAddress".replaceAll("{format}","json");

    // query params
    List<QueryParam> queryParams = [];
    Map<String, String> headerParams = {};
    Map<String, String> formParams = {};

    List<String> contentTypes = ["application/json"];

    String contentType = contentTypes.isNotEmpty ? contentTypes[0] : "application/json";
    List<String> authNames = [];

    if(contentType.startsWith("multipart/form-data")) {
      bool hasFields = false;
      MultipartRequest mp = MultipartRequest(null, null);
      if(hasFields)
        postBody = mp;
    }
    else {
    }

    var response = await apiClient.invokeAPI(path,
                                             'POST',
                                             queryParams,
                                             postBody,
                                             headerParams,
                                             formParams,
                                             contentType,
                                             authNames);
    return response;
  }

  /// 
  ///
  /// 
  Future<String> deleteAddress(DeleteAddressInputDTO deleteAddressInputDTO) async {
    Response response = await deleteAddressWithHttpInfo(deleteAddressInputDTO);
    if(response.statusCode >= 400) {
      throw ApiException(response.statusCode, _decodeBodyBytes(response));
    } else if(response.body != null) {
      return apiClient.deserialize(_decodeBodyBytes(response), 'String') as String;
    } else {
      return null;
    }
  }

  ///  with HTTP info returned
  ///
  /// 
  Future<Response> deleteCommentWithHttpInfo(DeleteCommentInputDTO deleteCommentInputDTO) async {
    Object postBody = deleteCommentInputDTO;

    // verify required params are set
    if(deleteCommentInputDTO == null) {
     throw ApiException(400, "Missing required param: deleteCommentInputDTO");
    }

    // create path and map variables
    String path = "/api/user/deleteComment".replaceAll("{format}","json");

    // query params
    List<QueryParam> queryParams = [];
    Map<String, String> headerParams = {};
    Map<String, String> formParams = {};

    List<String> contentTypes = ["application/json"];

    String contentType = contentTypes.isNotEmpty ? contentTypes[0] : "application/json";
    List<String> authNames = [];

    if(contentType.startsWith("multipart/form-data")) {
      bool hasFields = false;
      MultipartRequest mp = MultipartRequest(null, null);
      if(hasFields)
        postBody = mp;
    }
    else {
    }

    var response = await apiClient.invokeAPI(path,
                                             'POST',
                                             queryParams,
                                             postBody,
                                             headerParams,
                                             formParams,
                                             contentType,
                                             authNames);
    return response;
  }

  /// 
  ///
  /// 
  Future<String> deleteComment(DeleteCommentInputDTO deleteCommentInputDTO) async {
    Response response = await deleteCommentWithHttpInfo(deleteCommentInputDTO);
    if(response.statusCode >= 400) {
      throw ApiException(response.statusCode, _decodeBodyBytes(response));
    } else if(response.body != null) {
      return apiClient.deserialize(_decodeBodyBytes(response), 'String') as String;
    } else {
      return null;
    }
  }

  ///  with HTTP info returned
  ///
  /// 
  Future<Response> deleteCreditCartWithHttpInfo(DeleteCreditCartInputDTO deleteCreditCartInputDTO) async {
    Object postBody = deleteCreditCartInputDTO;

    // verify required params are set
    if(deleteCreditCartInputDTO == null) {
     throw ApiException(400, "Missing required param: deleteCreditCartInputDTO");
    }

    // create path and map variables
    String path = "/api/user/deleteCreditCart".replaceAll("{format}","json");

    // query params
    List<QueryParam> queryParams = [];
    Map<String, String> headerParams = {};
    Map<String, String> formParams = {};

    List<String> contentTypes = ["application/json"];

    String contentType = contentTypes.isNotEmpty ? contentTypes[0] : "application/json";
    List<String> authNames = [];

    if(contentType.startsWith("multipart/form-data")) {
      bool hasFields = false;
      MultipartRequest mp = MultipartRequest(null, null);
      if(hasFields)
        postBody = mp;
    }
    else {
    }

    var response = await apiClient.invokeAPI(path,
                                             'POST',
                                             queryParams,
                                             postBody,
                                             headerParams,
                                             formParams,
                                             contentType,
                                             authNames);
    return response;
  }

  /// 
  ///
  /// 
  Future<String> deleteCreditCart(DeleteCreditCartInputDTO deleteCreditCartInputDTO) async {
    Response response = await deleteCreditCartWithHttpInfo(deleteCreditCartInputDTO);
    if(response.statusCode >= 400) {
      throw ApiException(response.statusCode, _decodeBodyBytes(response));
    } else if(response.body != null) {
      return apiClient.deserialize(_decodeBodyBytes(response), 'String') as String;
    } else {
      return null;
    }
  }

  ///  with HTTP info returned
  ///
  /// 
  Future<Response> deleteFromBookmarkWithHttpInfo(DeleteBookmarkInputDTO deleteBookmarkInputDTO) async {
    Object postBody = deleteBookmarkInputDTO;

    // verify required params are set
    if(deleteBookmarkInputDTO == null) {
     throw ApiException(400, "Missing required param: deleteBookmarkInputDTO");
    }

    // create path and map variables
    String path = "/api/user/deleteFromBookmark".replaceAll("{format}","json");

    // query params
    List<QueryParam> queryParams = [];
    Map<String, String> headerParams = {};
    Map<String, String> formParams = {};

    List<String> contentTypes = ["application/json"];

    String contentType = contentTypes.isNotEmpty ? contentTypes[0] : "application/json";
    List<String> authNames = [];

    if(contentType.startsWith("multipart/form-data")) {
      bool hasFields = false;
      MultipartRequest mp = MultipartRequest(null, null);
      if(hasFields)
        postBody = mp;
    }
    else {
    }

    var response = await apiClient.invokeAPI(path,
                                             'POST',
                                             queryParams,
                                             postBody,
                                             headerParams,
                                             formParams,
                                             contentType,
                                             authNames);
    return response;
  }

  /// 
  ///
  /// 
  Future<String> deleteFromBookmark(DeleteBookmarkInputDTO deleteBookmarkInputDTO) async {
    Response response = await deleteFromBookmarkWithHttpInfo(deleteBookmarkInputDTO);
    if(response.statusCode >= 400) {
      throw ApiException(response.statusCode, _decodeBodyBytes(response));
    } else if(response.body != null) {
      return apiClient.deserialize(_decodeBodyBytes(response), 'String') as String;
    } else {
      return null;
    }
  }

  ///  with HTTP info returned
  ///
  /// 
  Future<Response> deleteProductShoppingCartWithHttpInfo(DeleteProductShoppingCartInputDTO deleteProductShoppingCartInputDTO) async {
    Object postBody = deleteProductShoppingCartInputDTO;

    // verify required params are set
    if(deleteProductShoppingCartInputDTO == null) {
     throw ApiException(400, "Missing required param: deleteProductShoppingCartInputDTO");
    }

    // create path and map variables
    String path = "/api/user/deleteProductShoppingCart".replaceAll("{format}","json");

    // query params
    List<QueryParam> queryParams = [];
    Map<String, String> headerParams = {};
    Map<String, String> formParams = {};

    List<String> contentTypes = ["application/json"];

    String contentType = contentTypes.isNotEmpty ? contentTypes[0] : "application/json";
    List<String> authNames = [];

    if(contentType.startsWith("multipart/form-data")) {
      bool hasFields = false;
      MultipartRequest mp = MultipartRequest(null, null);
      if(hasFields)
        postBody = mp;
    }
    else {
    }

    var response = await apiClient.invokeAPI(path,
                                             'POST',
                                             queryParams,
                                             postBody,
                                             headerParams,
                                             formParams,
                                             contentType,
                                             authNames);
    return response;
  }

  /// 
  ///
  /// 
  Future<String> deleteProductShoppingCart(DeleteProductShoppingCartInputDTO deleteProductShoppingCartInputDTO) async {
    Response response = await deleteProductShoppingCartWithHttpInfo(deleteProductShoppingCartInputDTO);
    if(response.statusCode >= 400) {
      throw ApiException(response.statusCode, _decodeBodyBytes(response));
    } else if(response.body != null) {
      return apiClient.deserialize(_decodeBodyBytes(response), 'String') as String;
    } else {
      return null;
    }
  }

  ///  with HTTP info returned
  ///
  /// 
  Future<Response> getAddressesWithHttpInfo(String userId) async {
    Object postBody;

    // verify required params are set
    if(userId == null) {
     throw ApiException(400, "Missing required param: userId");
    }

    // create path and map variables
    String path = "/api/user/getAddresses".replaceAll("{format}","json");

    // query params
    List<QueryParam> queryParams = [];
    Map<String, String> headerParams = {};
    Map<String, String> formParams = {};
      queryParams.addAll(_convertParametersForCollectionFormat("", "userId", userId));

    List<String> contentTypes = [];

    String contentType = contentTypes.isNotEmpty ? contentTypes[0] : "application/json";
    List<String> authNames = [];

    if(contentType.startsWith("multipart/form-data")) {
      bool hasFields = false;
      MultipartRequest mp = MultipartRequest(null, null);
      if(hasFields)
        postBody = mp;
    }
    else {
    }

    var response = await apiClient.invokeAPI(path,
                                             'GET',
                                             queryParams,
                                             postBody,
                                             headerParams,
                                             formParams,
                                             contentType,
                                             authNames);
    return response;
  }

  /// 
  ///
  /// 
  Future<List<ListAddressOutputDTO>> getAddresses(String userId) async {
    Response response = await getAddressesWithHttpInfo(userId);
    if(response.statusCode >= 400) {
      throw ApiException(response.statusCode, _decodeBodyBytes(response));
    } else if(response.body != null) {
      return (apiClient.deserialize(_decodeBodyBytes(response), 'List<ListAddressOutputDTO>') as List).map((item) => item as ListAddressOutputDTO).toList();
    } else {
      return null;
    }
  }

  ///  with HTTP info returned
  ///
  /// 
  Future<Response> getAvailableCouponCodesWithHttpInfo() async {
    Object postBody;

    // verify required params are set

    // create path and map variables
    String path = "/api/user/getAvailableCouponCodes".replaceAll("{format}","json");

    // query params
    List<QueryParam> queryParams = [];
    Map<String, String> headerParams = {};
    Map<String, String> formParams = {};

    List<String> contentTypes = [];

    String contentType = contentTypes.isNotEmpty ? contentTypes[0] : "application/json";
    List<String> authNames = [];

    if(contentType.startsWith("multipart/form-data")) {
      bool hasFields = false;
      MultipartRequest mp = MultipartRequest(null, null);
      if(hasFields)
        postBody = mp;
    }
    else {
    }

    var response = await apiClient.invokeAPI(path,
                                             'GET',
                                             queryParams,
                                             postBody,
                                             headerParams,
                                             formParams,
                                             contentType,
                                             authNames);
    return response;
  }

  /// 
  ///
  /// 
  Future<List<ListingCouponsOutputDTO>> getAvailableCouponCodes() async {
    Response response = await getAvailableCouponCodesWithHttpInfo();
    if(response.statusCode >= 400) {
      throw ApiException(response.statusCode, _decodeBodyBytes(response));
    } else if(response.body != null) {
      return (apiClient.deserialize(_decodeBodyBytes(response), 'List<ListingCouponsOutputDTO>') as List).map((item) => item as ListingCouponsOutputDTO).toList();
    } else {
      return null;
    }
  }

  ///  with HTTP info returned
  ///
  /// 
  Future<Response> getBookmarkWithHttpInfo(String userId) async {
    Object postBody;

    // verify required params are set
    if(userId == null) {
     throw ApiException(400, "Missing required param: userId");
    }

    // create path and map variables
    String path = "/api/user/getBookmark".replaceAll("{format}","json");

    // query params
    List<QueryParam> queryParams = [];
    Map<String, String> headerParams = {};
    Map<String, String> formParams = {};
      queryParams.addAll(_convertParametersForCollectionFormat("", "userId", userId));

    List<String> contentTypes = [];

    String contentType = contentTypes.isNotEmpty ? contentTypes[0] : "application/json";
    List<String> authNames = [];

    if(contentType.startsWith("multipart/form-data")) {
      bool hasFields = false;
      MultipartRequest mp = MultipartRequest(null, null);
      if(hasFields)
        postBody = mp;
    }
    else {
    }

    var response = await apiClient.invokeAPI(path,
                                             'POST',
                                             queryParams,
                                             postBody,
                                             headerParams,
                                             formParams,
                                             contentType,
                                             authNames);
    return response;
  }

  /// 
  ///
  /// 
  Future<List<ProductListingOutputDTO>> getBookmark(String userId) async {
    Response response = await getBookmarkWithHttpInfo(userId);
    if(response.statusCode >= 400) {
      throw ApiException(response.statusCode, _decodeBodyBytes(response));
    } else if(response.body != null) {
      return (apiClient.deserialize(_decodeBodyBytes(response), 'List<ProductListingOutputDTO>') as List).map((item) => item as ProductListingOutputDTO).toList();
    } else {
      return null;
    }
  }

  ///  with HTTP info returned
  ///
  /// 
  Future<Response> getCreditCartsWithHttpInfo(String userId) async {
    Object postBody;

    // verify required params are set
    if(userId == null) {
     throw ApiException(400, "Missing required param: userId");
    }

    // create path and map variables
    String path = "/api/user/getCreditCarts".replaceAll("{format}","json");

    // query params
    List<QueryParam> queryParams = [];
    Map<String, String> headerParams = {};
    Map<String, String> formParams = {};
      queryParams.addAll(_convertParametersForCollectionFormat("", "userId", userId));

    List<String> contentTypes = [];

    String contentType = contentTypes.isNotEmpty ? contentTypes[0] : "application/json";
    List<String> authNames = [];

    if(contentType.startsWith("multipart/form-data")) {
      bool hasFields = false;
      MultipartRequest mp = MultipartRequest(null, null);
      if(hasFields)
        postBody = mp;
    }
    else {
    }

    var response = await apiClient.invokeAPI(path,
                                             'GET',
                                             queryParams,
                                             postBody,
                                             headerParams,
                                             formParams,
                                             contentType,
                                             authNames);
    return response;
  }

  /// 
  ///
  /// 
  Future<List<ListCreditCartsOutputDTO>> getCreditCarts(String userId) async {
    Response response = await getCreditCartsWithHttpInfo(userId);
    if(response.statusCode >= 400) {
      throw ApiException(response.statusCode, _decodeBodyBytes(response));
    } else if(response.body != null) {
      return (apiClient.deserialize(_decodeBodyBytes(response), 'List<ListCreditCartsOutputDTO>') as List).map((item) => item as ListCreditCartsOutputDTO).toList();
    } else {
      return null;
    }
  }

  ///  with HTTP info returned
  ///
  /// 
  Future<Response> getShoppingCartWithHttpInfo(String userId) async {
    Object postBody;

    // verify required params are set
    if(userId == null) {
     throw ApiException(400, "Missing required param: userId");
    }

    // create path and map variables
    String path = "/api/user/getShoppingCart".replaceAll("{format}","json");

    // query params
    List<QueryParam> queryParams = [];
    Map<String, String> headerParams = {};
    Map<String, String> formParams = {};
      queryParams.addAll(_convertParametersForCollectionFormat("", "userId", userId));

    List<String> contentTypes = [];

    String contentType = contentTypes.isNotEmpty ? contentTypes[0] : "application/json";
    List<String> authNames = [];

    if(contentType.startsWith("multipart/form-data")) {
      bool hasFields = false;
      MultipartRequest mp = MultipartRequest(null, null);
      if(hasFields)
        postBody = mp;
    }
    else {
    }

    var response = await apiClient.invokeAPI(path,
                                             'GET',
                                             queryParams,
                                             postBody,
                                             headerParams,
                                             formParams,
                                             contentType,
                                             authNames);
    return response;
  }

  /// 
  ///
  /// 
  Future<List<ShoppingCartProductListingOutputDTO>> getShoppingCart(String userId) async {
    Response response = await getShoppingCartWithHttpInfo(userId);
    if(response.statusCode >= 400) {
      throw ApiException(response.statusCode, _decodeBodyBytes(response));
    } else if(response.body != null) {
      return (apiClient.deserialize(_decodeBodyBytes(response), 'List<ShoppingCartProductListingOutputDTO>') as List).map((item) => item as ShoppingCartProductListingOutputDTO).toList();
    } else {
      return null;
    }
  }

  ///  with HTTP info returned
  ///
  /// 
  Future<Response> getUserCommentsWithHttpInfo(String userId) async {
    Object postBody;

    // verify required params are set
    if(userId == null) {
     throw ApiException(400, "Missing required param: userId");
    }

    // create path and map variables
    String path = "/api/user/getUserComments".replaceAll("{format}","json");

    // query params
    List<QueryParam> queryParams = [];
    Map<String, String> headerParams = {};
    Map<String, String> formParams = {};
      queryParams.addAll(_convertParametersForCollectionFormat("", "userId", userId));

    List<String> contentTypes = [];

    String contentType = contentTypes.isNotEmpty ? contentTypes[0] : "application/json";
    List<String> authNames = [];

    if(contentType.startsWith("multipart/form-data")) {
      bool hasFields = false;
      MultipartRequest mp = MultipartRequest(null, null);
      if(hasFields)
        postBody = mp;
    }
    else {
    }

    var response = await apiClient.invokeAPI(path,
                                             'GET',
                                             queryParams,
                                             postBody,
                                             headerParams,
                                             formParams,
                                             contentType,
                                             authNames);
    return response;
  }

  /// 
  ///
  /// 
  Future<List<UserCommentOutputDTO>> getUserComments(String userId) async {
    Response response = await getUserCommentsWithHttpInfo(userId);
    if(response.statusCode >= 400) {
      throw ApiException(response.statusCode, _decodeBodyBytes(response));
    } else if(response.body != null) {
      return (apiClient.deserialize(_decodeBodyBytes(response), 'List<UserCommentOutputDTO>') as List).map((item) => item as UserCommentOutputDTO).toList();
    } else {
      return null;
    }
  }

  ///  with HTTP info returned
  ///
  /// 
  Future<Response> getUserDetailWithHttpInfo({ String userId }) async {
    Object postBody;

    // verify required params are set

    // create path and map variables
    String path = "/api/user/getUserDetail".replaceAll("{format}","json");

    // query params
    List<QueryParam> queryParams = [];
    Map<String, String> headerParams = {};
    Map<String, String> formParams = {};
    if(userId != null) {
      queryParams.addAll(_convertParametersForCollectionFormat("", "userId", userId));
    }

    List<String> contentTypes = [];

    String contentType = contentTypes.isNotEmpty ? contentTypes[0] : "application/json";
    List<String> authNames = [];

    if(contentType.startsWith("multipart/form-data")) {
      bool hasFields = false;
      MultipartRequest mp = MultipartRequest(null, null);
      if(hasFields)
        postBody = mp;
    }
    else {
    }

    var response = await apiClient.invokeAPI(path,
                                             'GET',
                                             queryParams,
                                             postBody,
                                             headerParams,
                                             formParams,
                                             contentType,
                                             authNames);
    return response;
  }

  /// 
  ///
  /// 
  Future<UserDetailsOutputDTO> getUserDetail({ String userId }) async {
    Response response = await getUserDetailWithHttpInfo( userId: userId );
    if(response.statusCode >= 400) {
      throw ApiException(response.statusCode, _decodeBodyBytes(response));
    } else if(response.body != null) {
      return apiClient.deserialize(_decodeBodyBytes(response), 'UserDetailsOutputDTO') as UserDetailsOutputDTO;
    } else {
      return null;
    }
  }

  ///  with HTTP info returned
  ///
  /// 
  Future<Response> loginWithHttpInfo(LoginInputDTO loginInputDTO) async {
    Object postBody = loginInputDTO;

    // verify required params are set
    if(loginInputDTO == null) {
     throw ApiException(400, "Missing required param: loginInputDTO");
    }

    // create path and map variables
    String path = "/api/user/login".replaceAll("{format}","json");

    // query params
    List<QueryParam> queryParams = [];
    Map<String, String> headerParams = {};
    Map<String, String> formParams = {};

    List<String> contentTypes = ["application/json"];

    String contentType = contentTypes.isNotEmpty ? contentTypes[0] : "application/json";
    List<String> authNames = [];

    if(contentType.startsWith("multipart/form-data")) {
      bool hasFields = false;
      MultipartRequest mp = MultipartRequest(null, null);
      if(hasFields)
        postBody = mp;
    }
    else {
    }

    var response = await apiClient.invokeAPI(path,
                                             'POST',
                                             queryParams,
                                             postBody,
                                             headerParams,
                                             formParams,
                                             contentType,
                                             authNames);
    return response;
  }

  /// 
  ///
  /// 
  Future<LoginOutputDTO> login(LoginInputDTO loginInputDTO) async {
    Response response = await loginWithHttpInfo(loginInputDTO);
    if(response.statusCode >= 400) {
      throw ApiException(response.statusCode, _decodeBodyBytes(response));
    } else if(response.body != null) {
      return apiClient.deserialize(_decodeBodyBytes(response), 'LoginOutputDTO') as LoginOutputDTO;
    } else {
      return null;
    }
  }

  ///  with HTTP info returned
  ///
  /// 
  Future<Response> makeCommentWithHttpInfo(MakeCommentInputDTO makeCommentInputDTO) async {
    Object postBody = makeCommentInputDTO;

    // verify required params are set
    if(makeCommentInputDTO == null) {
     throw ApiException(400, "Missing required param: makeCommentInputDTO");
    }

    // create path and map variables
    String path = "/api/user/makeComment".replaceAll("{format}","json");

    // query params
    List<QueryParam> queryParams = [];
    Map<String, String> headerParams = {};
    Map<String, String> formParams = {};

    List<String> contentTypes = ["application/json"];

    String contentType = contentTypes.isNotEmpty ? contentTypes[0] : "application/json";
    List<String> authNames = [];

    if(contentType.startsWith("multipart/form-data")) {
      bool hasFields = false;
      MultipartRequest mp = MultipartRequest(null, null);
      if(hasFields)
        postBody = mp;
    }
    else {
    }

    var response = await apiClient.invokeAPI(path,
                                             'POST',
                                             queryParams,
                                             postBody,
                                             headerParams,
                                             formParams,
                                             contentType,
                                             authNames);
    return response;
  }

  /// 
  ///
  /// 
  Future<String> makeComment(MakeCommentInputDTO makeCommentInputDTO) async {
    Response response = await makeCommentWithHttpInfo(makeCommentInputDTO);
    if(response.statusCode >= 400) {
      throw ApiException(response.statusCode, _decodeBodyBytes(response));
    } else if(response.body != null) {
      return apiClient.deserialize(_decodeBodyBytes(response), 'String') as String;
    } else {
      return null;
    }
  }

  ///  with HTTP info returned
  ///
  /// 
  Future<Response> resetUserPasswordUpdateWithHttpInfo(PasswordResetInputDTO passwordResetInputDTO) async {
    Object postBody = passwordResetInputDTO;

    // verify required params are set
    if(passwordResetInputDTO == null) {
     throw ApiException(400, "Missing required param: passwordResetInputDTO");
    }

    // create path and map variables
    String path = "/api/user/resetPassword".replaceAll("{format}","json");

    // query params
    List<QueryParam> queryParams = [];
    Map<String, String> headerParams = {};
    Map<String, String> formParams = {};

    List<String> contentTypes = ["application/json"];

    String contentType = contentTypes.isNotEmpty ? contentTypes[0] : "application/json";
    List<String> authNames = [];

    if(contentType.startsWith("multipart/form-data")) {
      bool hasFields = false;
      MultipartRequest mp = MultipartRequest(null, null);
      if(hasFields)
        postBody = mp;
    }
    else {
    }

    var response = await apiClient.invokeAPI(path,
                                             'POST',
                                             queryParams,
                                             postBody,
                                             headerParams,
                                             formParams,
                                             contentType,
                                             authNames);
    return response;
  }

  /// 
  ///
  /// 
  Future<String> resetUserPasswordUpdate(PasswordResetInputDTO passwordResetInputDTO) async {
    Response response = await resetUserPasswordUpdateWithHttpInfo(passwordResetInputDTO);
    if(response.statusCode >= 400) {
      throw ApiException(response.statusCode, _decodeBodyBytes(response));
    } else if(response.body != null) {
      return apiClient.deserialize(_decodeBodyBytes(response), 'String') as String;
    } else {
      return null;
    }
  }

  ///  with HTTP info returned
  ///
  /// 
  Future<Response> sendMessageWithHttpInfo(SendMessageInputDTO sendMessageInputDTO) async {
    Object postBody = sendMessageInputDTO;

    // verify required params are set
    if(sendMessageInputDTO == null) {
     throw ApiException(400, "Missing required param: sendMessageInputDTO");
    }

    // create path and map variables
    String path = "/api/user/sendMessage".replaceAll("{format}","json");

    // query params
    List<QueryParam> queryParams = [];
    Map<String, String> headerParams = {};
    Map<String, String> formParams = {};

    List<String> contentTypes = ["application/json"];

    String contentType = contentTypes.isNotEmpty ? contentTypes[0] : "application/json";
    List<String> authNames = [];

    if(contentType.startsWith("multipart/form-data")) {
      bool hasFields = false;
      MultipartRequest mp = MultipartRequest(null, null);
      if(hasFields)
        postBody = mp;
    }
    else {
    }

    var response = await apiClient.invokeAPI(path,
                                             'POST',
                                             queryParams,
                                             postBody,
                                             headerParams,
                                             formParams,
                                             contentType,
                                             authNames);
    return response;
  }

  /// 
  ///
  /// 
  Future<String> sendMessage(SendMessageInputDTO sendMessageInputDTO) async {
    Response response = await sendMessageWithHttpInfo(sendMessageInputDTO);
    if(response.statusCode >= 400) {
      throw ApiException(response.statusCode, _decodeBodyBytes(response));
    } else if(response.body != null) {
      return apiClient.deserialize(_decodeBodyBytes(response), 'String') as String;
    } else {
      return null;
    }
  }

  ///  with HTTP info returned
  ///
  /// 
  Future<Response> updateAddressWithHttpInfo(UpdateAddressInputDTO updateAddressInputDTO) async {
    Object postBody = updateAddressInputDTO;

    // verify required params are set
    if(updateAddressInputDTO == null) {
     throw ApiException(400, "Missing required param: updateAddressInputDTO");
    }

    // create path and map variables
    String path = "/api/user/updateAddress".replaceAll("{format}","json");

    // query params
    List<QueryParam> queryParams = [];
    Map<String, String> headerParams = {};
    Map<String, String> formParams = {};

    List<String> contentTypes = ["application/json"];

    String contentType = contentTypes.isNotEmpty ? contentTypes[0] : "application/json";
    List<String> authNames = [];

    if(contentType.startsWith("multipart/form-data")) {
      bool hasFields = false;
      MultipartRequest mp = MultipartRequest(null, null);
      if(hasFields)
        postBody = mp;
    }
    else {
    }

    var response = await apiClient.invokeAPI(path,
                                             'POST',
                                             queryParams,
                                             postBody,
                                             headerParams,
                                             formParams,
                                             contentType,
                                             authNames);
    return response;
  }

  /// 
  ///
  /// 
  Future<String> updateAddress(UpdateAddressInputDTO updateAddressInputDTO) async {
    Response response = await updateAddressWithHttpInfo(updateAddressInputDTO);
    if(response.statusCode >= 400) {
      throw ApiException(response.statusCode, _decodeBodyBytes(response));
    } else if(response.body != null) {
      return apiClient.deserialize(_decodeBodyBytes(response), 'String') as String;
    } else {
      return null;
    }
  }

  ///  with HTTP info returned
  ///
  /// 
  Future<Response> updateCommentWithHttpInfo(UpdateCommentInputDTO updateCommentInputDTO) async {
    Object postBody = updateCommentInputDTO;

    // verify required params are set
    if(updateCommentInputDTO == null) {
     throw ApiException(400, "Missing required param: updateCommentInputDTO");
    }

    // create path and map variables
    String path = "/api/user/updateComment".replaceAll("{format}","json");

    // query params
    List<QueryParam> queryParams = [];
    Map<String, String> headerParams = {};
    Map<String, String> formParams = {};

    List<String> contentTypes = ["application/json"];

    String contentType = contentTypes.isNotEmpty ? contentTypes[0] : "application/json";
    List<String> authNames = [];

    if(contentType.startsWith("multipart/form-data")) {
      bool hasFields = false;
      MultipartRequest mp = MultipartRequest(null, null);
      if(hasFields)
        postBody = mp;
    }
    else {
    }

    var response = await apiClient.invokeAPI(path,
                                             'POST',
                                             queryParams,
                                             postBody,
                                             headerParams,
                                             formParams,
                                             contentType,
                                             authNames);
    return response;
  }

  /// 
  ///
  /// 
  Future<String> updateComment(UpdateCommentInputDTO updateCommentInputDTO) async {
    Response response = await updateCommentWithHttpInfo(updateCommentInputDTO);
    if(response.statusCode >= 400) {
      throw ApiException(response.statusCode, _decodeBodyBytes(response));
    } else if(response.body != null) {
      return apiClient.deserialize(_decodeBodyBytes(response), 'String') as String;
    } else {
      return null;
    }
  }

  ///  with HTTP info returned
  ///
  /// 
  Future<Response> updateCreditCartWithHttpInfo(UpdateCreditCartInputDTO updateCreditCartInputDTO) async {
    Object postBody = updateCreditCartInputDTO;

    // verify required params are set
    if(updateCreditCartInputDTO == null) {
     throw ApiException(400, "Missing required param: updateCreditCartInputDTO");
    }

    // create path and map variables
    String path = "/api/user/updateCreditCart".replaceAll("{format}","json");

    // query params
    List<QueryParam> queryParams = [];
    Map<String, String> headerParams = {};
    Map<String, String> formParams = {};

    List<String> contentTypes = ["application/json"];

    String contentType = contentTypes.isNotEmpty ? contentTypes[0] : "application/json";
    List<String> authNames = [];

    if(contentType.startsWith("multipart/form-data")) {
      bool hasFields = false;
      MultipartRequest mp = MultipartRequest(null, null);
      if(hasFields)
        postBody = mp;
    }
    else {
    }

    var response = await apiClient.invokeAPI(path,
                                             'POST',
                                             queryParams,
                                             postBody,
                                             headerParams,
                                             formParams,
                                             contentType,
                                             authNames);
    return response;
  }

  /// 
  ///
  /// 
  Future<String> updateCreditCart(UpdateCreditCartInputDTO updateCreditCartInputDTO) async {
    Response response = await updateCreditCartWithHttpInfo(updateCreditCartInputDTO);
    if(response.statusCode >= 400) {
      throw ApiException(response.statusCode, _decodeBodyBytes(response));
    } else if(response.body != null) {
      return apiClient.deserialize(_decodeBodyBytes(response), 'String') as String;
    } else {
      return null;
    }
  }

  ///  with HTTP info returned
  ///
  /// 
  Future<Response> updateShoppingCartWithHttpInfo(UpdateShoppingCartInputDTO updateShoppingCartInputDTO) async {
    Object postBody = updateShoppingCartInputDTO;

    // verify required params are set
    if(updateShoppingCartInputDTO == null) {
     throw ApiException(400, "Missing required param: updateShoppingCartInputDTO");
    }

    // create path and map variables
    String path = "/api/user/updateShoppingCart".replaceAll("{format}","json");

    // query params
    List<QueryParam> queryParams = [];
    Map<String, String> headerParams = {};
    Map<String, String> formParams = {};

    List<String> contentTypes = ["application/json"];

    String contentType = contentTypes.isNotEmpty ? contentTypes[0] : "application/json";
    List<String> authNames = [];

    if(contentType.startsWith("multipart/form-data")) {
      bool hasFields = false;
      MultipartRequest mp = MultipartRequest(null, null);
      if(hasFields)
        postBody = mp;
    }
    else {
    }

    var response = await apiClient.invokeAPI(path,
                                             'POST',
                                             queryParams,
                                             postBody,
                                             headerParams,
                                             formParams,
                                             contentType,
                                             authNames);
    return response;
  }

  /// 
  ///
  /// 
  Future<String> updateShoppingCart(UpdateShoppingCartInputDTO updateShoppingCartInputDTO) async {
    Response response = await updateShoppingCartWithHttpInfo(updateShoppingCartInputDTO);
    if(response.statusCode >= 400) {
      throw ApiException(response.statusCode, _decodeBodyBytes(response));
    } else if(response.body != null) {
      return apiClient.deserialize(_decodeBodyBytes(response), 'String') as String;
    } else {
      return null;
    }
  }

  ///  with HTTP info returned
  ///
  /// 
  Future<Response> updateUserWithHttpInfo(UpdateUserInputDTO updateUserInputDTO) async {
    Object postBody = updateUserInputDTO;

    // verify required params are set
    if(updateUserInputDTO == null) {
     throw ApiException(400, "Missing required param: updateUserInputDTO");
    }

    // create path and map variables
    String path = "/api/user/update".replaceAll("{format}","json");

    // query params
    List<QueryParam> queryParams = [];
    Map<String, String> headerParams = {};
    Map<String, String> formParams = {};

    List<String> contentTypes = ["application/json"];

    String contentType = contentTypes.isNotEmpty ? contentTypes[0] : "application/json";
    List<String> authNames = [];

    if(contentType.startsWith("multipart/form-data")) {
      bool hasFields = false;
      MultipartRequest mp = MultipartRequest(null, null);
      if(hasFields)
        postBody = mp;
    }
    else {
    }

    var response = await apiClient.invokeAPI(path,
                                             'POST',
                                             queryParams,
                                             postBody,
                                             headerParams,
                                             formParams,
                                             contentType,
                                             authNames);
    return response;
  }

  /// 
  ///
  /// 
  Future<String> updateUser(UpdateUserInputDTO updateUserInputDTO) async {
    Response response = await updateUserWithHttpInfo(updateUserInputDTO);
    if(response.statusCode >= 400) {
      throw ApiException(response.statusCode, _decodeBodyBytes(response));
    } else if(response.body != null) {
      return apiClient.deserialize(_decodeBodyBytes(response), 'String') as String;
    } else {
      return null;
    }
  }

  ///  with HTTP info returned
  ///
  /// 
  Future<Response> updateUserPasswordWithHttpInfo(UpdatePasswordInputDTO updatePasswordInputDTO) async {
    Object postBody = updatePasswordInputDTO;

    // verify required params are set
    if(updatePasswordInputDTO == null) {
     throw ApiException(400, "Missing required param: updatePasswordInputDTO");
    }

    // create path and map variables
    String path = "/api/user/updatePassword".replaceAll("{format}","json");

    // query params
    List<QueryParam> queryParams = [];
    Map<String, String> headerParams = {};
    Map<String, String> formParams = {};

    List<String> contentTypes = ["application/json"];

    String contentType = contentTypes.isNotEmpty ? contentTypes[0] : "application/json";
    List<String> authNames = [];

    if(contentType.startsWith("multipart/form-data")) {
      bool hasFields = false;
      MultipartRequest mp = MultipartRequest(null, null);
      if(hasFields)
        postBody = mp;
    }
    else {
    }

    var response = await apiClient.invokeAPI(path,
                                             'POST',
                                             queryParams,
                                             postBody,
                                             headerParams,
                                             formParams,
                                             contentType,
                                             authNames);
    return response;
  }

  /// 
  ///
  /// 
  Future<String> updateUserPassword(UpdatePasswordInputDTO updatePasswordInputDTO) async {
    Response response = await updateUserPasswordWithHttpInfo(updatePasswordInputDTO);
    if(response.statusCode >= 400) {
      throw ApiException(response.statusCode, _decodeBodyBytes(response));
    } else if(response.body != null) {
      return apiClient.deserialize(_decodeBodyBytes(response), 'String') as String;
    } else {
      return null;
    }
  }

  ///  with HTTP info returned
  ///
  /// 
  Future<Response> uploadImageWithHttpInfo(String userId, { MultipartFile file }) async {
    Object postBody;

    // verify required params are set
    if(userId == null) {
     throw ApiException(400, "Missing required param: userId");
    }

    // create path and map variables
    String path = "/api/user/uploadImage".replaceAll("{format}","json");

    // query params
    List<QueryParam> queryParams = [];
    Map<String, String> headerParams = {};
    Map<String, String> formParams = {};
      queryParams.addAll(_convertParametersForCollectionFormat("", "userId", userId));

    List<String> contentTypes = ["multipart/form-data"];

    String contentType = contentTypes.isNotEmpty ? contentTypes[0] : "application/json";
    List<String> authNames = [];

    if(contentType.startsWith("multipart/form-data")) {
      bool hasFields = false;
      MultipartRequest mp = MultipartRequest(null, null);
      if (file != null) {
        hasFields = true;
        mp.fields['file'] = file.field;
        mp.files.add(file);
      }
      if(hasFields)
        postBody = mp;
    }
    else {
    }

    var response = await apiClient.invokeAPI(path,
                                             'POST',
                                             queryParams,
                                             postBody,
                                             headerParams,
                                             formParams,
                                             contentType,
                                             authNames);
    return response;
  }

  /// 
  ///
  /// 
  Future<String> uploadImage(String userId, { MultipartFile file }) async {
    Response response = await uploadImageWithHttpInfo(userId,  file: file );
    if(response.statusCode >= 400) {
      throw ApiException(response.statusCode, _decodeBodyBytes(response));
    } else if(response.body != null) {
      return apiClient.deserialize(_decodeBodyBytes(response), 'String') as String;
    } else {
      return null;
    }
  }

  ///  with HTTP info returned
  ///
  /// 
  Future<Response> useCouponCodeWithHttpInfo(String code) async {
    Object postBody;

    // verify required params are set
    if(code == null) {
     throw ApiException(400, "Missing required param: code");
    }

    // create path and map variables
    String path = "/api/user/useCouponCode".replaceAll("{format}","json");

    // query params
    List<QueryParam> queryParams = [];
    Map<String, String> headerParams = {};
    Map<String, String> formParams = {};
      queryParams.addAll(_convertParametersForCollectionFormat("", "code", code));

    List<String> contentTypes = [];

    String contentType = contentTypes.isNotEmpty ? contentTypes[0] : "application/json";
    List<String> authNames = [];

    if(contentType.startsWith("multipart/form-data")) {
      bool hasFields = false;
      MultipartRequest mp = MultipartRequest(null, null);
      if(hasFields)
        postBody = mp;
    }
    else {
    }

    var response = await apiClient.invokeAPI(path,
                                             'GET',
                                             queryParams,
                                             postBody,
                                             headerParams,
                                             formParams,
                                             contentType,
                                             authNames);
    return response;
  }

  /// 
  ///
  /// 
  Future<UseCouponCodeOutputDTO> useCouponCode(String code) async {
    Response response = await useCouponCodeWithHttpInfo(code);
    if(response.statusCode >= 400) {
      throw ApiException(response.statusCode, _decodeBodyBytes(response));
    } else if(response.body != null) {
      return apiClient.deserialize(_decodeBodyBytes(response), 'UseCouponCodeOutputDTO') as UseCouponCodeOutputDTO;
    } else {
      return null;
    }
  }

}
