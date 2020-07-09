part of openapi.api;

class MakeCommentInputDTO {
  
  String userId;
  
  String productId;
  
  String commentHeader;
  
  String comment;
  
  double star;
  MakeCommentInputDTO();

  @override
  String toString() {
    return 'MakeCommentInputDTO[userId=$userId, productId=$productId, commentHeader=$commentHeader, comment=$comment, star=$star, ]';
  }

  MakeCommentInputDTO.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    userId = json['userId'];
    productId = json['productId'];
    commentHeader = json['commentHeader'];
    comment = json['comment'];
    star = (json['star'] == null) ?
      null :
      json['star'].toDouble();
  }

  Map<String, dynamic> toJson() {
    Map <String, dynamic> json = {};
    if (userId != null)
      json['userId'] = userId;
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

  static List<MakeCommentInputDTO> listFromJson(List<dynamic> json) {
    return json == null ? List<MakeCommentInputDTO>() : json.map((value) => MakeCommentInputDTO.fromJson(value)).toList();
  }

  static Map<String, MakeCommentInputDTO> mapFromJson(Map<String, dynamic> json) {
    var map = Map<String, MakeCommentInputDTO>();
    if (json != null && json.isNotEmpty) {
      json.forEach((String key, dynamic value) => map[key] = MakeCommentInputDTO.fromJson(value));
    }
    return map;
  }

  // maps a json object with a list of MakeCommentInputDTO-objects as value to a dart map
  static Map<String, List<MakeCommentInputDTO>> mapListFromJson(Map<String, dynamic> json) {
    var map = Map<String, List<MakeCommentInputDTO>>();
     if (json != null && json.isNotEmpty) {
       json.forEach((String key, dynamic value) {
         map[key] = MakeCommentInputDTO.listFromJson(value);
       });
     }
     return map;
  }
}

