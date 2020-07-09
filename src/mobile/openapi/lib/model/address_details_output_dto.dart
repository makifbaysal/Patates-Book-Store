part of openapi.api;

class AddressDetailsOutputDTO {
  
  String addressId;
  
  String header;
  
  String address;
  
  String city;
  
  String county;
  
  String zipcode;
  AddressDetailsOutputDTO();

  @override
  String toString() {
    return 'AddressDetailsOutputDTO[addressId=$addressId, header=$header, address=$address, city=$city, county=$county, zipcode=$zipcode, ]';
  }

  AddressDetailsOutputDTO.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    addressId = json['addressId'];
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

  static List<AddressDetailsOutputDTO> listFromJson(List<dynamic> json) {
    return json == null ? List<AddressDetailsOutputDTO>() : json.map((value) => AddressDetailsOutputDTO.fromJson(value)).toList();
  }

  static Map<String, AddressDetailsOutputDTO> mapFromJson(Map<String, dynamic> json) {
    var map = Map<String, AddressDetailsOutputDTO>();
    if (json != null && json.isNotEmpty) {
      json.forEach((String key, dynamic value) => map[key] = AddressDetailsOutputDTO.fromJson(value));
    }
    return map;
  }

  // maps a json object with a list of AddressDetailsOutputDTO-objects as value to a dart map
  static Map<String, List<AddressDetailsOutputDTO>> mapListFromJson(Map<String, dynamic> json) {
    var map = Map<String, List<AddressDetailsOutputDTO>>();
     if (json != null && json.isNotEmpty) {
       json.forEach((String key, dynamic value) {
         map[key] = AddressDetailsOutputDTO.listFromJson(value);
       });
     }
     return map;
  }
}

