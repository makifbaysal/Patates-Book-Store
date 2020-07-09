part of openapi.api;

class ListingCouponsOutputDTO {
  
  String couponId;
  
  String header;
  
  String code;
  
  String description;
  
  DateTime expireTime;
  
  double percentageDiscount;
  
  double remainingQuantity;
  
  double startQuantity;
  ListingCouponsOutputDTO();

  @override
  String toString() {
    return 'ListingCouponsOutputDTO[couponId=$couponId, header=$header, code=$code, description=$description, expireTime=$expireTime, percentageDiscount=$percentageDiscount, remainingQuantity=$remainingQuantity, startQuantity=$startQuantity, ]';
  }

  ListingCouponsOutputDTO.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    couponId = json['couponId'];
    header = json['header'];
    code = json['code'];
    description = json['description'];
    expireTime = (json['expireTime'] == null) ?
      null :
      DateTime.parse(json['expireTime']);
    percentageDiscount = (json['percentageDiscount'] == null) ?
      null :
      json['percentageDiscount'].toDouble();
    remainingQuantity = (json['remainingQuantity'] == null) ?
      null :
      json['remainingQuantity'].toDouble();
    startQuantity = (json['startQuantity'] == null) ?
      null :
      json['startQuantity'].toDouble();
  }

  Map<String, dynamic> toJson() {
    Map <String, dynamic> json = {};
    if (couponId != null)
      json['couponId'] = couponId;
    if (header != null)
      json['header'] = header;
    if (code != null)
      json['code'] = code;
    if (description != null)
      json['description'] = description;
    if (expireTime != null)
      json['expireTime'] = expireTime == null ? null : expireTime.toUtc().toIso8601String();
    if (percentageDiscount != null)
      json['percentageDiscount'] = percentageDiscount;
    if (remainingQuantity != null)
      json['remainingQuantity'] = remainingQuantity;
    if (startQuantity != null)
      json['startQuantity'] = startQuantity;
    return json;
  }

  static List<ListingCouponsOutputDTO> listFromJson(List<dynamic> json) {
    return json == null ? List<ListingCouponsOutputDTO>() : json.map((value) => ListingCouponsOutputDTO.fromJson(value)).toList();
  }

  static Map<String, ListingCouponsOutputDTO> mapFromJson(Map<String, dynamic> json) {
    var map = Map<String, ListingCouponsOutputDTO>();
    if (json != null && json.isNotEmpty) {
      json.forEach((String key, dynamic value) => map[key] = ListingCouponsOutputDTO.fromJson(value));
    }
    return map;
  }

  // maps a json object with a list of ListingCouponsOutputDTO-objects as value to a dart map
  static Map<String, List<ListingCouponsOutputDTO>> mapListFromJson(Map<String, dynamic> json) {
    var map = Map<String, List<ListingCouponsOutputDTO>>();
     if (json != null && json.isNotEmpty) {
       json.forEach((String key, dynamic value) {
         map[key] = ListingCouponsOutputDTO.listFromJson(value);
       });
     }
     return map;
  }
}

