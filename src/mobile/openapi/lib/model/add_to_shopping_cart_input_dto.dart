part of openapi.api;

class AddToShoppingCartInputDTO {
  
  String productId;
  
  String userId;
  
  int quantity;
  AddToShoppingCartInputDTO();

  @override
  String toString() {
    return 'AddToShoppingCartInputDTO[productId=$productId, userId=$userId, quantity=$quantity, ]';
  }

  AddToShoppingCartInputDTO.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    productId = json['productId'];
    userId = json['userId'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    Map <String, dynamic> json = {};
    if (productId != null)
      json['productId'] = productId;
    if (userId != null)
      json['userId'] = userId;
    if (quantity != null)
      json['quantity'] = quantity;
    return json;
  }

  static List<AddToShoppingCartInputDTO> listFromJson(List<dynamic> json) {
    return json == null ? List<AddToShoppingCartInputDTO>() : json.map((value) => AddToShoppingCartInputDTO.fromJson(value)).toList();
  }

  static Map<String, AddToShoppingCartInputDTO> mapFromJson(Map<String, dynamic> json) {
    var map = Map<String, AddToShoppingCartInputDTO>();
    if (json != null && json.isNotEmpty) {
      json.forEach((String key, dynamic value) => map[key] = AddToShoppingCartInputDTO.fromJson(value));
    }
    return map;
  }

  // maps a json object with a list of AddToShoppingCartInputDTO-objects as value to a dart map
  static Map<String, List<AddToShoppingCartInputDTO>> mapListFromJson(Map<String, dynamic> json) {
    var map = Map<String, List<AddToShoppingCartInputDTO>>();
     if (json != null && json.isNotEmpty) {
       json.forEach((String key, dynamic value) {
         map[key] = AddToShoppingCartInputDTO.listFromJson(value);
       });
     }
     return map;
  }
}

