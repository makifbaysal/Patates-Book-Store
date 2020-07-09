part of openapi.api;

class AdminReportOutputDTO {
  
  int totalUser;
  
  int totalOrder;
  
  double totalRevenue;
  
  String mostOrderCategory;
  
  int mostOrderCategoryCount;
  
  String mostOrderShippingCompany;
  
  int mostOrderShippingCompanyCount;
  
  int usedCoupon;
  
  String mostOrderUser;
  
  int mostOrderUserCount;
  AdminReportOutputDTO();

  @override
  String toString() {
    return 'AdminReportOutputDTO[totalUser=$totalUser, totalOrder=$totalOrder, totalRevenue=$totalRevenue, mostOrderCategory=$mostOrderCategory, mostOrderCategoryCount=$mostOrderCategoryCount, mostOrderShippingCompany=$mostOrderShippingCompany, mostOrderShippingCompanyCount=$mostOrderShippingCompanyCount, usedCoupon=$usedCoupon, mostOrderUser=$mostOrderUser, mostOrderUserCount=$mostOrderUserCount, ]';
  }

  AdminReportOutputDTO.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    totalUser = json['totalUser'];
    totalOrder = json['totalOrder'];
    totalRevenue = (json['totalRevenue'] == null) ?
      null :
      json['totalRevenue'].toDouble();
    mostOrderCategory = json['mostOrderCategory'];
    mostOrderCategoryCount = json['mostOrderCategoryCount'];
    mostOrderShippingCompany = json['mostOrderShippingCompany'];
    mostOrderShippingCompanyCount = json['mostOrderShippingCompanyCount'];
    usedCoupon = json['usedCoupon'];
    mostOrderUser = json['mostOrderUser'];
    mostOrderUserCount = json['mostOrderUserCount'];
  }

  Map<String, dynamic> toJson() {
    Map <String, dynamic> json = {};
    if (totalUser != null)
      json['totalUser'] = totalUser;
    if (totalOrder != null)
      json['totalOrder'] = totalOrder;
    if (totalRevenue != null)
      json['totalRevenue'] = totalRevenue;
    if (mostOrderCategory != null)
      json['mostOrderCategory'] = mostOrderCategory;
    if (mostOrderCategoryCount != null)
      json['mostOrderCategoryCount'] = mostOrderCategoryCount;
    if (mostOrderShippingCompany != null)
      json['mostOrderShippingCompany'] = mostOrderShippingCompany;
    if (mostOrderShippingCompanyCount != null)
      json['mostOrderShippingCompanyCount'] = mostOrderShippingCompanyCount;
    if (usedCoupon != null)
      json['usedCoupon'] = usedCoupon;
    if (mostOrderUser != null)
      json['mostOrderUser'] = mostOrderUser;
    if (mostOrderUserCount != null)
      json['mostOrderUserCount'] = mostOrderUserCount;
    return json;
  }

  static List<AdminReportOutputDTO> listFromJson(List<dynamic> json) {
    return json == null ? List<AdminReportOutputDTO>() : json.map((value) => AdminReportOutputDTO.fromJson(value)).toList();
  }

  static Map<String, AdminReportOutputDTO> mapFromJson(Map<String, dynamic> json) {
    var map = Map<String, AdminReportOutputDTO>();
    if (json != null && json.isNotEmpty) {
      json.forEach((String key, dynamic value) => map[key] = AdminReportOutputDTO.fromJson(value));
    }
    return map;
  }

  // maps a json object with a list of AdminReportOutputDTO-objects as value to a dart map
  static Map<String, List<AdminReportOutputDTO>> mapListFromJson(Map<String, dynamic> json) {
    var map = Map<String, List<AdminReportOutputDTO>>();
     if (json != null && json.isNotEmpty) {
       json.forEach((String key, dynamic value) {
         map[key] = AdminReportOutputDTO.listFromJson(value);
       });
     }
     return map;
  }
}

