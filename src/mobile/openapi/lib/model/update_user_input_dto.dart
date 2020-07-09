part of openapi.api;

class UpdateUserInputDTO {
  
  String idToken;
  
  String email;
  
  String name;
  
  String phone;
  UpdateUserInputDTO();

  @override
  String toString() {
    return 'UpdateUserInputDTO[idToken=$idToken, email=$email, name=$name, phone=$phone, ]';
  }

  UpdateUserInputDTO.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    idToken = json['idToken'];
    email = json['email'];
    name = json['name'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    Map <String, dynamic> json = {};
    if (idToken != null)
      json['idToken'] = idToken;
    if (email != null)
      json['email'] = email;
    if (name != null)
      json['name'] = name;
    if (phone != null)
      json['phone'] = phone;
    return json;
  }

  static List<UpdateUserInputDTO> listFromJson(List<dynamic> json) {
    return json == null ? List<UpdateUserInputDTO>() : json.map((value) => UpdateUserInputDTO.fromJson(value)).toList();
  }

  static Map<String, UpdateUserInputDTO> mapFromJson(Map<String, dynamic> json) {
    var map = Map<String, UpdateUserInputDTO>();
    if (json != null && json.isNotEmpty) {
      json.forEach((String key, dynamic value) => map[key] = UpdateUserInputDTO.fromJson(value));
    }
    return map;
  }

  // maps a json object with a list of UpdateUserInputDTO-objects as value to a dart map
  static Map<String, List<UpdateUserInputDTO>> mapListFromJson(Map<String, dynamic> json) {
    var map = Map<String, List<UpdateUserInputDTO>>();
     if (json != null && json.isNotEmpty) {
       json.forEach((String key, dynamic value) {
         map[key] = UpdateUserInputDTO.listFromJson(value);
       });
     }
     return map;
  }
}

