part of openapi.api;

class ShippingCompanyDetailsOutputDTO {
  
  String id;
  
  String imageUrl;
  
  String name;
  
  double price;
  
  String website;
  
  DateTime endDate;
  
  String contactNumber;
  ShippingCompanyDetailsOutputDTO();

  @override
  String toString() {
    return 'ShippingCompanyDetailsOutputDTO[id=$id, imageUrl=$imageUrl, name=$name, price=$price, website=$website, endDate=$endDate, contactNumber=$contactNumber, ]';
  }

  ShippingCompanyDetailsOutputDTO.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    id = json['id'];
    imageUrl = json['imageUrl'];
    name = json['name'];
    price = (json['price'] == null) ?
      null :
      json['price'].toDouble();
    website = json['website'];
    endDate = (json['endDate'] == null) ?
      null :
      DateTime.parse(json['endDate']);
    contactNumber = json['contactNumber'];
  }

  Map<String, dynamic> toJson() {
    Map <String, dynamic> json = {};
    if (id != null)
      json['id'] = id;
    if (imageUrl != null)
      json['imageUrl'] = imageUrl;
    if (name != null)
      json['name'] = name;
    if (price != null)
      json['price'] = price;
    if (website != null)
      json['website'] = website;
    if (endDate != null)
      json['endDate'] = endDate == null ? null : endDate.toUtc().toIso8601String();
    if (contactNumber != null)
      json['contactNumber'] = contactNumber;
    return json;
  }

  static List<ShippingCompanyDetailsOutputDTO> listFromJson(List<dynamic> json) {
    return json == null ? List<ShippingCompanyDetailsOutputDTO>() : json.map((value) => ShippingCompanyDetailsOutputDTO.fromJson(value)).toList();
  }

  static Map<String, ShippingCompanyDetailsOutputDTO> mapFromJson(Map<String, dynamic> json) {
    var map = Map<String, ShippingCompanyDetailsOutputDTO>();
    if (json != null && json.isNotEmpty) {
      json.forEach((String key, dynamic value) => map[key] = ShippingCompanyDetailsOutputDTO.fromJson(value));
    }
    return map;
  }

  // maps a json object with a list of ShippingCompanyDetailsOutputDTO-objects as value to a dart map
  static Map<String, List<ShippingCompanyDetailsOutputDTO>> mapListFromJson(Map<String, dynamic> json) {
    var map = Map<String, List<ShippingCompanyDetailsOutputDTO>>();
     if (json != null && json.isNotEmpty) {
       json.forEach((String key, dynamic value) {
         map[key] = ShippingCompanyDetailsOutputDTO.listFromJson(value);
       });
     }
     return map;
  }
}

