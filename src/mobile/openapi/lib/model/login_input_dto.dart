part of openapi.api;

class LoginInputDTO {
  
  String email;
  
  String password;
  LoginInputDTO();

  @override
  String toString() {
    return 'LoginInputDTO[email=$email, password=$password, ]';
  }

  LoginInputDTO.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    email = json['email'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    Map <String, dynamic> json = {};
    if (email != null)
      json['email'] = email;
    if (password != null)
      json['password'] = password;
    return json;
  }

  static List<LoginInputDTO> listFromJson(List<dynamic> json) {
    return json == null ? List<LoginInputDTO>() : json.map((value) => LoginInputDTO.fromJson(value)).toList();
  }

  static Map<String, LoginInputDTO> mapFromJson(Map<String, dynamic> json) {
    var map = Map<String, LoginInputDTO>();
    if (json != null && json.isNotEmpty) {
      json.forEach((String key, dynamic value) => map[key] = LoginInputDTO.fromJson(value));
    }
    return map;
  }

  // maps a json object with a list of LoginInputDTO-objects as value to a dart map
  static Map<String, List<LoginInputDTO>> mapListFromJson(Map<String, dynamic> json) {
    var map = Map<String, List<LoginInputDTO>>();
     if (json != null && json.isNotEmpty) {
       json.forEach((String key, dynamic value) {
         map[key] = LoginInputDTO.listFromJson(value);
       });
     }
     return map;
  }
}

