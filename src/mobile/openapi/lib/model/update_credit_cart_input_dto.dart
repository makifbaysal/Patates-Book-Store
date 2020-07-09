part of openapi.api;

class UpdateCreditCartInputDTO {
  
  String userId;
  
  String cartId;
  
  String owner;
  
  String cartNumber;
  
  String date;
  
  String cvc;
  UpdateCreditCartInputDTO();

  @override
  String toString() {
    return 'UpdateCreditCartInputDTO[userId=$userId, cartId=$cartId, owner=$owner, cartNumber=$cartNumber, date=$date, cvc=$cvc, ]';
  }

  UpdateCreditCartInputDTO.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    userId = json['userId'];
    cartId = json['cartId'];
    owner = json['owner'];
    cartNumber = json['cartNumber'];
    date = json['date'];
    cvc = json['cvc'];
  }

  Map<String, dynamic> toJson() {
    Map <String, dynamic> json = {};
    if (userId != null)
      json['userId'] = userId;
    if (cartId != null)
      json['cartId'] = cartId;
    if (owner != null)
      json['owner'] = owner;
    if (cartNumber != null)
      json['cartNumber'] = cartNumber;
    if (date != null)
      json['date'] = date;
    if (cvc != null)
      json['cvc'] = cvc;
    return json;
  }

  static List<UpdateCreditCartInputDTO> listFromJson(List<dynamic> json) {
    return json == null ? List<UpdateCreditCartInputDTO>() : json.map((value) => UpdateCreditCartInputDTO.fromJson(value)).toList();
  }

  static Map<String, UpdateCreditCartInputDTO> mapFromJson(Map<String, dynamic> json) {
    var map = Map<String, UpdateCreditCartInputDTO>();
    if (json != null && json.isNotEmpty) {
      json.forEach((String key, dynamic value) => map[key] = UpdateCreditCartInputDTO.fromJson(value));
    }
    return map;
  }

  // maps a json object with a list of UpdateCreditCartInputDTO-objects as value to a dart map
  static Map<String, List<UpdateCreditCartInputDTO>> mapListFromJson(Map<String, dynamic> json) {
    var map = Map<String, List<UpdateCreditCartInputDTO>>();
     if (json != null && json.isNotEmpty) {
       json.forEach((String key, dynamic value) {
         map[key] = UpdateCreditCartInputDTO.listFromJson(value);
       });
     }
     return map;
  }
}

