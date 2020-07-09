part of openapi.api;

class AdminGetUserDetailsOutputDTO {
  
  String id;
  
  String name;
  
  String email;
  
  String imageUrl;
  
  String phone;
  
  List<GetOrdersOutputDTO> orders = [];
  
  double totalAmount;
  AdminGetUserDetailsOutputDTO();

  @override
  String toString() {
    return 'AdminGetUserDetailsOutputDTO[id=$id, name=$name, email=$email, imageUrl=$imageUrl, phone=$phone, orders=$orders, totalAmount=$totalAmount, ]';
  }

  AdminGetUserDetailsOutputDTO.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    id = json['id'];
    name = json['name'];
    email = json['email'];
    imageUrl = json['imageUrl'];
    phone = json['phone'];
    orders = (json['orders'] == null) ?
      null :
      GetOrdersOutputDTO.listFromJson(json['orders']);
    totalAmount = (json['totalAmount'] == null) ?
      null :
      json['totalAmount'].toDouble();
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
    if (orders != null)
      json['orders'] = orders;
    if (totalAmount != null)
      json['totalAmount'] = totalAmount;
    return json;
  }

  static List<AdminGetUserDetailsOutputDTO> listFromJson(List<dynamic> json) {
    return json == null ? List<AdminGetUserDetailsOutputDTO>() : json.map((value) => AdminGetUserDetailsOutputDTO.fromJson(value)).toList();
  }

  static Map<String, AdminGetUserDetailsOutputDTO> mapFromJson(Map<String, dynamic> json) {
    var map = Map<String, AdminGetUserDetailsOutputDTO>();
    if (json != null && json.isNotEmpty) {
      json.forEach((String key, dynamic value) => map[key] = AdminGetUserDetailsOutputDTO.fromJson(value));
    }
    return map;
  }

  // maps a json object with a list of AdminGetUserDetailsOutputDTO-objects as value to a dart map
  static Map<String, List<AdminGetUserDetailsOutputDTO>> mapListFromJson(Map<String, dynamic> json) {
    var map = Map<String, List<AdminGetUserDetailsOutputDTO>>();
     if (json != null && json.isNotEmpty) {
       json.forEach((String key, dynamic value) {
         map[key] = AdminGetUserDetailsOutputDTO.listFromJson(value);
       });
     }
     return map;
  }
}

