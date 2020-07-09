part of openapi.api;

class ListingShippingCompaniesOutputDTO {
  
  String companyId;
  
  String imageUrl;
  
  String name;
  
  String contactNumber;
  
  DateTime endDate;
  
  double price;
  ListingShippingCompaniesOutputDTO();

  @override
  String toString() {
    return 'ListingShippingCompaniesOutputDTO[companyId=$companyId, imageUrl=$imageUrl, name=$name, contactNumber=$contactNumber, endDate=$endDate, price=$price, ]';
  }

  ListingShippingCompaniesOutputDTO.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    companyId = json['companyId'];
    imageUrl = json['imageUrl'];
    name = json['name'];
    contactNumber = json['contactNumber'];
    endDate = (json['endDate'] == null) ?
      null :
      DateTime.parse(json['endDate']);
    price = (json['price'] == null) ?
      null :
      json['price'].toDouble();
  }

  Map<String, dynamic> toJson() {
    Map <String, dynamic> json = {};
    if (companyId != null)
      json['companyId'] = companyId;
    if (imageUrl != null)
      json['imageUrl'] = imageUrl;
    if (name != null)
      json['name'] = name;
    if (contactNumber != null)
      json['contactNumber'] = contactNumber;
    if (endDate != null)
      json['endDate'] = endDate == null ? null : endDate.toUtc().toIso8601String();
    if (price != null)
      json['price'] = price;
    return json;
  }

  static List<ListingShippingCompaniesOutputDTO> listFromJson(List<dynamic> json) {
    return json == null ? List<ListingShippingCompaniesOutputDTO>() : json.map((value) => ListingShippingCompaniesOutputDTO.fromJson(value)).toList();
  }

  static Map<String, ListingShippingCompaniesOutputDTO> mapFromJson(Map<String, dynamic> json) {
    var map = Map<String, ListingShippingCompaniesOutputDTO>();
    if (json != null && json.isNotEmpty) {
      json.forEach((String key, dynamic value) => map[key] = ListingShippingCompaniesOutputDTO.fromJson(value));
    }
    return map;
  }

  // maps a json object with a list of ListingShippingCompaniesOutputDTO-objects as value to a dart map
  static Map<String, List<ListingShippingCompaniesOutputDTO>> mapListFromJson(Map<String, dynamic> json) {
    var map = Map<String, List<ListingShippingCompaniesOutputDTO>>();
     if (json != null && json.isNotEmpty) {
       json.forEach((String key, dynamic value) {
         map[key] = ListingShippingCompaniesOutputDTO.listFromJson(value);
       });
     }
     return map;
  }
}

