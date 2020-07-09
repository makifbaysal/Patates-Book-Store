part of openapi.api;

class GetOrdersOutputDTO {
  
  String orderId;
  
  int quantity;
  
  double amountPaid;
  
  DateTime date;
  
  int state;
  GetOrdersOutputDTO();

  @override
  String toString() {
    return 'GetOrdersOutputDTO[orderId=$orderId, quantity=$quantity, amountPaid=$amountPaid, date=$date, state=$state, ]';
  }

  GetOrdersOutputDTO.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    orderId = json['orderId'];
    quantity = json['quantity'];
    amountPaid = (json['amountPaid'] == null) ?
      null :
      json['amountPaid'].toDouble();
    date = (json['date'] == null) ?
      null :
      DateTime.parse(json['date']);
    state = json['state'];
  }

  Map<String, dynamic> toJson() {
    Map <String, dynamic> json = {};
    if (orderId != null)
      json['orderId'] = orderId;
    if (quantity != null)
      json['quantity'] = quantity;
    if (amountPaid != null)
      json['amountPaid'] = amountPaid;
    if (date != null)
      json['date'] = date == null ? null : date.toUtc().toIso8601String();
    if (state != null)
      json['state'] = state;
    return json;
  }

  static List<GetOrdersOutputDTO> listFromJson(List<dynamic> json) {
    return json == null ? List<GetOrdersOutputDTO>() : json.map((value) => GetOrdersOutputDTO.fromJson(value)).toList();
  }

  static Map<String, GetOrdersOutputDTO> mapFromJson(Map<String, dynamic> json) {
    var map = Map<String, GetOrdersOutputDTO>();
    if (json != null && json.isNotEmpty) {
      json.forEach((String key, dynamic value) => map[key] = GetOrdersOutputDTO.fromJson(value));
    }
    return map;
  }

  // maps a json object with a list of GetOrdersOutputDTO-objects as value to a dart map
  static Map<String, List<GetOrdersOutputDTO>> mapListFromJson(Map<String, dynamic> json) {
    var map = Map<String, List<GetOrdersOutputDTO>>();
     if (json != null && json.isNotEmpty) {
       json.forEach((String key, dynamic value) {
         map[key] = GetOrdersOutputDTO.listFromJson(value);
       });
     }
     return map;
  }
}

