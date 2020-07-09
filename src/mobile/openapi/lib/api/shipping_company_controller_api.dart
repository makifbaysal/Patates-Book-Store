part of openapi.api;



class ShippingCompanyControllerApi {
  final ApiClient apiClient;

  ShippingCompanyControllerApi([ApiClient apiClient]) : apiClient = apiClient ?? defaultApiClient;

  ///  with HTTP info returned
  ///
  /// 
  Future<Response> addShippingCompanyWithHttpInfo(String website, double price, String name, DateTime date, String contactNumber, { MultipartFile file }) async {
    Object postBody;

    // verify required params are set
    if(website == null) {
     throw ApiException(400, "Missing required param: website");
    }
    if(price == null) {
     throw ApiException(400, "Missing required param: price");
    }
    if(name == null) {
     throw ApiException(400, "Missing required param: name");
    }
    if(date == null) {
     throw ApiException(400, "Missing required param: date");
    }
    if(contactNumber == null) {
     throw ApiException(400, "Missing required param: contactNumber");
    }

    // create path and map variables
    String path = "/api/shippingCompany/addShippingCompany".replaceAll("{format}","json");

    // query params
    List<QueryParam> queryParams = [];
    Map<String, String> headerParams = {};
    Map<String, String> formParams = {};
      queryParams.addAll(_convertParametersForCollectionFormat("", "website", website));
      queryParams.addAll(_convertParametersForCollectionFormat("", "price", price));
      queryParams.addAll(_convertParametersForCollectionFormat("", "name", name));
      queryParams.addAll(_convertParametersForCollectionFormat("", "date", date));
      queryParams.addAll(_convertParametersForCollectionFormat("", "contactNumber", contactNumber));

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
  Future<String> addShippingCompany(String website, double price, String name, DateTime date, String contactNumber, { MultipartFile file }) async {
    Response response = await addShippingCompanyWithHttpInfo(website, price, name, date, contactNumber,  file: file );
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
  Future<Response> deleteShippingCompanyWithHttpInfo(DeleteShippingCompanyInputDTO deleteShippingCompanyInputDTO) async {
    Object postBody = deleteShippingCompanyInputDTO;

    // verify required params are set
    if(deleteShippingCompanyInputDTO == null) {
     throw ApiException(400, "Missing required param: deleteShippingCompanyInputDTO");
    }

    // create path and map variables
    String path = "/api/shippingCompany/deleteShippingCompany".replaceAll("{format}","json");

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
  Future<String> deleteShippingCompany(DeleteShippingCompanyInputDTO deleteShippingCompanyInputDTO) async {
    Response response = await deleteShippingCompanyWithHttpInfo(deleteShippingCompanyInputDTO);
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
  Future<Response> getShippingCompaniesWithHttpInfo({ String search }) async {
    Object postBody;

    // verify required params are set

    // create path and map variables
    String path = "/api/shippingCompany/getShippingCompanies".replaceAll("{format}","json");

    // query params
    List<QueryParam> queryParams = [];
    Map<String, String> headerParams = {};
    Map<String, String> formParams = {};
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
  Future<List<ListingShippingCompaniesOutputDTO>> getShippingCompanies({ String search }) async {
    Response response = await getShippingCompaniesWithHttpInfo( search: search );
    if(response.statusCode >= 400) {
      throw ApiException(response.statusCode, _decodeBodyBytes(response));
    } else if(response.body != null) {
      return (apiClient.deserialize(_decodeBodyBytes(response), 'List<ListingShippingCompaniesOutputDTO>') as List).map((item) => item as ListingShippingCompaniesOutputDTO).toList();
    } else {
      return null;
    }
  }

  ///  with HTTP info returned
  ///
  /// 
  Future<Response> getShippingCompanyDetailsWithHttpInfo({ String companyId }) async {
    Object postBody;

    // verify required params are set

    // create path and map variables
    String path = "/api/shippingCompany/getShippingCompanyDetails".replaceAll("{format}","json");

    // query params
    List<QueryParam> queryParams = [];
    Map<String, String> headerParams = {};
    Map<String, String> formParams = {};
    if(companyId != null) {
      queryParams.addAll(_convertParametersForCollectionFormat("", "companyId", companyId));
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
  Future<ShippingCompanyDetailsOutputDTO> getShippingCompanyDetails({ String companyId }) async {
    Response response = await getShippingCompanyDetailsWithHttpInfo( companyId: companyId );
    if(response.statusCode >= 400) {
      throw ApiException(response.statusCode, _decodeBodyBytes(response));
    } else if(response.body != null) {
      return apiClient.deserialize(_decodeBodyBytes(response), 'ShippingCompanyDetailsOutputDTO') as ShippingCompanyDetailsOutputDTO;
    } else {
      return null;
    }
  }

  ///  with HTTP info returned
  ///
  /// 
  Future<Response> updatePhotoShippingCompanyWithHttpInfo(String companyId, { MultipartFile file }) async {
    Object postBody;

    // verify required params are set
    if(companyId == null) {
     throw ApiException(400, "Missing required param: companyId");
    }

    // create path and map variables
    String path = "/api/shippingCompany/updatePhotoShippingCompany".replaceAll("{format}","json");

    // query params
    List<QueryParam> queryParams = [];
    Map<String, String> headerParams = {};
    Map<String, String> formParams = {};
      queryParams.addAll(_convertParametersForCollectionFormat("", "companyId", companyId));

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
  Future<String> updatePhotoShippingCompany(String companyId, { MultipartFile file }) async {
    Response response = await updatePhotoShippingCompanyWithHttpInfo(companyId,  file: file );
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
  Future<Response> updateShippingCompanyWithHttpInfo(UpdateShippingCompanyInputDTO updateShippingCompanyInputDTO) async {
    Object postBody = updateShippingCompanyInputDTO;

    // verify required params are set
    if(updateShippingCompanyInputDTO == null) {
     throw ApiException(400, "Missing required param: updateShippingCompanyInputDTO");
    }

    // create path and map variables
    String path = "/api/shippingCompany/updateShippingCompany".replaceAll("{format}","json");

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
  Future<String> updateShippingCompany(UpdateShippingCompanyInputDTO updateShippingCompanyInputDTO) async {
    Response response = await updateShippingCompanyWithHttpInfo(updateShippingCompanyInputDTO);
    if(response.statusCode >= 400) {
      throw ApiException(response.statusCode, _decodeBodyBytes(response));
    } else if(response.body != null) {
      return apiClient.deserialize(_decodeBodyBytes(response), 'String') as String;
    } else {
      return null;
    }
  }

}
