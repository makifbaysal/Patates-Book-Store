part of openapi.api;

class LoginOutputDTO {
  
  String idToken;
  
  String status;
  
  String name;
  
  bool admin;
  LoginOutputDTO();

  @override
  String toString() {
    return 'LoginOutputDTO[idToken=$idToken, status=$status, name=$name, admin=$admin, ]';
  }

  LoginOutputDTO.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    idToken = json['idToken'];
    status = json['status'];
    name = json['name'];
    admin = json['admin'];
  }

  Map<String, dynamic> toJson() {
    Map <String, dynamic> json = {};
    if (idToken != null)
      json['idToken'] = idToken;
    if (status != null)
      json['status'] = status;
    if (name != null)
      json['name'] = name;
    if (admin != null)
      json['admin'] = admin;
    return json;
  }

  static List<LoginOutputDTO> listFromJson(List<dynamic> json) {
    return json == null ? List<LoginOutputDTO>() : json.map((value) => LoginOutputDTO.fromJson(value)).toList();
  }

  static Map<String, LoginOutputDTO> mapFromJson(Map<String, dynamic> json) {
    var map = Map<String, LoginOutputDTO>();
    if (json != null && json.isNotEmpty) {
      json.forEach((String key, dynamic value) => map[key] = LoginOutputDTO.fromJson(value));
    }
    return map;
  }

  // maps a json object with a list of LoginOutputDTO-objects as value to a dart map
  static Map<String, List<LoginOutputDTO>> mapListFromJson(Map<String, dynamic> json) {
    var map = Map<String, List<LoginOutputDTO>>();
     if (json != null && json.isNotEmpty) {
       json.forEach((String key, dynamic value) {
         map[key] = LoginOutputDTO.listFromJson(value);
       });
     }
     return map;
  }
}

