part of openapi.api;

class ListAddressOutputDTO {
  
  String addressId;
  
  String header;
  
  String address;
  
  String city;
  
  String county;
  ListAddressOutputDTO();

  @override
  String toString() {
    return 'ListAddressOutputDTO[addressId=$addressId, header=$header, address=$address, city=$city, county=$county, ]';
  }

  ListAddressOutputDTO.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    addressId = json['addressId'];
    header = json['header'];
    address = json['address'];
    city = json['city'];
    county = json['county'];
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
    return json;
  }

  static List<ListAddressOutputDTO> listFromJson(List<dynamic> json) {
    return json == null ? List<ListAddressOutputDTO>() : json.map((value) => ListAddressOutputDTO.fromJson(value)).toList();
  }

  static Map<String, ListAddressOutputDTO> mapFromJson(Map<String, dynamic> json) {
    var map = Map<String, ListAddressOutputDTO>();
    if (json != null && json.isNotEmpty) {
      json.forEach((String key, dynamic value) => map[key] = ListAddressOutputDTO.fromJson(value));
    }
    return map;
  }

  // maps a json object with a list of ListAddressOutputDTO-objects as value to a dart map
  static Map<String, List<ListAddressOutputDTO>> mapListFromJson(Map<String, dynamic> json) {
    var map = Map<String, List<ListAddressOutputDTO>>();
     if (json != null && json.isNotEmpty) {
       json.forEach((String key, dynamic value) {
         map[key] = ListAddressOutputDTO.listFromJson(value);
       });
     }
     return map;
  }
}

