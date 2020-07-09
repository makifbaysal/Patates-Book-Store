part of openapi.api;

class CreateUserOutputDTO {
  
  String name;
  
  String idToken;
  
  String status;
  CreateUserOutputDTO();

  @override
  String toString() {
    return 'CreateUserOutputDTO[name=$name, idToken=$idToken, status=$status, ]';
  }

  CreateUserOutputDTO.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    name = json['name'];
    idToken = json['idToken'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    Map <String, dynamic> json = {};
    if (name != null)
      json['name'] = name;
    if (idToken != null)
      json['idToken'] = idToken;
    if (status != null)
      json['status'] = status;
    return json;
  }

  static List<CreateUserOutputDTO> listFromJson(List<dynamic> json) {
    return json == null ? List<CreateUserOutputDTO>() : json.map((value) => CreateUserOutputDTO.fromJson(value)).toList();
  }

  static Map<String, CreateUserOutputDTO> mapFromJson(Map<String, dynamic> json) {
    var map = Map<String, CreateUserOutputDTO>();
    if (json != null && json.isNotEmpty) {
      json.forEach((String key, dynamic value) => map[key] = CreateUserOutputDTO.fromJson(value));
    }
    return map;
  }

  // maps a json object with a list of CreateUserOutputDTO-objects as value to a dart map
  static Map<String, List<CreateUserOutputDTO>> mapListFromJson(Map<String, dynamic> json) {
    var map = Map<String, List<CreateUserOutputDTO>>();
     if (json != null && json.isNotEmpty) {
       json.forEach((String key, dynamic value) {
         map[key] = CreateUserOutputDTO.listFromJson(value);
       });
     }
     return map;
  }
}

