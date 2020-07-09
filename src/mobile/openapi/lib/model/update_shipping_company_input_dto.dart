part of openapi.api;

class UpdateShippingCompanyInputDTO {
  
  String id;
  
  String name;
  
  double price;
  
  String website;
  
  String contactNumber;
  
  DateTime endDate;
  UpdateShippingCompanyInputDTO();

  @override
  String toString() {
    return 'UpdateShippingCompanyInputDTO[id=$id, name=$name, price=$price, website=$website, contactNumber=$contactNumber, endDate=$endDate, ]';
  }

  UpdateShippingCompanyInputDTO.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    id = json['id'];
    name = json['name'];
    price = (json['price'] == null) ?
      null :
      json['price'].toDouble();
    website = json['website'];
    contactNumber = json['contactNumber'];
    endDate = (json['endDate'] == null) ?
      null :
      DateTime.parse(json['endDate']);
  }

  Map<String, dynamic> toJson() {
    Map <String, dynamic> json = {};
    if (id != null)
      json['id'] = id;
    if (name != null)
      json['name'] = name;
    if (price != null)
      json['price'] = price;
    if (website != null)
      json['website'] = website;
    if (contactNumber != null)
      json['contactNumber'] = contactNumber;
    if (endDate != null)
      json['endDate'] = endDate == null ? null : endDate.toUtc().toIso8601String();
    return json;
  }

  static List<UpdateShippingCompanyInputDTO> listFromJson(List<dynamic> json) {
    return json == null ? List<UpdateShippingCompanyInputDTO>() : json.map((value) => UpdateShippingCompanyInputDTO.fromJson(value)).toList();
  }

  static Map<String, UpdateShippingCompanyInputDTO> mapFromJson(Map<String, dynamic> json) {
    var map = Map<String, UpdateShippingCompanyInputDTO>();
    if (json != null && json.isNotEmpty) {
      json.forEach((String key, dynamic value) => map[key] = UpdateShippingCompanyInputDTO.fromJson(value));
    }
    return map;
  }

  // maps a json object with a list of UpdateShippingCompanyInputDTO-objects as value to a dart map
  static Map<String, List<UpdateShippingCompanyInputDTO>> mapListFromJson(Map<String, dynamic> json) {
    var map = Map<String, List<UpdateShippingCompanyInputDTO>>();
     if (json != null && json.isNotEmpty) {
       json.forEach((String key, dynamic value) {
         map[key] = UpdateShippingCompanyInputDTO.listFromJson(value);
       });
     }
     return map;
  }
}

