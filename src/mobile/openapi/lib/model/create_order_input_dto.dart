part of openapi.api;

class CreateOrderInputDTO {
  
  String userId;
  
  String addressId;
  
  String cartId;
  
  String coupon;
  
  String shippingCompanyId;
  
  double amountPaid;
  CreateOrderInputDTO();

  @override
  String toString() {
    return 'CreateOrderInputDTO[userId=$userId, addressId=$addressId, cartId=$cartId, coupon=$coupon, shippingCompanyId=$shippingCompanyId, amountPaid=$amountPaid, ]';
  }

  CreateOrderInputDTO.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    userId = json['userId'];
    addressId = json['addressId'];
    cartId = json['cartId'];
    coupon = json['coupon'];
    shippingCompanyId = json['shippingCompanyId'];
    amountPaid = (json['amountPaid'] == null) ?
      null :
      json['amountPaid'].toDouble();
  }

  Map<String, dynamic> toJson() {
    Map <String, dynamic> json = {};
    if (userId != null)
      json['userId'] = userId;
    if (addressId != null)
      json['addressId'] = addressId;
    if (cartId != null)
      json['cartId'] = cartId;
    if (coupon != null)
      json['coupon'] = coupon;
    if (shippingCompanyId != null)
      json['shippingCompanyId'] = shippingCompanyId;
    if (amountPaid != null)
      json['amountPaid'] = amountPaid;
    return json;
  }

  static List<CreateOrderInputDTO> listFromJson(List<dynamic> json) {
    return json == null ? List<CreateOrderInputDTO>() : json.map((value) => CreateOrderInputDTO.fromJson(value)).toList();
  }

  static Map<String, CreateOrderInputDTO> mapFromJson(Map<String, dynamic> json) {
    var map = Map<String, CreateOrderInputDTO>();
    if (json != null && json.isNotEmpty) {
      json.forEach((String key, dynamic value) => map[key] = CreateOrderInputDTO.fromJson(value));
    }
    return map;
  }

  // maps a json object with a list of CreateOrderInputDTO-objects as value to a dart map
  static Map<String, List<CreateOrderInputDTO>> mapListFromJson(Map<String, dynamic> json) {
    var map = Map<String, List<CreateOrderInputDTO>>();
     if (json != null && json.isNotEmpty) {
       json.forEach((String key, dynamic value) {
         map[key] = CreateOrderInputDTO.listFromJson(value);
       });
     }
     return map;
  }
}

