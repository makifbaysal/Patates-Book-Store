part of openapi.api;

class UpdateCommentInputDTO {
  
  String commentId;
  
  String productId;
  
  String commentHeader;
  
  String comment;
  
  double star;
  UpdateCommentInputDTO();

  @override
  String toString() {
    return 'UpdateCommentInputDTO[commentId=$commentId, productId=$productId, commentHeader=$commentHeader, comment=$comment, star=$star, ]';
  }

  UpdateCommentInputDTO.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    commentId = json['commentId'];
    productId = json['productId'];
    commentHeader = json['commentHeader'];
    comment = json['comment'];
    star = (json['star'] == null) ?
      null :
      json['star'].toDouble();
  }

  Map<String, dynamic> toJson() {
    Map <String, dynamic> json = {};
    if (commentId != null)
      json['commentId'] = commentId;
    if (productId != null)
      json['productId'] = productId;
    if (commentHeader != null)
      json['commentHeader'] = commentHeader;
    if (comment != null)
      json['comment'] = comment;
    if (star != null)
      json['star'] = star;
    return json;
  }

  static List<UpdateCommentInputDTO> listFromJson(List<dynamic> json) {
    return json == null ? List<UpdateCommentInputDTO>() : json.map((value) => UpdateCommentInputDTO.fromJson(value)).toList();
  }

  static Map<String, UpdateCommentInputDTO> mapFromJson(Map<String, dynamic> json) {
    var map = Map<String, UpdateCommentInputDTO>();
    if (json != null && json.isNotEmpty) {
      json.forEach((String key, dynamic value) => map[key] = UpdateCommentInputDTO.fromJson(value));
    }
    return map;
  }

  // maps a json object with a list of UpdateCommentInputDTO-objects as value to a dart map
  static Map<String, List<UpdateCommentInputDTO>> mapListFromJson(Map<String, dynamic> json) {
    var map = Map<String, List<UpdateCommentInputDTO>>();
     if (json != null && json.isNotEmpty) {
       json.forEach((String key, dynamic value) {
         map[key] = UpdateCommentInputDTO.listFromJson(value);
       });
     }
     return map;
  }
}

