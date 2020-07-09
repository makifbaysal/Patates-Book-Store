part of openapi.api;

class SeeMessageOutputDTO {
  
  String email;
  
  String subject;
  
  String message;
  SeeMessageOutputDTO();

  @override
  String toString() {
    return 'SeeMessageOutputDTO[email=$email, subject=$subject, message=$message, ]';
  }

  SeeMessageOutputDTO.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    email = json['email'];
    subject = json['subject'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    Map <String, dynamic> json = {};
    if (email != null)
      json['email'] = email;
    if (subject != null)
      json['subject'] = subject;
    if (message != null)
      json['message'] = message;
    return json;
  }

  static List<SeeMessageOutputDTO> listFromJson(List<dynamic> json) {
    return json == null ? List<SeeMessageOutputDTO>() : json.map((value) => SeeMessageOutputDTO.fromJson(value)).toList();
  }

  static Map<String, SeeMessageOutputDTO> mapFromJson(Map<String, dynamic> json) {
    var map = Map<String, SeeMessageOutputDTO>();
    if (json != null && json.isNotEmpty) {
      json.forEach((String key, dynamic value) => map[key] = SeeMessageOutputDTO.fromJson(value));
    }
    return map;
  }

  // maps a json object with a list of SeeMessageOutputDTO-objects as value to a dart map
  static Map<String, List<SeeMessageOutputDTO>> mapListFromJson(Map<String, dynamic> json) {
    var map = Map<String, List<SeeMessageOutputDTO>>();
     if (json != null && json.isNotEmpty) {
       json.forEach((String key, dynamic value) {
         map[key] = SeeMessageOutputDTO.listFromJson(value);
       });
     }
     return map;
  }
}

