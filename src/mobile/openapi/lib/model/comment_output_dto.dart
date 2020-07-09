part of openapi.api;

class CommentOutputDTO {
  
  String commentId;
  
  String name;
  
  String commentHeader;
  
  String comment;
  
  double star;
  CommentOutputDTO();

  @override
  String toString() {
    return 'CommentOutputDTO[commentId=$commentId, name=$name, commentHeader=$commentHeader, comment=$comment, star=$star, ]';
  }

  CommentOutputDTO.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    commentId = json['commentId'];
    name = json['name'];
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
    if (name != null)
      json['name'] = name;
    if (commentHeader != null)
      json['commentHeader'] = commentHeader;
    if (comment != null)
      json['comment'] = comment;
    if (star != null)
      json['star'] = star;
    return json;
  }

  static List<CommentOutputDTO> listFromJson(List<dynamic> json) {
    return json == null ? List<CommentOutputDTO>() : json.map((value) => CommentOutputDTO.fromJson(value)).toList();
  }

  static Map<String, CommentOutputDTO> mapFromJson(Map<String, dynamic> json) {
    var map = Map<String, CommentOutputDTO>();
    if (json != null && json.isNotEmpty) {
      json.forEach((String key, dynamic value) => map[key] = CommentOutputDTO.fromJson(value));
    }
    return map;
  }

  // maps a json object with a list of CommentOutputDTO-objects as value to a dart map
  static Map<String, List<CommentOutputDTO>> mapListFromJson(Map<String, dynamic> json) {
    var map = Map<String, List<CommentOutputDTO>>();
     if (json != null && json.isNotEmpty) {
       json.forEach((String key, dynamic value) {
         map[key] = CommentOutputDTO.listFromJson(value);
       });
     }
     return map;
  }
}

