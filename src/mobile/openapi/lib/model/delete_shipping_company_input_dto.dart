part of openapi.api;

class DeleteShippingCompanyInputDTO {
  
  String id;
  DeleteShippingCompanyInputDTO();

  @override
  String toString() {
    return 'DeleteShippingCompanyInputDTO[id=$id, ]';
  }

  DeleteShippingCompanyInputDTO.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    Map <String, dynamic> json = {};
    if (id != null)
      json['id'] = id;
    return json;
  }

  static List<DeleteShippingCompanyInputDTO> listFromJson(List<dynamic> json) {
    return json == null ? List<DeleteShippingCompanyInputDTO>() : json.map((value) => DeleteShippingCompanyInputDTO.fromJson(value)).toList();
  }

  static Map<String, DeleteShippingCompanyInputDTO> mapFromJson(Map<String, dynamic> json) {
    var map = Map<String, DeleteShippingCompanyInputDTO>();
    if (json != null && json.isNotEmpty) {
      json.forEach((String key, dynamic value) => map[key] = DeleteShippingCompanyInputDTO.fromJson(value));
    }
    return map;
  }

  // maps a json object with a list of DeleteShippingCompanyInputDTO-objects as value to a dart map
  static Map<String, List<DeleteShippingCompanyInputDTO>> mapListFromJson(Map<String, dynamic> json) {
    var map = Map<String, List<DeleteShippingCompanyInputDTO>>();
     if (json != null && json.isNotEmpty) {
       json.forEach((String key, dynamic value) {
         map[key] = DeleteShippingCompanyInputDTO.listFromJson(value);
       });
     }
     return map;
  }
}

