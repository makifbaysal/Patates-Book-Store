part of openapi.api;

class DeleteCreditCartInputDTO {
  
  String userId;
  
  String cartId;
  DeleteCreditCartInputDTO();

  @override
  String toString() {
    return 'DeleteCreditCartInputDTO[userId=$userId, cartId=$cartId, ]';
  }

  DeleteCreditCartInputDTO.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    userId = json['userId'];
    cartId = json['cartId'];
  }

  Map<String, dynamic> toJson() {
    Map <String, dynamic> json = {};
    if (userId != null)
      json['userId'] = userId;
    if (cartId != null)
      json['cartId'] = cartId;
    return json;
  }

  static List<DeleteCreditCartInputDTO> listFromJson(List<dynamic> json) {
    return json == null ? List<DeleteCreditCartInputDTO>() : json.map((value) => DeleteCreditCartInputDTO.fromJson(value)).toList();
  }

  static Map<String, DeleteCreditCartInputDTO> mapFromJson(Map<String, dynamic> json) {
    var map = Map<String, DeleteCreditCartInputDTO>();
    if (json != null && json.isNotEmpty) {
      json.forEach((String key, dynamic value) => map[key] = DeleteCreditCartInputDTO.fromJson(value));
    }
    return map;
  }

  // maps a json object with a list of DeleteCreditCartInputDTO-objects as value to a dart map
  static Map<String, List<DeleteCreditCartInputDTO>> mapListFromJson(Map<String, dynamic> json) {
    var map = Map<String, List<DeleteCreditCartInputDTO>>();
     if (json != null && json.isNotEmpty) {
       json.forEach((String key, dynamic value) {
         map[key] = DeleteCreditCartInputDTO.listFromJson(value);
       });
     }
     return map;
  }
}

