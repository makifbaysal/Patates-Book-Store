part of openapi.api;

class ListCreditCartsOutputDTO {
  
  String cartId;
  
  String cartNumber;
  
  String owner;
  
  String date;
  ListCreditCartsOutputDTO();

  @override
  String toString() {
    return 'ListCreditCartsOutputDTO[cartId=$cartId, cartNumber=$cartNumber, owner=$owner, date=$date, ]';
  }

  ListCreditCartsOutputDTO.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    cartId = json['cartId'];
    cartNumber = json['cartNumber'];
    owner = json['owner'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    Map <String, dynamic> json = {};
    if (cartId != null)
      json['cartId'] = cartId;
    if (cartNumber != null)
      json['cartNumber'] = cartNumber;
    if (owner != null)
      json['owner'] = owner;
    if (date != null)
      json['date'] = date;
    return json;
  }

  static List<ListCreditCartsOutputDTO> listFromJson(List<dynamic> json) {
    return json == null ? List<ListCreditCartsOutputDTO>() : json.map((value) => ListCreditCartsOutputDTO.fromJson(value)).toList();
  }

  static Map<String, ListCreditCartsOutputDTO> mapFromJson(Map<String, dynamic> json) {
    var map = Map<String, ListCreditCartsOutputDTO>();
    if (json != null && json.isNotEmpty) {
      json.forEach((String key, dynamic value) => map[key] = ListCreditCartsOutputDTO.fromJson(value));
    }
    return map;
  }

  // maps a json object with a list of ListCreditCartsOutputDTO-objects as value to a dart map
  static Map<String, List<ListCreditCartsOutputDTO>> mapListFromJson(Map<String, dynamic> json) {
    var map = Map<String, List<ListCreditCartsOutputDTO>>();
     if (json != null && json.isNotEmpty) {
       json.forEach((String key, dynamic value) {
         map[key] = ListCreditCartsOutputDTO.listFromJson(value);
       });
     }
     return map;
  }
}

