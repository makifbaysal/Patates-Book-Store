part of openapi.api;

class CancelOrderInputDTO {
  
  String orderId;
  CancelOrderInputDTO();

  @override
  String toString() {
    return 'CancelOrderInputDTO[orderId=$orderId, ]';
  }

  CancelOrderInputDTO.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    orderId = json['orderId'];
  }

  Map<String, dynamic> toJson() {
    Map <String, dynamic> json = {};
    if (orderId != null)
      json['orderId'] = orderId;
    return json;
  }

  static List<CancelOrderInputDTO> listFromJson(List<dynamic> json) {
    return json == null ? List<CancelOrderInputDTO>() : json.map((value) => CancelOrderInputDTO.fromJson(value)).toList();
  }

  static Map<String, CancelOrderInputDTO> mapFromJson(Map<String, dynamic> json) {
    var map = Map<String, CancelOrderInputDTO>();
    if (json != null && json.isNotEmpty) {
      json.forEach((String key, dynamic value) => map[key] = CancelOrderInputDTO.fromJson(value));
    }
    return map;
  }

  // maps a json object with a list of CancelOrderInputDTO-objects as value to a dart map
  static Map<String, List<CancelOrderInputDTO>> mapListFromJson(Map<String, dynamic> json) {
    var map = Map<String, List<CancelOrderInputDTO>>();
     if (json != null && json.isNotEmpty) {
       json.forEach((String key, dynamic value) {
         map[key] = CancelOrderInputDTO.listFromJson(value);
       });
     }
     return map;
  }
}

