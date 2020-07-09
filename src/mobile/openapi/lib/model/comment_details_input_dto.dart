part of openapi.api;

class CommentDetailsInputDTO {
  
  String commentId;
  
  String productId;
  CommentDetailsInputDTO();

  @override
  String toString() {
    return 'CommentDetailsInputDTO[commentId=$commentId, productId=$productId, ]';
  }

  CommentDetailsInputDTO.fromJson(Map<String, dynamic> json) {
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

  static List<CommentDetailsInputDTO> listFromJson(List<dynamic> json) {
    return json == null ? List<CommentDetailsInputDTO>() : json.map((value) => CommentDetailsInputDTO.fromJson(value)).toList();
  }

  static Map<String, CommentDetailsInputDTO> mapFromJson(Map<String, dynamic> json) {
    var map = Map<String, CommentDetailsInputDTO>();
    if (json != null && json.isNotEmpty) {
      json.forEach((String key, dynamic value) => map[key] = CommentDetailsInputDTO.fromJson(value));
    }
    return map;
  }

  // maps a json object with a list of CommentDetailsInputDTO-objects as value to a dart map
  static Map<String, List<CommentDetailsInputDTO>> mapListFromJson(Map<String, dynamic> json) {
    var map = Map<String, List<CommentDetailsInputDTO>>();
     if (json != null && json.isNotEmpty) {
       json.forEach((String key, dynamic value) {
         map[key] = CommentDetailsInputDTO.listFromJson(value);
       });
     }
     return map;
  }
}

