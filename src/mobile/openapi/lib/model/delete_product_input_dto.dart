part of openapi.api;

class DeleteProductInputDTO {
  
  String id;
  DeleteProductInputDTO();

  @override
  String toString() {
    return 'DeleteProductInputDTO[id=$id, ]';
  }

  DeleteProductInputDTO.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    Map <String, dynamic> json = {};
    if (id != null)
      json['id'] = id;
    return json;
  }

  static List<DeleteProductInputDTO> listFromJson(List<dynamic> json) {
    return json == null ? List<DeleteProductInputDTO>() : json.map((value) => DeleteProductInputDTO.fromJson(value)).toList();
  }

  static Map<String, DeleteProductInputDTO> mapFromJson(Map<String, dynamic> json) {
    var map = Map<String, DeleteProductInputDTO>();
    if (json != null && json.isNotEmpty) {
      json.forEach((String key, dynamic value) => map[key] = DeleteProductInputDTO.fromJson(value));
    }
    return map;
  }

  // maps a json object with a list of DeleteProductInputDTO-objects as value to a dart map
  static Map<String, List<DeleteProductInputDTO>> mapListFromJson(Map<String, dynamic> json) {
    var map = Map<String, List<DeleteProductInputDTO>>();
     if (json != null && json.isNotEmpty) {
       json.forEach((String key, dynamic value) {
         map[key] = DeleteProductInputDTO.listFromJson(value);
       });
     }
     return map;
  }
}

