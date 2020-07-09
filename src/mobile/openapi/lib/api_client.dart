part of openapi.api;

class QueryParam {
  String name;
  String value;

  QueryParam(this.name, this.value);
}

class ApiClient {

  String basePath;
  var client = Client();

  Map<String, String> _defaultHeaderMap = {};
  Map<String, Authentication> _authentications = {};

  final _regList = RegExp(r'^List<(.*)>$');
  final _regMap = RegExp(r'^Map<String,(.*)>$');

  ApiClient({this.basePath = "https://api.link"}) {
    // Setup authentications (key: authentication name, value: authentication).
  }

  void addDefaultHeader(String key, String value) {
     _defaultHeaderMap[key] = value;
  }

  dynamic _deserialize(dynamic value, String targetType) {
    try {
      switch (targetType) {
        case 'String':
          return '$value';
        case 'int':
          return value is int ? value : int.parse('$value');
        case 'bool':
          return value is bool ? value : '$value'.toLowerCase() == 'true';
        case 'double':
          return value is double ? value : double.parse('$value');
        case 'AcceptOrderInputDTO':
          return AcceptOrderInputDTO.fromJson(value);
        case 'AddAdressInputDTO':
          return AddAdressInputDTO.fromJson(value);
        case 'AddBookmarkInputDTO':
          return AddBookmarkInputDTO.fromJson(value);
        case 'AddCreditCartInputDTO':
          return AddCreditCartInputDTO.fromJson(value);
        case 'AddToShoppingCartInputDTO':
          return AddToShoppingCartInputDTO.fromJson(value);
        case 'AddressDetailsOutputDTO':
          return AddressDetailsOutputDTO.fromJson(value);
        case 'AdminGetUserDetailsOutputDTO':
          return AdminGetUserDetailsOutputDTO.fromJson(value);
        case 'AdminReportOutputDTO':
          return AdminReportOutputDTO.fromJson(value);
        case 'CancelOrderInputDTO':
          return CancelOrderInputDTO.fromJson(value);
        case 'CommentDetailsInputDTO':
          return CommentDetailsInputDTO.fromJson(value);
        case 'CommentDetailsOutputDTO':
          return CommentDetailsOutputDTO.fromJson(value);
        case 'CommentOutputDTO':
          return CommentOutputDTO.fromJson(value);
        case 'CouponCodeDetailsDTO':
          return CouponCodeDetailsDTO.fromJson(value);
        case 'CreateCouponInputDTO':
          return CreateCouponInputDTO.fromJson(value);
        case 'CreateOrderInputDTO':
          return CreateOrderInputDTO.fromJson(value);
        case 'CreateUserInputDTO':
          return CreateUserInputDTO.fromJson(value);
        case 'CreateUserOutputDTO':
          return CreateUserOutputDTO.fromJson(value);
        case 'CreditCartDetailsOutputDTO':
          return CreditCartDetailsOutputDTO.fromJson(value);
        case 'DeleteAddressInputDTO':
          return DeleteAddressInputDTO.fromJson(value);
        case 'DeleteBookmarkInputDTO':
          return DeleteBookmarkInputDTO.fromJson(value);
        case 'DeleteCommentInputDTO':
          return DeleteCommentInputDTO.fromJson(value);
        case 'DeleteCreditCartInputDTO':
          return DeleteCreditCartInputDTO.fromJson(value);
        case 'DeleteProductInputDTO':
          return DeleteProductInputDTO.fromJson(value);
        case 'DeleteProductShoppingCartInputDTO':
          return DeleteProductShoppingCartInputDTO.fromJson(value);
        case 'DeleteShippingCompanyInputDTO':
          return DeleteShippingCompanyInputDTO.fromJson(value);
        case 'DeleteUserInputDTO':
          return DeleteUserInputDTO.fromJson(value);
        case 'GetOrdersOutputDTO':
          return GetOrdersOutputDTO.fromJson(value);
        case 'ListAddressOutputDTO':
          return ListAddressOutputDTO.fromJson(value);
        case 'ListCreditCartsOutputDTO':
          return ListCreditCartsOutputDTO.fromJson(value);
        case 'ListingCouponsOutputDTO':
          return ListingCouponsOutputDTO.fromJson(value);
        case 'ListingShippingCompaniesOutputDTO':
          return ListingShippingCompaniesOutputDTO.fromJson(value);
        case 'LoginInputDTO':
          return LoginInputDTO.fromJson(value);
        case 'LoginOutputDTO':
          return LoginOutputDTO.fromJson(value);
        case 'MakeCommentInputDTO':
          return MakeCommentInputDTO.fromJson(value);
        case 'OrderDetailsOutputDTO':
          return OrderDetailsOutputDTO.fromJson(value);
        case 'OrderProductListingOutputDTO':
          return OrderProductListingOutputDTO.fromJson(value);
        case 'PasswordResetInputDTO':
          return PasswordResetInputDTO.fromJson(value);
        case 'ProductDetailOutputDTO':
          return ProductDetailOutputDTO.fromJson(value);
        case 'ProductListingOutputDTO':
          return ProductListingOutputDTO.fromJson(value);
        case 'ProductListingReturnOutputDTO':
          return ProductListingReturnOutputDTO.fromJson(value);
        case 'RefundOrderAdminInputDTO':
          return RefundOrderAdminInputDTO.fromJson(value);
        case 'RefundOrderInputDTO':
          return RefundOrderInputDTO.fromJson(value);
        case 'RejectOrderInputDTO':
          return RejectOrderInputDTO.fromJson(value);
        case 'SeeMessageOutputDTO':
          return SeeMessageOutputDTO.fromJson(value);
        case 'SendMessageInputDTO':
          return SendMessageInputDTO.fromJson(value);
        case 'ShippingCompanyDetailsOutputDTO':
          return ShippingCompanyDetailsOutputDTO.fromJson(value);
        case 'ShoppingCartProductListingOutputDTO':
          return ShoppingCartProductListingOutputDTO.fromJson(value);
        case 'UpdateAddressInputDTO':
          return UpdateAddressInputDTO.fromJson(value);
        case 'UpdateCommentInputDTO':
          return UpdateCommentInputDTO.fromJson(value);
        case 'UpdateCouponInputDTO':
          return UpdateCouponInputDTO.fromJson(value);
        case 'UpdateCreditCartInputDTO':
          return UpdateCreditCartInputDTO.fromJson(value);
        case 'UpdatePasswordInputDTO':
          return UpdatePasswordInputDTO.fromJson(value);
        case 'UpdateProductInputDTO':
          return UpdateProductInputDTO.fromJson(value);
        case 'UpdateShippingCompanyInputDTO':
          return UpdateShippingCompanyInputDTO.fromJson(value);
        case 'UpdateShoppingCartInputDTO':
          return UpdateShoppingCartInputDTO.fromJson(value);
        case 'UpdateUserInputDTO':
          return UpdateUserInputDTO.fromJson(value);
        case 'UseCouponCodeOutputDTO':
          return UseCouponCodeOutputDTO.fromJson(value);
        case 'UserCommentOutputDTO':
          return UserCommentOutputDTO.fromJson(value);
        case 'UserDetailsOutputDTO':
          return UserDetailsOutputDTO.fromJson(value);
        default:
          {
            Match match;
            if (value is List &&
                (match = _regList.firstMatch(targetType)) != null) {
              var newTargetType = match[1];
              return value.map((v) => _deserialize(v, newTargetType)).toList();
            } else if (value is Map &&
                (match = _regMap.firstMatch(targetType)) != null) {
              var newTargetType = match[1];
              return Map.fromIterables(value.keys,
                  value.values.map((v) => _deserialize(v, newTargetType)));
            }
          }
      }
    } on Exception catch (e, stack) {
      throw ApiException.withInner(500, 'Exception during deserialization.', e, stack);
    }
    throw ApiException(500, 'Could not find a suitable class for deserialization');
  }

  dynamic deserialize(String json, String targetType) {
    // Remove all spaces.  Necessary for reg expressions as well.
    targetType = targetType.replaceAll(' ', '');

    if (targetType == 'String') return json;

    var decodedJson = jsonDecode(json);
    return _deserialize(decodedJson, targetType);
  }

  String serialize(Object obj) {
    String serialized = '';
    if (obj == null) {
      serialized = '';
    } else {
      serialized = json.encode(obj);
    }
    return serialized;
  }

  // We don't use a Map<String, String> for queryParams.
  // If collectionFormat is 'multi' a key might appear multiple times.
  Future<Response> invokeAPI(String path,
                             String method,
                             Iterable<QueryParam> queryParams,
                             Object body,
                             Map<String, String> headerParams,
                             Map<String, String> formParams,
                             String contentType,
                             List<String> authNames) async {

    _updateParamsForAuth(authNames, queryParams, headerParams);

    var ps = queryParams
      .where((p) => p.value != null)
      .map((p) => '${p.name}=${Uri.encodeQueryComponent(p.value)}');

    String queryString = ps.isNotEmpty ?
                         '?' + ps.join('&') :
                         '';

    String url = basePath + path + queryString;

    headerParams.addAll(_defaultHeaderMap);
    headerParams['Content-Type'] = contentType;

    if(body is MultipartRequest) {
      var request = MultipartRequest(method, Uri.parse(url));
      request.fields.addAll(body.fields);
      request.files.addAll(body.files);
      request.headers.addAll(body.headers);
      request.headers.addAll(headerParams);
      var response = await client.send(request);
      return Response.fromStream(response);
    } else {
      var msgBody = contentType == "application/x-www-form-urlencoded" ? formParams : serialize(body);
      switch(method) {
        case "POST":
          return client.post(url, headers: headerParams, body: msgBody);
        case "PUT":
          return client.put(url, headers: headerParams, body: msgBody);
        case "DELETE":
          return client.delete(url, headers: headerParams);
        case "PATCH":
          return client.patch(url, headers: headerParams, body: msgBody);
        case "HEAD":
          return client.head(url, headers: headerParams);
        default:
          return client.get(url, headers: headerParams);
      }
    }
  }

  /// Update query and header parameters based on authentication settings.
  /// @param authNames The authentications to apply
  void _updateParamsForAuth(List<String> authNames, List<QueryParam> queryParams, Map<String, String> headerParams) {
    authNames.forEach((authName) {
      Authentication auth = _authentications[authName];
      if (auth == null) throw ArgumentError("Authentication undefined: " + authName);
      auth.applyToParams(queryParams, headerParams);
    });
  }

  T getAuthentication<T extends Authentication>(String name) {
    var authentication = _authentications[name];

    return authentication is T ? authentication : null;
  }
}
