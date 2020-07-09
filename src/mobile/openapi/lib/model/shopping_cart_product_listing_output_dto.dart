part of openapi.api;

class ShoppingCartProductListingOutputDTO {
  
  String id;
  
  String imageUrl;
  
  String name;
  
  String author;
  
  double price;
  
  int quantity;
  ShoppingCartProductListingOutputDTO();

  @override
  String toString() {
    return 'ShoppingCartProductListingOutputDTO[id=$id, imageUrl=$imageUrl, name=$name, author=$author, price=$price, quantity=$quantity, ]';
  }

  ShoppingCartProductListingOutputDTO.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    id = json['id'];
    imageUrl = json['imageUrl'];
    name = json['name'];
    author = json['author'];
    price = (json['price'] == null) ?
      null :
      json['price'].toDouble();
    quantity = json['quantity'];
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
    if (quantity != null)
      json['quantity'] = quantity;
    return json;
  }

  static List<ShoppingCartProductListingOutputDTO> listFromJson(List<dynamic> json) {
    return json == null ? List<ShoppingCartProductListingOutputDTO>() : json.map((value) => ShoppingCartProductListingOutputDTO.fromJson(value)).toList();
  }

  static Map<String, ShoppingCartProductListingOutputDTO> mapFromJson(Map<String, dynamic> json) {
    var map = Map<String, ShoppingCartProductListingOutputDTO>();
    if (json != null && json.isNotEmpty) {
      json.forEach((String key, dynamic value) => map[key] = ShoppingCartProductListingOutputDTO.fromJson(value));
    }
    return map;
  }

  // maps a json object with a list of ShoppingCartProductListingOutputDTO-objects as value to a dart map
  static Map<String, List<ShoppingCartProductListingOutputDTO>> mapListFromJson(Map<String, dynamic> json) {
    var map = Map<String, List<ShoppingCartProductListingOutputDTO>>();
     if (json != null && json.isNotEmpty) {
       json.forEach((String key, dynamic value) {
         map[key] = ShoppingCartProductListingOutputDTO.listFromJson(value);
       });
     }
     return map;
  }
}

