part of openapi.api;

class DeleteCommentInputDTO {
  
  String commentId;
  
  String productId;
  DeleteCommentInputDTO();

  @override
  String toString() {
    return 'DeleteCommentInputDTO[commentId=$commentId, productId=$productId, ]';
  }

  DeleteCommentInputDTO.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    commentId = json['commentId'];
    productId = json['productId'];
  }

  Map<String, dynamic> toJson() {
    Map <String, dynamic> json = {};
    if (commentId != null)
      json['commentId'] = commentId;
    if (productId != null)
      json['productId'] = productId;
    return json;
  }

  static List<DeleteCommentInputDTO> listFromJson(List<dynamic> json) {
    return json == null ? List<DeleteCommentInputDTO>() : json.map((value) => DeleteCommentInputDTO.fromJson(value)).toList();
  }

  static Map<String, DeleteCommentInputDTO> mapFromJson(Map<String, dynamic> json) {
    var map = Map<String, DeleteCommentInputDTO>();
    if (json != null && json.isNotEmpty) {
      json.forEach((String key, dynamic value) => map[key] = DeleteCommentInputDTO.fromJson(value));
    }
    return map;
  }

  // maps a json object with a list of DeleteCommentInputDTO-objects as value to a dart map
  static Map<String, List<DeleteCommentInputDTO>> mapListFromJson(Map<String, dynamic> json) {
    var map = Map<String, List<DeleteCommentInputDTO>>();
     if (json != null && json.isNotEmpty) {
       json.forEach((String key, dynamic value) {
         map[key] = DeleteCommentInputDTO.listFromJson(value);
       });
     }
     return map;
  }
}

