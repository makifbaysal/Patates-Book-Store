part of openapi.api;

class RejectOrderInputDTO {
  
  String orderId;
  RejectOrderInputDTO();

  @override
  String toString() {
    return 'RejectOrderInputDTO[orderId=$orderId, ]';
  }

  RejectOrderInputDTO.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    orderId = json['orderId'];
  }

  Map<String, dynamic> toJson() {
    Map <String, dynamic> json = {};
    if (orderId != null)
      json['orderId'] = orderId;
    return json;
  }

  static List<RejectOrderInputDTO> listFromJson(List<dynamic> json) {
    return json == null ? List<RejectOrderInputDTO>() : json.map((value) => RejectOrderInputDTO.fromJson(value)).toList();
  }

  static Map<String, RejectOrderInputDTO> mapFromJson(Map<String, dynamic> json) {
    var map = Map<String, RejectOrderInputDTO>();
    if (json != null && json.isNotEmpty) {
      json.forEach((String key, dynamic value) => map[key] = RejectOrderInputDTO.fromJson(value));
    }
    return map;
  }

  // maps a json object with a list of RejectOrderInputDTO-objects as value to a dart map
  static Map<String, List<RejectOrderInputDTO>> mapListFromJson(Map<String, dynamic> json) {
    var map = Map<String, List<RejectOrderInputDTO>>();
     if (json != null && json.isNotEmpty) {
       json.forEach((String key, dynamic value) {
         map[key] = RejectOrderInputDTO.listFromJson(value);
       });
     }
     return map;
  }
}

