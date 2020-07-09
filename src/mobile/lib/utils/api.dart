import 'package:openapi/api.dart';

class ApiClientConfig {
  ApiClient get defaultConfig {
    defaultApiClient.basePath = "https://api.link";
    return defaultApiClient;
  }
}

class OpenAPI {
  final apiClientConfig = ApiClientConfig();

  ProductsControllerApi get products => ProductsControllerApi(apiClientConfig.defaultConfig);

  ShippingCompanyControllerApi get shippingCompany => ShippingCompanyControllerApi(apiClientConfig.defaultConfig);

  UsersControllerApi get users => UsersControllerApi(apiClientConfig.defaultConfig);

  AdminControllerApi get admin => AdminControllerApi(apiClientConfig.defaultConfig);

  OrderControllerApi get order => OrderControllerApi(apiClientConfig.defaultConfig);
}

OpenAPI api = new OpenAPI();
