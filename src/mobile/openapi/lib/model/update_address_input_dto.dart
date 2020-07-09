part of openapi.api;

class UpdateAddressInputDTO {
  
  String addressId;
  
  String userId;
  
  String header;
  
  String address;
  
  String city;
  
  String county;
  
  String zipcode;
  UpdateAddressInputDTO();

  @override
  String toString() {
    return 'UpdateAddressInputDTO[addressId=$addressId, userId=$userId, header=$header, address=$address, city=$city, county=$county, zipcode=$zipcode, ]';
  }

  UpdateAddressInputDTO.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    addressId = json['addressId'];
    userId = json['userId'];
    header = json['header'];
    address = json['address'];
    city = json['city'];
    county = json['county'];
    zipcode = json['zipcode'];
  }

  Map<String, dynamic> toJson() {
    Map <String, dynamic> json = {};
    if (addressId != null)
      json['addressId'] = addressId;
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

  static List<UpdateAddressInputDTO> listFromJson(List<dynamic> json) {
    return json == null ? List<UpdateAddressInputDTO>() : json.map((value) => UpdateAddressInputDTO.fromJson(value)).toList();
  }

  static Map<String, UpdateAddressInputDTO> mapFromJson(Map<String, dynamic> json) {
    var map = Map<String, UpdateAddressInputDTO>();
    if (json != null && json.isNotEmpty) {
      json.forEach((String key, dynamic value) => map[key] = UpdateAddressInputDTO.fromJson(value));
    }
    return map;
  }

  // maps a json object with a list of UpdateAddressInputDTO-objects as value to a dart map
  static Map<String, List<UpdateAddressInputDTO>> mapListFromJson(Map<String, dynamic> json) {
    var map = Map<String, List<UpdateAddressInputDTO>>();
     if (json != null && json.isNotEmpty) {
       json.forEach((String key, dynamic value) {
         map[key] = UpdateAddressInputDTO.listFromJson(value);
       });
     }
     return map;
  }
}

