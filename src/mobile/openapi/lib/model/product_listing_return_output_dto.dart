part of openapi.api;

class ProductListingReturnOutputDTO {
  
  List<ProductListingOutputDTO> products = [];
  
  int productCount;
  ProductListingReturnOutputDTO();

  @override
  String toString() {
    return 'ProductListingReturnOutputDTO[products=$products, productCount=$productCount, ]';
  }

  ProductListingReturnOutputDTO.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    products = (json['products'] == null) ?
      null :
      ProductListingOutputDTO.listFromJson(json['products']);
    productCount = json['productCount'];
  }

  Map<String, dynamic> toJson() {
    Map <String, dynamic> json = {};
    if (products != null)
      json['products'] = products;
    if (productCount != null)
      json['productCount'] = productCount;
    return json;
  }

  static List<ProductListingReturnOutputDTO> listFromJson(List<dynamic> json) {
    return json == null ? List<ProductListingReturnOutputDTO>() : json.map((value) => ProductListingReturnOutputDTO.fromJson(value)).toList();
  }

  static Map<String, ProductListingReturnOutputDTO> mapFromJson(Map<String, dynamic> json) {
    var map = Map<String, ProductListingReturnOutputDTO>();
    if (json != null && json.isNotEmpty) {
      json.forEach((String key, dynamic value) => map[key] = ProductListingReturnOutputDTO.fromJson(value));
    }
    return map;
  }

  // maps a json object with a list of ProductListingReturnOutputDTO-objects as value to a dart map
  static Map<String, List<ProductListingReturnOutputDTO>> mapListFromJson(Map<String, dynamic> json) {
    var map = Map<String, List<ProductListingReturnOutputDTO>>();
     if (json != null && json.isNotEmpty) {
       json.forEach((String key, dynamic value) {
         map[key] = ProductListingReturnOutputDTO.listFromJson(value);
       });
     }
     return map;
  }
}

