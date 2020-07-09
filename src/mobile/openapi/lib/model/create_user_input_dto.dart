part of openapi.api;

class CreateUserInputDTO {
  
  String name;
  
  String email;
  
  String password;
  CreateUserInputDTO();

  @override
  String toString() {
    return 'CreateUserInputDTO[name=$name, email=$email, password=$password, ]';
  }

  CreateUserInputDTO.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    name = json['name'];
    email = json['email'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    Map <String, dynamic> json = {};
    if (name != null)
      json['name'] = name;
    if (email != null)
      json['email'] = email;
    if (password != null)
      json['password'] = password;
    return json;
  }

  static List<CreateUserInputDTO> listFromJson(List<dynamic> json) {
    return json == null ? List<CreateUserInputDTO>() : json.map((value) => CreateUserInputDTO.fromJson(value)).toList();
  }

  static Map<String, CreateUserInputDTO> mapFromJson(Map<String, dynamic> json) {
    var map = Map<String, CreateUserInputDTO>();
    if (json != null && json.isNotEmpty) {
      json.forEach((String key, dynamic value) => map[key] = CreateUserInputDTO.fromJson(value));
    }
    return map;
  }

  // maps a json object with a list of CreateUserInputDTO-objects as value to a dart map
  static Map<String, List<CreateUserInputDTO>> mapListFromJson(Map<String, dynamic> json) {
    var map = Map<String, List<CreateUserInputDTO>>();
     if (json != null && json.isNotEmpty) {
       json.forEach((String key, dynamic value) {
         map[key] = CreateUserInputDTO.listFromJson(value);
       });
     }
     return map;
  }
}

