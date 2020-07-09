part of openapi.api;

class UseCouponCodeOutputDTO {
  
  double lowerLimit;
  
  double percentageDiscount;
  UseCouponCodeOutputDTO();

  @override
  String toString() {
    return 'UseCouponCodeOutputDTO[lowerLimit=$lowerLimit, percentageDiscount=$percentageDiscount, ]';
  }

  UseCouponCodeOutputDTO.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    lowerLimit = (json['lowerLimit'] == null) ?
      null :
      json['lowerLimit'].toDouble();
    percentageDiscount = (json['percentageDiscount'] == null) ?
      null :
      json['percentageDiscount'].toDouble();
  }

  Map<String, dynamic> toJson() {
    Map <String, dynamic> json = {};
    if (lowerLimit != null)
      json['lowerLimit'] = lowerLimit;
    if (percentageDiscount != null)
      json['percentageDiscount'] = percentageDiscount;
    return json;
  }

  static List<UseCouponCodeOutputDTO> listFromJson(List<dynamic> json) {
    return json == null ? List<UseCouponCodeOutputDTO>() : json.map((value) => UseCouponCodeOutputDTO.fromJson(value)).toList();
  }

  static Map<String, UseCouponCodeOutputDTO> mapFromJson(Map<String, dynamic> json) {
    var map = Map<String, UseCouponCodeOutputDTO>();
    if (json != null && json.isNotEmpty) {
      json.forEach((String key, dynamic value) => map[key] = UseCouponCodeOutputDTO.fromJson(value));
    }
    return map;
  }

  // maps a json object with a list of UseCouponCodeOutputDTO-objects as value to a dart map
  static Map<String, List<UseCouponCodeOutputDTO>> mapListFromJson(Map<String, dynamic> json) {
    var map = Map<String, List<UseCouponCodeOutputDTO>>();
     if (json != null && json.isNotEmpty) {
       json.forEach((String key, dynamic value) {
         map[key] = UseCouponCodeOutputDTO.listFromJson(value);
       });
     }
     return map;
  }
}

