part of openapi.api;

class AddAdressInputDTO {
  
  String userId;
  
  String header;
  
  String address;
  
  String city;
  
  String county;
  
  String zipcode;
  AddAdressInputDTO();

  @override
  String toString() {
    return 'AddAdressInputDTO[userId=$userId, header=$header, address=$address, city=$city, county=$county, zipcode=$zipcode, ]';
  }

  AddAdressInputDTO.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    userId = json['userId'];
    header = json['header'];
    address = json['address'];
    city = json['city'];
    county = json['county'];
    zipcode = json['zipcode'];
  }

  Map<String, dynamic> toJson() {
    Map <String, dynamic> json = {};
    if (userId != null)
      json['userId'] = userId;
    if (header != null)
      json['header'] = header;
    if (address != null)
      json['address'] = address;
    if (city != null)
      json['city'] = city;
    if (county != null)
      json['county'] = county;
    if (zipcode != null)
      json['zipcode'] = zipcode;
    return json;
  }

  static List<AddAdressInputDTO> listFromJson(List<dynamic> json) {
    return json == null ? List<AddAdressInputDTO>() : json.map((value) => AddAdressInputDTO.fromJson(value)).toList();
  }

  static Map<String, AddAdressInputDTO> mapFromJson(Map<String, dynamic> json) {
    var map = Map<String, AddAdressInputDTO>();
    if (json != null && json.isNotEmpty) {
      json.forEach((String key, dynamic value) => map[key] = AddAdressInputDTO.fromJson(value));
    }
    return map;
  }

  // maps a json object with a list of AddAdressInputDTO-objects as value to a dart map
  static Map<String, List<AddAdressInputDTO>> mapListFromJson(Map<String, dynamic> json) {
    var map = Map<String, List<AddAdressInputDTO>>();
     if (json != null && json.isNotEmpty) {
       json.forEach((String key, dynamic value) {
         map[key] = AddAdressInputDTO.listFromJson(value);
       });
     }
     return map;
  }
}

