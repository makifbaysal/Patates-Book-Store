part of openapi.api;

class OrderDetailsOutputDTO {
  
  String orderNo;
  
  String address;
  
  String cartNo;
  
  String shippingCompany;
  
  DateTime date;
  
  String coupon;
  
  double percentageDiscount;
  
  int state;
  
  double amountPaid;
  
  List<OrderProductListingOutputDTO> products = [];
  OrderDetailsOutputDTO();

  @override
  String toString() {
    return 'OrderDetailsOutputDTO[orderNo=$orderNo, address=$address, cartNo=$cartNo, shippingCompany=$shippingCompany, date=$date, coupon=$coupon, percentageDiscount=$percentageDiscount, state=$state, amountPaid=$amountPaid, products=$products, ]';
  }

  OrderDetailsOutputDTO.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    orderNo = json['orderNo'];
    address = json['address'];
    cartNo = json['cartNo'];
    shippingCompany = json['shippingCompany'];
    date = (json['date'] == null) ?
      null :
      DateTime.parse(json['date']);
    coupon = json['coupon'];
    percentageDiscount = (json['percentageDiscount'] == null) ?
      null :
      json['percentageDiscount'].toDouble();
    state = json['state'];
    amountPaid = (json['amountPaid'] == null) ?
      null :
      json['amountPaid'].toDouble();
    products = (json['products'] == null) ?
      null :
      OrderProductListingOutputDTO.listFromJson(json['products']);
  }

  Map<String, dynamic> toJson() {
    Map <String, dynamic> json = {};
    if (orderNo != null)
      json['orderNo'] = orderNo;
    if (address != null)
      json['address'] = address;
    if (cartNo != null)
      json['cartNo'] = cartNo;
    if (shippingCompany != null)
      json['shippingCompany'] = shippingCompany;
    if (date != null)
      json['date'] = date == null ? null : date.toUtc().toIso8601String();
    if (coupon != null)
      json['coupon'] = coupon;
    if (percentageDiscount != null)
      json['percentageDiscount'] = percentageDiscount;
    if (state != null)
      json['state'] = state;
    if (amountPaid != null)
      json['amountPaid'] = amountPaid;
    if (products != null)
      json['products'] = products;
    return json;
  }

  static List<OrderDetailsOutputDTO> listFromJson(List<dynamic> json) {
    return json == null ? List<OrderDetailsOutputDTO>() : json.map((value) => OrderDetailsOutputDTO.fromJson(value)).toList();
  }

  static Map<String, OrderDetailsOutputDTO> mapFromJson(Map<String, dynamic> json) {
    var map = Map<String, OrderDetailsOutputDTO>();
    if (json != null && json.isNotEmpty) {
      json.forEach((String key, dynamic value) => map[key] = OrderDetailsOutputDTO.fromJson(value));
    }
    return map;
  }

  // maps a json object with a list of OrderDetailsOutputDTO-objects as value to a dart map
  static Map<String, List<OrderDetailsOutputDTO>> mapListFromJson(Map<String, dynamic> json) {
    var map = Map<String, List<OrderDetailsOutputDTO>>();
     if (json != null && json.isNotEmpty) {
       json.forEach((String key, dynamic value) {
         map[key] = OrderDetailsOutputDTO.listFromJson(value);
       });
     }
     return map;
  }
}

