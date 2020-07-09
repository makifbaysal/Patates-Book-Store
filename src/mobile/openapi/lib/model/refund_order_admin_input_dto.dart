part of openapi.api;

class RefundOrderAdminInputDTO {
  
  String orderId;
  
  bool status;
  RefundOrderAdminInputDTO();

  @override
  String toString() {
    return 'RefundOrderAdminInputDTO[orderId=$orderId, status=$status, ]';
  }

  RefundOrderAdminInputDTO.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    orderId = json['orderId'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    Map <String, dynamic> json = {};
    if (orderId != null)
      json['orderId'] = orderId;
    if (status != null)
      json['status'] = status;
    return json;
  }

  static List<RefundOrderAdminInputDTO> listFromJson(List<dynamic> json) {
    return json == null ? List<RefundOrderAdminInputDTO>() : json.map((value) => RefundOrderAdminInputDTO.fromJson(value)).toList();
  }

  static Map<String, RefundOrderAdminInputDTO> mapFromJson(Map<String, dynamic> json) {
    var map = Map<String, RefundOrderAdminInputDTO>();
    if (json != null && json.isNotEmpty) {
      json.forEach((String key, dynamic value) => map[key] = RefundOrderAdminInputDTO.fromJson(value));
    }
    return map;
  }

  // maps a json object with a list of RefundOrderAdminInputDTO-objects as value to a dart map
  static Map<String, List<RefundOrderAdminInputDTO>> mapListFromJson(Map<String, dynamic> json) {
    var map = Map<String, List<RefundOrderAdminInputDTO>>();
     if (json != null && json.isNotEmpty) {
       json.forEach((String key, dynamic value) {
         map[key] = RefundOrderAdminInputDTO.listFromJson(value);
       });
     }
     return map;
  }
}

