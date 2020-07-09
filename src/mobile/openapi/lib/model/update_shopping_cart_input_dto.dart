part of openapi.api;

class UpdateShoppingCartInputDTO {
  
  String userId;
  
  String productId;
  
  int value;
  UpdateShoppingCartInputDTO();

  @override
  String toString() {
    return 'UpdateShoppingCartInputDTO[userId=$userId, productId=$productId, value=$value, ]';
  }

  UpdateShoppingCartInputDTO.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    userId = json['userId'];
    productId = json['productId'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    Map <String, dynamic> json = {};
    if (userId != null)
      json['userId'] = userId;
    if (productId != null)
      json['productId'] = productId;
    if (value != null)
      json['value'] = value;
    return json;
  }

  static List<UpdateShoppingCartInputDTO> listFromJson(List<dynamic> json) {
    return json == null ? List<UpdateShoppingCartInputDTO>() : json.map((value) => UpdateShoppingCartInputDTO.fromJson(value)).toList();
  }

  static Map<String, UpdateShoppingCartInputDTO> mapFromJson(Map<String, dynamic> json) {
    var map = Map<String, UpdateShoppingCartInputDTO>();
    if (json != null && json.isNotEmpty) {
      json.forEach((String key, dynamic value) => map[key] = UpdateShoppingCartInputDTO.fromJson(value));
    }
    return map;
  }

  // maps a json object with a list of UpdateShoppingCartInputDTO-objects as value to a dart map
  static Map<String, List<UpdateShoppingCartInputDTO>> mapListFromJson(Map<String, dynamic> json) {
    var map = Map<String, List<UpdateShoppingCartInputDTO>>();
     if (json != null && json.isNotEmpty) {
       json.forEach((String key, dynamic value) {
         map[key] = UpdateShoppingCartInputDTO.listFromJson(value);
       });
     }
     return map;
  }
}

