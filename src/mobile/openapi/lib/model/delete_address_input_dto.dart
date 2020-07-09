part of openapi.api;

class DeleteAddressInputDTO {
  
  String userId;
  
  String addressId;
  DeleteAddressInputDTO();

  @override
  String toString() {
    return 'DeleteAddressInputDTO[userId=$userId, addressId=$addressId, ]';
  }

  DeleteAddressInputDTO.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    userId = json['userId'];
    addressId = json['addressId'];
  }

  Map<String, dynamic> toJson() {
    Map <String, dynamic> json = {};
    if (userId != null)
      json['userId'] = userId;
    if (addressId != null)
      json['addressId'] = addressId;
    return json;
  }

  static List<DeleteAddressInputDTO> listFromJson(List<dynamic> json) {
    return json == null ? List<DeleteAddressInputDTO>() : json.map((value) => DeleteAddressInputDTO.fromJson(value)).toList();
  }

  static Map<String, DeleteAddressInputDTO> mapFromJson(Map<String, dynamic> json) {
    var map = Map<String, DeleteAddressInputDTO>();
    if (json != null && json.isNotEmpty) {
      json.forEach((String key, dynamic value) => map[key] = DeleteAddressInputDTO.fromJson(value));
    }
    return map;
  }

  // maps a json object with a list of DeleteAddressInputDTO-objects as value to a dart map
  static Map<String, List<DeleteAddressInputDTO>> mapListFromJson(Map<String, dynamic> json) {
    var map = Map<String, List<DeleteAddressInputDTO>>();
     if (json != null && json.isNotEmpty) {
       json.forEach((String key, dynamic value) {
         map[key] = DeleteAddressInputDTO.listFromJson(value);
       });
     }
     return map;
  }
}

