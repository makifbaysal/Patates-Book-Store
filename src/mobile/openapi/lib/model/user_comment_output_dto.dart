part of openapi.api;

class UserCommentOutputDTO {
  
  String commentId;
  
  String productId;
  
  String name;
  
  String commentHeader;
  
  String comment;
  
  double star;
  
  String productName;
  UserCommentOutputDTO();

  @override
  String toString() {
    return 'UserCommentOutputDTO[commentId=$commentId, productId=$productId, name=$name, commentHeader=$commentHeader, comment=$comment, star=$star, productName=$productName, ]';
  }

  UserCommentOutputDTO.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    commentId = json['commentId'];
    productId = json['productId'];
    name = json['name'];
    commentHeader = json['commentHeader'];
    comment = json['comment'];
    star = (json['star'] == null) ?
      null :
      json['star'].toDouble();
    productName = json['productName'];
  }

  Map<String, dynamic> toJson() {
    Map <String, dynamic> json = {};
    if (commentId != null)
      json['commentId'] = commentId;
    if (productId != null)
      json['productId'] = productId;
    if (name != null)
      json['name'] = name;
    if (commentHeader != null)
      json['commentHeader'] = commentHeader;
    if (comment != null)
      json['comment'] = comment;
    if (star != null)
      json['star'] = star;
    if (productName != null)
      json['productName'] = productName;
    return json;
  }

  static List<UserCommentOutputDTO> listFromJson(List<dynamic> json) {
    return json == null ? List<UserCommentOutputDTO>() : json.map((value) => UserCommentOutputDTO.fromJson(value)).toList();
  }

  static Map<String, UserCommentOutputDTO> mapFromJson(Map<String, dynamic> json) {
    var map = Map<String, UserCommentOutputDTO>();
    if (json != null && json.isNotEmpty) {
      json.forEach((String key, dynamic value) => map[key] = UserCommentOutputDTO.fromJson(value));
    }
    return map;
  }

  // maps a json object with a list of UserCommentOutputDTO-objects as value to a dart map
  static Map<String, List<UserCommentOutputDTO>> mapListFromJson(Map<String, dynamic> json) {
    var map = Map<String, List<UserCommentOutputDTO>>();
     if (json != null && json.isNotEmpty) {
       json.forEach((String key, dynamic value) {
         map[key] = UserCommentOutputDTO.listFromJson(value);
       });
     }
     return map;
  }
}

