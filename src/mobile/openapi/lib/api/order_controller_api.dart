part of openapi.api;



class OrderControllerApi {
  final ApiClient apiClient;

  OrderControllerApi([ApiClient apiClient]) : apiClient = apiClient ?? defaultApiClient;

  ///  with HTTP info returned
  ///
  /// 
  Future<Response> acceptOrderWithHttpInfo(AcceptOrderInputDTO acceptOrderInputDTO) async {
    Object postBody = acceptOrderInputDTO;

    // verify required params are set
    if(acceptOrderInputDTO == null) {
     throw ApiException(400, "Missing required param: acceptOrderInputDTO");
    }

    // create path and map variables
    String path = "/api/order/acceptOrder".replaceAll("{format}","json");

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
  Future<String> acceptOrder(AcceptOrderInputDTO acceptOrderInputDTO) async {
    Response response = await acceptOrderWithHttpInfo(acceptOrderInputDTO);
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
  Future<Response> cancelOrderWithHttpInfo(CancelOrderInputDTO cancelOrderInputDTO) async {
    Object postBody = cancelOrderInputDTO;

    // verify required params are set
    if(cancelOrderInputDTO == null) {
     throw ApiException(400, "Missing required param: cancelOrderInputDTO");
    }

    // create path and map variables
    String path = "/api/order/cancelOrder".replaceAll("{format}","json");

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
  Future<String> cancelOrder(CancelOrderInputDTO cancelOrderInputDTO) async {
    Response response = await cancelOrderWithHttpInfo(cancelOrderInputDTO);
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
  Future<Response> createOrderWithHttpInfo(CreateOrderInputDTO createOrderInputDTO) async {
    Object postBody = createOrderInputDTO;

    // verify required params are set
    if(createOrderInputDTO == null) {
     throw ApiException(400, "Missing required param: createOrderInputDTO");
    }

    // create path and map variables
    String path = "/api/order/createOrder".replaceAll("{format}","json");

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
  Future<String> createOrder(CreateOrderInputDTO createOrderInputDTO) async {
    Response response = await createOrderWithHttpInfo(createOrderInputDTO);
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
  Future<Response> getOrdersWithHttpInfo({ String state, String userId }) async {
    Object postBody;

    // verify required params are set

    // create path and map variables
    String path = "/api/order/getOrders".replaceAll("{format}","json");

    // query params
    List<QueryParam> queryParams = [];
    Map<String, String> headerParams = {};
    Map<String, String> formParams = {};
    if(state != null) {
      queryParams.addAll(_convertParametersForCollectionFormat("", "state", state));
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
  Future<List<GetOrdersOutputDTO>> getOrders({ String state, String userId }) async {
    Response response = await getOrdersWithHttpInfo( state: state, userId: userId );
    if(response.statusCode >= 400) {
      throw ApiException(response.statusCode, _decodeBodyBytes(response));
    } else if(response.body != null) {
      return (apiClient.deserialize(_decodeBodyBytes(response), 'List<GetOrdersOutputDTO>') as List).map((item) => item as GetOrdersOutputDTO).toList();
    } else {
      return null;
    }
  }

  ///  with HTTP info returned
  ///
  /// 
  Future<Response> orderDetailsWithHttpInfo({ String orderId }) async {
    Object postBody;

    // verify required params are set

    // create path and map variables
    String path = "/api/order/orderDetails".replaceAll("{format}","json");

    // query params
    List<QueryParam> queryParams = [];
    Map<String, String> headerParams = {};
    Map<String, String> formParams = {};
    if(orderId != null) {
      queryParams.addAll(_convertParametersForCollectionFormat("", "orderId", orderId));
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
  Future<OrderDetailsOutputDTO> orderDetails({ String orderId }) async {
    Response response = await orderDetailsWithHttpInfo( orderId: orderId );
    if(response.statusCode >= 400) {
      throw ApiException(response.statusCode, _decodeBodyBytes(response));
    } else if(response.body != null) {
      return apiClient.deserialize(_decodeBodyBytes(response), 'OrderDetailsOutputDTO') as OrderDetailsOutputDTO;
    } else {
      return null;
    }
  }

  ///  with HTTP info returned
  ///
  /// 
  Future<Response> refundOrderRequestWithHttpInfo(RefundOrderInputDTO refundOrderInputDTO) async {
    Object postBody = refundOrderInputDTO;

    // verify required params are set
    if(refundOrderInputDTO == null) {
     throw ApiException(400, "Missing required param: refundOrderInputDTO");
    }

    // create path and map variables
    String path = "/api/order/refundOrder".replaceAll("{format}","json");

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
  Future<String> refundOrderRequest(RefundOrderInputDTO refundOrderInputDTO) async {
    Response response = await refundOrderRequestWithHttpInfo(refundOrderInputDTO);
    if(response.statusCode >= 400) {
      throw ApiException(response.statusCode, _decodeBodyBytes(response));
    } else if(response.body != null) {
      return apiClient.deserialize(_decodeBodyBytes(response), 'String') as String;
    } else {
      return null;
    }
  }

}
