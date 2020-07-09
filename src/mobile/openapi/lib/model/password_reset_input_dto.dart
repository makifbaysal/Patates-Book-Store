part of openapi.api;

class PasswordResetInputDTO {
  
  String email;
  PasswordResetInputDTO();

  @override
  String toString() {
    return 'PasswordResetInputDTO[email=$email, ]';
  }

  PasswordResetInputDTO.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    Map <String, dynamic> json = {};
    if (email != null)
      json['email'] = email;
    return json;
  }

  static List<PasswordResetInputDTO> listFromJson(List<dynamic> json) {
    return json == null ? List<PasswordResetInputDTO>() : json.map((value) => PasswordResetInputDTO.fromJson(value)).toList();
  }

  static Map<String, PasswordResetInputDTO> mapFromJson(Map<String, dynamic> json) {
    var map = Map<String, PasswordResetInputDTO>();
    if (json != null && json.isNotEmpty) {
      json.forEach((String key, dynamic value) => map[key] = PasswordResetInputDTO.fromJson(value));
    }
    return map;
  }

  // maps a json object with a list of PasswordResetInputDTO-objects as value to a dart map
  static Map<String, List<PasswordResetInputDTO>> mapListFromJson(Map<String, dynamic> json) {
    var map = Map<String, List<PasswordResetInputDTO>>();
     if (json != null && json.isNotEmpty) {
       json.forEach((String key, dynamic value) {
         map[key] = PasswordResetInputDTO.listFromJson(value);
       });
     }
     return map;
  }
}

