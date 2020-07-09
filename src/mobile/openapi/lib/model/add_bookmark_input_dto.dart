part of openapi.api;

class AddBookmarkInputDTO {
  
  String userId;
  
  String productId;
  AddBookmarkInputDTO();

  @override
  String toString() {
    return 'AddBookmarkInputDTO[userId=$userId, productId=$productId, ]';
  }

  AddBookmarkInputDTO.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    userId = json['userId'];
    productId = json['productId'];
  }

  Map<String, dynamic> toJson() {
    Map <String, dynamic> json = {};
    if (userId != null)
      json['userId'] = userId;
    if (productId != null)
      json['productId'] = productId;
    return json;
  }

  static List<AddBookmarkInputDTO> listFromJson(List<dynamic> json) {
    return json == null ? List<AddBookmarkInputDTO>() : json.map((value) => AddBookmarkInputDTO.fromJson(value)).toList();
  }

  static Map<String, AddBookmarkInputDTO> mapFromJson(Map<String, dynamic> json) {
    var map = Map<String, AddBookmarkInputDTO>();
    if (json != null && json.isNotEmpty) {
      json.forEach((String key, dynamic value) => map[key] = AddBookmarkInputDTO.fromJson(value));
    }
    return map;
  }

  // maps a json object with a list of AddBookmarkInputDTO-objects as value to a dart map
  static Map<String, List<AddBookmarkInputDTO>> mapListFromJson(Map<String, dynamic> json) {
    var map = Map<String, List<AddBookmarkInputDTO>>();
     if (json != null && json.isNotEmpty) {
       json.forEach((String key, dynamic value) {
         map[key] = AddBookmarkInputDTO.listFromJson(value);
       });
     }
     return map;
  }
}

