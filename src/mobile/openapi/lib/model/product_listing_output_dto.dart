part of openapi.api;

class ProductListingOutputDTO {
  
  String id;
  
  String imageUrl;
  
  String name;
  
  String author;
  
  double price;
  ProductListingOutputDTO();

  @override
  String toString() {
    return 'ProductListingOutputDTO[id=$id, imageUrl=$imageUrl, name=$name, author=$author, price=$price, ]';
  }

  ProductListingOutputDTO.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    id = json['id'];
    imageUrl = json['imageUrl'];
    name = json['name'];
    author = json['author'];
    price = (json['price'] == null) ?
      null :
      json['price'].toDouble();
  }

  Map<String, dynamic> toJson() {
    Map <String, dynamic> json = {};
    if (id != null)
      json['id'] = id;
    if (imageUrl != null)
      json['imageUrl'] = imageUrl;
    if (name != null)
      json['name'] = name;
    if (author != null)
      json['author'] = author;
    if (price != null)
      json['price'] = price;
    return json;
  }

  static List<ProductListingOutputDTO> listFromJson(List<dynamic> json) {
    return json == null ? List<ProductListingOutputDTO>() : json.map((value) => ProductListingOutputDTO.fromJson(value)).toList();
  }

  static Map<String, ProductListingOutputDTO> mapFromJson(Map<String, dynamic> json) {
    var map = Map<String, ProductListingOutputDTO>();
    if (json != null && json.isNotEmpty) {
      json.forEach((String key, dynamic value) => map[key] = ProductListingOutputDTO.fromJson(value));
    }
    return map;
  }

  // maps a json object with a list of ProductListingOutputDTO-objects as value to a dart map
  static Map<String, List<ProductListingOutputDTO>> mapListFromJson(Map<String, dynamic> json) {
    var map = Map<String, List<ProductListingOutputDTO>>();
     if (json != null && json.isNotEmpty) {
       json.forEach((String key, dynamic value) {
         map[key] = ProductListingOutputDTO.listFromJson(value);
       });
     }
     return map;
  }
}

