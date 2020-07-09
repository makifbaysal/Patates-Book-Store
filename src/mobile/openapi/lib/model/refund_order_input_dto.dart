part of openapi.api;

class RefundOrderInputDTO {
  
  String orderId;
  RefundOrderInputDTO();

  @override
  String toString() {
    return 'RefundOrderInputDTO[orderId=$orderId, ]';
  }

  RefundOrderInputDTO.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    orderId = json['orderId'];
  }

  Map<String, dynamic> toJson() {
    Map <String, dynamic> json = {};
    if (orderId != null)
      json['orderId'] = orderId;
    return json;
  }

  static List<RefundOrderInputDTO> listFromJson(List<dynamic> json) {
    return json == null ? List<RefundOrderInputDTO>() : json.map((value) => RefundOrderInputDTO.fromJson(value)).toList();
  }

  static Map<String, RefundOrderInputDTO> mapFromJson(Map<String, dynamic> json) {
    var map = Map<String, RefundOrderInputDTO>();
    if (json != null && json.isNotEmpty) {
      json.forEach((String key, dynamic value) => map[key] = RefundOrderInputDTO.fromJson(value));
    }
    return map;
  }

  // maps a json object with a list of RefundOrderInputDTO-objects as value to a dart map
  static Map<String, List<RefundOrderInputDTO>> mapListFromJson(Map<String, dynamic> json) {
    var map = Map<String, List<RefundOrderInputDTO>>();
     if (json != null && json.isNotEmpty) {
       json.forEach((String key, dynamic value) {
         map[key] = RefundOrderInputDTO.listFromJson(value);
       });
     }
     return map;
  }
}

