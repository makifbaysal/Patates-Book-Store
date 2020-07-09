part of openapi.api;

class DeleteUserInputDTO {
  
  String userId;
  DeleteUserInputDTO();

  @override
  String toString() {
    return 'DeleteUserInputDTO[userId=$userId, ]';
  }

  DeleteUserInputDTO.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    Map <String, dynamic> json = {};
    if (userId != null)
      json['userId'] = userId;
    return json;
  }

  static List<DeleteUserInputDTO> listFromJson(List<dynamic> json) {
    return json == null ? List<DeleteUserInputDTO>() : json.map((value) => DeleteUserInputDTO.fromJson(value)).toList();
  }

  static Map<String, DeleteUserInputDTO> mapFromJson(Map<String, dynamic> json) {
    var map = Map<String, DeleteUserInputDTO>();
    if (json != null && json.isNotEmpty) {
      json.forEach((String key, dynamic value) => map[key] = DeleteUserInputDTO.fromJson(value));
    }
    return map;
  }

  // maps a json object with a list of DeleteUserInputDTO-objects as value to a dart map
  static Map<String, List<DeleteUserInputDTO>> mapListFromJson(Map<String, dynamic> json) {
    var map = Map<String, List<DeleteUserInputDTO>>();
     if (json != null && json.isNotEmpty) {
       json.forEach((String key, dynamic value) {
         map[key] = DeleteUserInputDTO.listFromJson(value);
       });
     }
     return map;
  }
}

