part of openapi.api;

class AcceptOrderInputDTO {
  
  String orderId;
  AcceptOrderInputDTO();

  @override
  String toString() {
    return 'AcceptOrderInputDTO[orderId=$orderId, ]';
  }

  AcceptOrderInputDTO.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    orderId = json['orderId'];
  }

  Map<String, dynamic> toJson() {
    Map <String, dynamic> json = {};
    if (orderId != null)
      json['orderId'] = orderId;
    return json;
  }

  static List<AcceptOrderInputDTO> listFromJson(List<dynamic> json) {
    return json == null ? List<AcceptOrderInputDTO>() : json.map((value) => AcceptOrderInputDTO.fromJson(value)).toList();
  }

  static Map<String, AcceptOrderInputDTO> mapFromJson(Map<String, dynamic> json) {
    var map = Map<String, AcceptOrderInputDTO>();
    if (json != null && json.isNotEmpty) {
      json.forEach((String key, dynamic value) => map[key] = AcceptOrderInputDTO.fromJson(value));
    }
    return map;
  }

  // maps a json object with a list of AcceptOrderInputDTO-objects as value to a dart map
  static Map<String, List<AcceptOrderInputDTO>> mapListFromJson(Map<String, dynamic> json) {
    var map = Map<String, List<AcceptOrderInputDTO>>();
     if (json != null && json.isNotEmpty) {
       json.forEach((String key, dynamic value) {
         map[key] = AcceptOrderInputDTO.listFromJson(value);
       });
     }
     return map;
  }
}

