part of openapi.api;

class UpdatePasswordInputDTO {
  
  String idToken;
  
  String password;
  
  String oldPassword;
  UpdatePasswordInputDTO();

  @override
  String toString() {
    return 'UpdatePasswordInputDTO[idToken=$idToken, password=$password, oldPassword=$oldPassword, ]';
  }

  UpdatePasswordInputDTO.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    idToken = json['idToken'];
    password = json['password'];
    oldPassword = json['oldPassword'];
  }

  Map<String, dynamic> toJson() {
    Map <String, dynamic> json = {};
    if (idToken != null)
      json['idToken'] = idToken;
    if (password != null)
      json['password'] = password;
    if (oldPassword != null)
      json['oldPassword'] = oldPassword;
    return json;
  }

  static List<UpdatePasswordInputDTO> listFromJson(List<dynamic> json) {
    return json == null ? List<UpdatePasswordInputDTO>() : json.map((value) => UpdatePasswordInputDTO.fromJson(value)).toList();
  }

  static Map<String, UpdatePasswordInputDTO> mapFromJson(Map<String, dynamic> json) {
    var map = Map<String, UpdatePasswordInputDTO>();
    if (json != null && json.isNotEmpty) {
      json.forEach((String key, dynamic value) => map[key] = UpdatePasswordInputDTO.fromJson(value));
    }
    return map;
  }

  // maps a json object with a list of UpdatePasswordInputDTO-objects as value to a dart map
  static Map<String, List<UpdatePasswordInputDTO>> mapListFromJson(Map<String, dynamic> json) {
    var map = Map<String, List<UpdatePasswordInputDTO>>();
     if (json != null && json.isNotEmpty) {
       json.forEach((String key, dynamic value) {
         map[key] = UpdatePasswordInputDTO.listFromJson(value);
       });
     }
     return map;
  }
}

