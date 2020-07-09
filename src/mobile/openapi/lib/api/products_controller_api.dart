part of openapi.api;



class ProductsControllerApi {
  final ApiClient apiClient;

  ProductsControllerApi([ApiClient apiClient]) : apiClient = apiClient ?? defaultApiClient;

  ///  with HTTP info returned
  ///
  /// 
  Future<Response> addProductWithHttpInfo(String description, double price, List<String> category, String name, String author, String language, int stock, int page, { MultipartFile file }) async {
    Object postBody;

    // verify required params are set
    if(description == null) {
     throw ApiException(400, "Missing required param: description");
    }
    if(price == null) {
     throw ApiException(400, "Missing required param: price");
    }
    if(category == null) {
     throw ApiException(400, "Missing required param: category");
    }
    if(name == null) {
     throw ApiException(400, "Missing required param: name");
    }
    if(author == null) {
     throw ApiException(400, "Missing required param: author");
    }
    if(language == null) {
     throw ApiException(400, "Missing required param: language");
    }
    if(stock == null) {
     throw ApiException(400, "Missing required param: stock");
    }
    if(page == null) {
     throw ApiException(400, "Missing required param: page");
    }

    // create path and map variables
    String path = "/api/product/addProduct".replaceAll("{format}","json");

    // query params
    List<QueryParam> queryParams = [];
    Map<String, String> headerParams = {};
    Map<String, String> formParams = {};
      queryParams.addAll(_convertParametersForCollectionFormat("", "description", description));
      queryParams.addAll(_convertParametersForCollectionFormat("", "price", price));
      queryParams.addAll(_convertParametersForCollectionFormat("multi", "category", category));
      queryParams.addAll(_convertParametersForCollectionFormat("", "name", name));
      queryParams.addAll(_convertParametersForCollectionFormat("", "author", author));
      queryParams.addAll(_convertParametersForCollectionFormat("", "language", language));
      queryParams.addAll(_convertParametersForCollectionFormat("", "stock", stock));
      queryParams.addAll(_convertParametersForCollectionFormat("", "page", page));

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
  Future<String> addProduct(String description, double price, List<String> category, String name, String author, String language, int stock, int page, { MultipartFile file }) async {
    Response response = await addProductWithHttpInfo(description, price, category, name, author, language, stock, page,  file: file );
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
  Future<Response> categoriesCountWithHttpInfo() async {
    Object postBody;

    // verify required params are set

    // create path and map variables
    String path = "/api/product/categoriesCount".replaceAll("{format}","json");

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
  Future<Map<String, int>> categoriesCount() async {
    Response response = await categoriesCountWithHttpInfo();
    if(response.statusCode >= 400) {
      throw ApiException(response.statusCode, _decodeBodyBytes(response));
    } else if(response.body != null) {
      return Map<String, int>.from(apiClient.deserialize(_decodeBodyBytes(response), 'Map<String, int>'));
    } else {
      return null;
    }
  }

  ///  with HTTP info returned
  ///
  /// 
  Future<Response> deleteProductWithHttpInfo(DeleteProductInputDTO deleteProductInputDTO) async {
    Object postBody = deleteProductInputDTO;

    // verify required params are set
    if(deleteProductInputDTO == null) {
     throw ApiException(400, "Missing required param: deleteProductInputDTO");
    }

    // create path and map variables
    String path = "/api/product/deleteProduct".replaceAll("{format}","json");

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
  Future<String> deleteProduct(DeleteProductInputDTO deleteProductInputDTO) async {
    Response response = await deleteProductWithHttpInfo(deleteProductInputDTO);
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
  Future<Response> getBestSellerTenWithHttpInfo() async {
    Object postBody;

    // verify required params are set

    // create path and map variables
    String path = "/api/product/getBestSellerTen".replaceAll("{format}","json");

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
  Future<List<ProductListingOutputDTO>> getBestSellerTen() async {
    Response response = await getBestSellerTenWithHttpInfo();
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
  Future<Response> getProductCommentsWithHttpInfo(String productId) async {
    Object postBody;

    // verify required params are set
    if(productId == null) {
     throw ApiException(400, "Missing required param: productId");
    }

    // create path and map variables
    String path = "/api/product/getProductComments".replaceAll("{format}","json");

    // query params
    List<QueryParam> queryParams = [];
    Map<String, String> headerParams = {};
    Map<String, String> formParams = {};
      queryParams.addAll(_convertParametersForCollectionFormat("", "productId", productId));

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
  Future<List<CommentOutputDTO>> getProductComments(String productId) async {
    Response response = await getProductCommentsWithHttpInfo(productId);
    if(response.statusCode >= 400) {
      throw ApiException(response.statusCode, _decodeBodyBytes(response));
    } else if(response.body != null) {
      return (apiClient.deserialize(_decodeBodyBytes(response), 'List<CommentOutputDTO>') as List).map((item) => item as CommentOutputDTO).toList();
    } else {
      return null;
    }
  }

  ///  with HTTP info returned
  ///
  /// 
  Future<Response> getProductsWithHttpInfo({ int from, int size, int highestPage, int lowestPage, List<String> category, List<String> languages, int lowestPrice, int highestPrice, String sort, String search }) async {
    Object postBody;

    // verify required params are set

    // create path and map variables
    String path = "/api/product/viewProducts".replaceAll("{format}","json");

    // query params
    List<QueryParam> queryParams = [];
    Map<String, String> headerParams = {};
    Map<String, String> formParams = {};
    if(from != null) {
      queryParams.addAll(_convertParametersForCollectionFormat("", "from", from));
    }
    if(size != null) {
      queryParams.addAll(_convertParametersForCollectionFormat("", "size", size));
    }
    if(highestPage != null) {
      queryParams.addAll(_convertParametersForCollectionFormat("", "highestPage", highestPage));
    }
    if(lowestPage != null) {
      queryParams.addAll(_convertParametersForCollectionFormat("", "lowestPage", lowestPage));
    }
    if(category != null) {
      queryParams.addAll(_convertParametersForCollectionFormat("multi", "category", category));
    }
    if(languages != null) {
      queryParams.addAll(_convertParametersForCollectionFormat("multi", "languages", languages));
    }
    if(lowestPrice != null) {
      queryParams.addAll(_convertParametersForCollectionFormat("", "lowestPrice", lowestPrice));
    }
    if(highestPrice != null) {
      queryParams.addAll(_convertParametersForCollectionFormat("", "highestPrice", highestPrice));
    }
    if(sort != null) {
      queryParams.addAll(_convertParametersForCollectionFormat("", "sort", sort));
    }
    if(search != null) {
      queryParams.addAll(_convertParametersForCollectionFormat("", "search", search));
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
  Future<ProductListingReturnOutputDTO> getProducts({ int from, int size, int highestPage, int lowestPage, List<String> category, List<String> languages, int lowestPrice, int highestPrice, String sort, String search }) async {
    Response response = await getProductsWithHttpInfo( from: from, size: size, highestPage: highestPage, lowestPage: lowestPage, category: category, languages: languages, lowestPrice: lowestPrice, highestPrice: highestPrice, sort: sort, search: search );
    if(response.statusCode >= 400) {
      throw ApiException(response.statusCode, _decodeBodyBytes(response));
    } else if(response.body != null) {
      return apiClient.deserialize(_decodeBodyBytes(response), 'ProductListingReturnOutputDTO') as ProductListingReturnOutputDTO;
    } else {
      return null;
    }
  }

  ///  with HTTP info returned
  ///
  /// 
  Future<Response> getRelationalProductsWithHttpInfo(String productId) async {
    Object postBody;

    // verify required params are set
    if(productId == null) {
     throw ApiException(400, "Missing required param: productId");
    }

    // create path and map variables
    String path = "/api/product/getRelationalProducts".replaceAll("{format}","json");

    // query params
    List<QueryParam> queryParams = [];
    Map<String, String> headerParams = {};
    Map<String, String> formParams = {};
      queryParams.addAll(_convertParametersForCollectionFormat("", "productId", productId));

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
  Future<List<ProductListingOutputDTO>> getRelationalProducts(String productId) async {
    Response response = await getRelationalProductsWithHttpInfo(productId);
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
  Future<Response> getWeeklyDealsTenWithHttpInfo() async {
    Object postBody;

    // verify required params are set

    // create path and map variables
    String path = "/api/product/getWeeklyDealsTen".replaceAll("{format}","json");

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
  Future<List<ProductListingOutputDTO>> getWeeklyDealsTen() async {
    Response response = await getWeeklyDealsTenWithHttpInfo();
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
  Future<Response> productDetailsWithHttpInfo({ String productId, String userId }) async {
    Object postBody;

    // verify required params are set

    // create path and map variables
    String path = "/api/product/productDetails".replaceAll("{format}","json");

    // query params
    List<QueryParam> queryParams = [];
    Map<String, String> headerParams = {};
    Map<String, String> formParams = {};
    if(productId != null) {
      queryParams.addAll(_convertParametersForCollectionFormat("", "productId", productId));
    }
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
  Future<ProductDetailOutputDTO> productDetails({ String productId, String userId }) async {
    Response response = await productDetailsWithHttpInfo( productId: productId, userId: userId );
    if(response.statusCode >= 400) {
      throw ApiException(response.statusCode, _decodeBodyBytes(response));
    } else if(response.body != null) {
      return apiClient.deserialize(_decodeBodyBytes(response), 'ProductDetailOutputDTO') as ProductDetailOutputDTO;
    } else {
      return null;
    }
  }

  ///  with HTTP info returned
  ///
  /// 
  Future<Response> updateProductWithHttpInfo(UpdateProductInputDTO updateProductInputDTO) async {
    Object postBody = updateProductInputDTO;

    // verify required params are set
    if(updateProductInputDTO == null) {
     throw ApiException(400, "Missing required param: updateProductInputDTO");
    }

    // create path and map variables
    String path = "/api/product/updateProduct".replaceAll("{format}","json");

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
  Future<String> updateProduct(UpdateProductInputDTO updateProductInputDTO) async {
    Response response = await updateProductWithHttpInfo(updateProductInputDTO);
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
  Future<Response> updateProductImageWithHttpInfo(String productId, { MultipartFile file }) async {
    Object postBody;

    // verify required params are set
    if(productId == null) {
     throw ApiException(400, "Missing required param: productId");
    }

    // create path and map variables
    String path = "/api/product/updateProductImage".replaceAll("{format}","json");

    // query params
    List<QueryParam> queryParams = [];
    Map<String, String> headerParams = {};
    Map<String, String> formParams = {};
      queryParams.addAll(_convertParametersForCollectionFormat("", "productId", productId));

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
  Future<String> updateProductImage(String productId, { MultipartFile file }) async {
    Response response = await updateProductImageWithHttpInfo(productId,  file: file );
    if(response.statusCode >= 400) {
      throw ApiException(response.statusCode, _decodeBodyBytes(response));
    } else if(response.body != null) {
      return apiClient.deserialize(_decodeBodyBytes(response), 'String') as String;
    } else {
      return null;
    }
  }

}
