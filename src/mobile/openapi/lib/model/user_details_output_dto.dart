part of openapi.api;

class UserDetailsOutputDTO {
  
  String id;
  
  String name;
  
  String email;
  
  String imageUrl;
  
  String phone;
  UserDetailsOutputDTO();

  @override
  String toString() {
    return 'UserDetailsOutputDTO[id=$id, name=$name, email=$email, imageUrl=$imageUrl, phone=$phone, ]';
  }

  UserDetailsOutputDTO.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    id = json['id'];
    name = json['name'];
    email = json['email'];
    imageUrl = json['imageUrl'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    Map <String, dynamic> json = {};
    if (id != null)
      json['id'] = id;
    if (name != null)
      json['name'] = name;
    if (email != null)
      json['email'] = email;
    if (imageUrl != null)
      json['imageUrl'] = imageUrl;
    if (phone != null)
      json['phone'] = phone;
    return json;
  }

  static List<UserDetailsOutputDTO> listFromJson(List<dynamic> json) {
    return json == null ? List<UserDetailsOutputDTO>() : json.map((value) => UserDetailsOutputDTO.fromJson(value)).toList();
  }

  static Map<String, UserDetailsOutputDTO> mapFromJson(Map<String, dynamic> json) {
    var map = Map<String, UserDetailsOutputDTO>();
    if (json != null && json.isNotEmpty) {
      json.forEach((String key, dynamic value) => map[key] = UserDetailsOutputDTO.fromJson(value));
    }
    return map;
  }

  // maps a json object with a list of UserDetailsOutputDTO-objects as value to a dart map
  static Map<String, List<UserDetailsOutputDTO>> mapListFromJson(Map<String, dynamic> json) {
    var map = Map<String, List<UserDetailsOutputDTO>>();
     if (json != null && json.isNotEmpty) {
       json.forEach((String key, dynamic value) {
         map[key] = UserDetailsOutputDTO.listFromJson(value);
       });
     }
     return map;
  }
}

