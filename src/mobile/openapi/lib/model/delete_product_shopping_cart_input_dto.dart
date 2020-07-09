part of openapi.api;

class DeleteProductShoppingCartInputDTO {
  
  String userId;
  
  String productId;
  DeleteProductShoppingCartInputDTO();

  @override
  String toString() {
    return 'DeleteProductShoppingCartInputDTO[userId=$userId, productId=$productId, ]';
  }

  DeleteProductShoppingCartInputDTO.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    userId = json['userId'];
    productId = json['productId'];
  }

  Map<String, dynamic> toJson() {
    Map <String, dynamic> json = {};
    if (userId != null)
      json['userId'] = userId;
    if (productId != null)
      json['productId'] = productId;
    return json;
  }

  static List<DeleteProductShoppingCartInputDTO> listFromJson(List<dynamic> json) {
    return json == null ? List<DeleteProductShoppingCartInputDTO>() : json.map((value) => DeleteProductShoppingCartInputDTO.fromJson(value)).toList();
  }

  static Map<String, DeleteProductShoppingCartInputDTO> mapFromJson(Map<String, dynamic> json) {
    var map = Map<String, DeleteProductShoppingCartInputDTO>();
    if (json != null && json.isNotEmpty) {
      json.forEach((String key, dynamic value) => map[key] = DeleteProductShoppingCartInputDTO.fromJson(value));
    }
    return map;
  }

  // maps a json object with a list of DeleteProductShoppingCartInputDTO-objects as value to a dart map
  static Map<String, List<DeleteProductShoppingCartInputDTO>> mapListFromJson(Map<String, dynamic> json) {
    var map = Map<String, List<DeleteProductShoppingCartInputDTO>>();
     if (json != null && json.isNotEmpty) {
       json.forEach((String key, dynamic value) {
         map[key] = DeleteProductShoppingCartInputDTO.listFromJson(value);
       });
     }
     return map;
  }
}

