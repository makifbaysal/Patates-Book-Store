part of openapi.api;

class UpdateCouponInputDTO {
  
  String id;
  
  String header;
  
  String code;
  
  String description;
  
  int remainingQuantity;
  
  int startQuantity;
  
  double lowerLimit;
  
  double percentageDiscount;
  
  DateTime expireTime;
  
  DateTime startTime;
  UpdateCouponInputDTO();

  @override
  String toString() {
    return 'UpdateCouponInputDTO[id=$id, header=$header, code=$code, description=$description, remainingQuantity=$remainingQuantity, startQuantity=$startQuantity, lowerLimit=$lowerLimit, percentageDiscount=$percentageDiscount, expireTime=$expireTime, startTime=$startTime, ]';
  }

  UpdateCouponInputDTO.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    id = json['id'];
    header = json['header'];
    code = json['code'];
    description = json['description'];
    remainingQuantity = json['remainingQuantity'];
    startQuantity = json['startQuantity'];
    lowerLimit = (json['lowerLimit'] == null) ?
      null :
      json['lowerLimit'].toDouble();
    percentageDiscount = (json['percentageDiscount'] == null) ?
      null :
      json['percentageDiscount'].toDouble();
    expireTime = (json['expireTime'] == null) ?
      null :
      DateTime.parse(json['expireTime']);
    startTime = (json['startTime'] == null) ?
      null :
      DateTime.parse(json['startTime']);
  }

  Map<String, dynamic> toJson() {
    Map <String, dynamic> json = {};
    if (id != null)
      json['id'] = id;
    if (header != null)
      json['header'] = header;
    if (code != null)
      json['code'] = code;
    if (description != null)
      json['description'] = description;
    if (remainingQuantity != null)
      json['remainingQuantity'] = remainingQuantity;
    if (startQuantity != null)
      json['startQuantity'] = startQuantity;
    if (lowerLimit != null)
      json['lowerLimit'] = lowerLimit;
    if (percentageDiscount != null)
      json['percentageDiscount'] = percentageDiscount;
    if (expireTime != null)
      json['expireTime'] = expireTime == null ? null : expireTime.toUtc().toIso8601String();
    if (startTime != null)
      json['startTime'] = startTime == null ? null : startTime.toUtc().toIso8601String();
    return json;
  }

  static List<UpdateCouponInputDTO> listFromJson(List<dynamic> json) {
    return json == null ? List<UpdateCouponInputDTO>() : json.map((value) => UpdateCouponInputDTO.fromJson(value)).toList();
  }

  static Map<String, UpdateCouponInputDTO> mapFromJson(Map<String, dynamic> json) {
    var map = Map<String, UpdateCouponInputDTO>();
    if (json != null && json.isNotEmpty) {
      json.forEach((String key, dynamic value) => map[key] = UpdateCouponInputDTO.fromJson(value));
    }
    return map;
  }

  // maps a json object with a list of UpdateCouponInputDTO-objects as value to a dart map
  static Map<String, List<UpdateCouponInputDTO>> mapListFromJson(Map<String, dynamic> json) {
    var map = Map<String, List<UpdateCouponInputDTO>>();
     if (json != null && json.isNotEmpty) {
       json.forEach((String key, dynamic value) {
         map[key] = UpdateCouponInputDTO.listFromJson(value);
       });
     }
     return map;
  }
}

