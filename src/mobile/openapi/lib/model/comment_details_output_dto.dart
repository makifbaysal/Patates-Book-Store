part of openapi.api;

class CommentDetailsOutputDTO {
  
  String commentId;
  
  String productId;
  
  String commentHeader;
  
  String comment;
  
  double star;
  CommentDetailsOutputDTO();

  @override
  String toString() {
    return 'CommentDetailsOutputDTO[commentId=$commentId, productId=$productId, commentHeader=$commentHeader, comment=$comment, star=$star, ]';
  }

  CommentDetailsOutputDTO.fromJson(Map<String, dynamic> json) {
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

  static List<CommentDetailsOutputDTO> listFromJson(List<dynamic> json) {
    return json == null ? List<CommentDetailsOutputDTO>() : json.map((value) => CommentDetailsOutputDTO.fromJson(value)).toList();
  }

  static Map<String, CommentDetailsOutputDTO> mapFromJson(Map<String, dynamic> json) {
    var map = Map<String, CommentDetailsOutputDTO>();
    if (json != null && json.isNotEmpty) {
      json.forEach((String key, dynamic value) => map[key] = CommentDetailsOutputDTO.fromJson(value));
    }
    return map;
  }

  // maps a json object with a list of CommentDetailsOutputDTO-objects as value to a dart map
  static Map<String, List<CommentDetailsOutputDTO>> mapListFromJson(Map<String, dynamic> json) {
    var map = Map<String, List<CommentDetailsOutputDTO>>();
     if (json != null && json.isNotEmpty) {
       json.forEach((String key, dynamic value) {
         map[key] = CommentDetailsOutputDTO.listFromJson(value);
       });
     }
     return map;
  }
}

