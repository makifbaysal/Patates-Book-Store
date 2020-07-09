part of openapi.api;

class DeleteBookmarkInputDTO {
  
  String userId;
  
  String productId;
  DeleteBookmarkInputDTO();

  @override
  String toString() {
    return 'DeleteBookmarkInputDTO[userId=$userId, productId=$productId, ]';
  }

  DeleteBookmarkInputDTO.fromJson(Map<String, dynamic> json) {
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

  static List<DeleteBookmarkInputDTO> listFromJson(List<dynamic> json) {
    return json == null ? List<DeleteBookmarkInputDTO>() : json.map((value) => DeleteBookmarkInputDTO.fromJson(value)).toList();
  }

  static Map<String, DeleteBookmarkInputDTO> mapFromJson(Map<String, dynamic> json) {
    var map = Map<String, DeleteBookmarkInputDTO>();
    if (json != null && json.isNotEmpty) {
      json.forEach((String key, dynamic value) => map[key] = DeleteBookmarkInputDTO.fromJson(value));
    }
    return map;
  }

  // maps a json object with a list of DeleteBookmarkInputDTO-objects as value to a dart map
  static Map<String, List<DeleteBookmarkInputDTO>> mapListFromJson(Map<String, dynamic> json) {
    var map = Map<String, List<DeleteBookmarkInputDTO>>();
     if (json != null && json.isNotEmpty) {
       json.forEach((String key, dynamic value) {
         map[key] = DeleteBookmarkInputDTO.listFromJson(value);
       });
     }
     return map;
  }
}

