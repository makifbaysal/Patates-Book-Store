part of openapi.api;

class CreditCartDetailsOutputDTO {
  
  String userId;
  
  String cartId;
  
  String owner;
  
  String cartNumber;
  
  String date;
  
  String cvc;
  CreditCartDetailsOutputDTO();

  @override
  String toString() {
    return 'CreditCartDetailsOutputDTO[userId=$userId, cartId=$cartId, owner=$owner, cartNumber=$cartNumber, date=$date, cvc=$cvc, ]';
  }

  CreditCartDetailsOutputDTO.fromJson(Map<String, dynamic> json) {
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

  static List<CreditCartDetailsOutputDTO> listFromJson(List<dynamic> json) {
    return json == null ? List<CreditCartDetailsOutputDTO>() : json.map((value) => CreditCartDetailsOutputDTO.fromJson(value)).toList();
  }

  static Map<String, CreditCartDetailsOutputDTO> mapFromJson(Map<String, dynamic> json) {
    var map = Map<String, CreditCartDetailsOutputDTO>();
    if (json != null && json.isNotEmpty) {
      json.forEach((String key, dynamic value) => map[key] = CreditCartDetailsOutputDTO.fromJson(value));
    }
    return map;
  }

  // maps a json object with a list of CreditCartDetailsOutputDTO-objects as value to a dart map
  static Map<String, List<CreditCartDetailsOutputDTO>> mapListFromJson(Map<String, dynamic> json) {
    var map = Map<String, List<CreditCartDetailsOutputDTO>>();
     if (json != null && json.isNotEmpty) {
       json.forEach((String key, dynamic value) {
         map[key] = CreditCartDetailsOutputDTO.listFromJson(value);
       });
     }
     return map;
  }
}

