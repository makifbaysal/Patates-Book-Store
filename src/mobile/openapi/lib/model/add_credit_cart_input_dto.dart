part of openapi.api;

class AddCreditCartInputDTO {
  
  String userId;
  
  String owner;
  
  String cartNumber;
  
  String date;
  
  String cvc;
  AddCreditCartInputDTO();

  @override
  String toString() {
    return 'AddCreditCartInputDTO[userId=$userId, owner=$owner, cartNumber=$cartNumber, date=$date, cvc=$cvc, ]';
  }

  AddCreditCartInputDTO.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    userId = json['userId'];
    owner = json['owner'];
    cartNumber = json['cartNumber'];
    date = json['date'];
    cvc = json['cvc'];
  }

  Map<String, dynamic> toJson() {
    Map <String, dynamic> json = {};
    if (userId != null)
      json['userId'] = userId;
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

  static List<AddCreditCartInputDTO> listFromJson(List<dynamic> json) {
    return json == null ? List<AddCreditCartInputDTO>() : json.map((value) => AddCreditCartInputDTO.fromJson(value)).toList();
  }

  static Map<String, AddCreditCartInputDTO> mapFromJson(Map<String, dynamic> json) {
    var map = Map<String, AddCreditCartInputDTO>();
    if (json != null && json.isNotEmpty) {
      json.forEach((String key, dynamic value) => map[key] = AddCreditCartInputDTO.fromJson(value));
    }
    return map;
  }

  // maps a json object with a list of AddCreditCartInputDTO-objects as value to a dart map
  static Map<String, List<AddCreditCartInputDTO>> mapListFromJson(Map<String, dynamic> json) {
    var map = Map<String, List<AddCreditCartInputDTO>>();
     if (json != null && json.isNotEmpty) {
       json.forEach((String key, dynamic value) {
         map[key] = AddCreditCartInputDTO.listFromJson(value);
       });
     }
     return map;
  }
}

