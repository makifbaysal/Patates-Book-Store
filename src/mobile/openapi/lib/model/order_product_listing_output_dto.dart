part of openapi.api;

class OrderProductListingOutputDTO {
  
  String productId;
  
  String imageUrl;
  
  String name;
  
  String author;
  
  int quantity;
  
  double unitPrice;
  OrderProductListingOutputDTO();

  @override
  String toString() {
    return 'OrderProductListingOutputDTO[productId=$productId, imageUrl=$imageUrl, name=$name, author=$author, quantity=$quantity, unitPrice=$unitPrice, ]';
  }

  OrderProductListingOutputDTO.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    productId = json['productId'];
    imageUrl = json['imageUrl'];
    name = json['name'];
    author = json['author'];
    quantity = json['quantity'];
    unitPrice = (json['unitPrice'] == null) ?
      null :
      json['unitPrice'].toDouble();
  }

  Map<String, dynamic> toJson() {
    Map <String, dynamic> json = {};
    if (productId != null)
      json['productId'] = productId;
    if (imageUrl != null)
      json['imageUrl'] = imageUrl;
    if (name != null)
      json['name'] = name;
    if (author != null)
      json['author'] = author;
    if (quantity != null)
      json['quantity'] = quantity;
    if (unitPrice != null)
      json['unitPrice'] = unitPrice;
    return json;
  }

  static List<OrderProductListingOutputDTO> listFromJson(List<dynamic> json) {
    return json == null ? List<OrderProductListingOutputDTO>() : json.map((value) => OrderProductListingOutputDTO.fromJson(value)).toList();
  }

  static Map<String, OrderProductListingOutputDTO> mapFromJson(Map<String, dynamic> json) {
    var map = Map<String, OrderProductListingOutputDTO>();
    if (json != null && json.isNotEmpty) {
      json.forEach((String key, dynamic value) => map[key] = OrderProductListingOutputDTO.fromJson(value));
    }
    return map;
  }

  // maps a json object with a list of OrderProductListingOutputDTO-objects as value to a dart map
  static Map<String, List<OrderProductListingOutputDTO>> mapListFromJson(Map<String, dynamic> json) {
    var map = Map<String, List<OrderProductListingOutputDTO>>();
     if (json != null && json.isNotEmpty) {
       json.forEach((String key, dynamic value) {
         map[key] = OrderProductListingOutputDTO.listFromJson(value);
       });
     }
     return map;
  }
}

