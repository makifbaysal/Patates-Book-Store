part of openapi.api;

class SendMessageInputDTO {
  
  String userId;
  
  String subject;
  
  String message;
  SendMessageInputDTO();

  @override
  String toString() {
    return 'SendMessageInputDTO[userId=$userId, subject=$subject, message=$message, ]';
  }

  SendMessageInputDTO.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    userId = json['userId'];
    subject = json['subject'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    Map <String, dynamic> json = {};
    if (userId != null)
      json['userId'] = userId;
    if (subject != null)
      json['subject'] = subject;
    if (message != null)
      json['message'] = message;
    return json;
  }

  static List<SendMessageInputDTO> listFromJson(List<dynamic> json) {
    return json == null ? List<SendMessageInputDTO>() : json.map((value) => SendMessageInputDTO.fromJson(value)).toList();
  }

  static Map<String, SendMessageInputDTO> mapFromJson(Map<String, dynamic> json) {
    var map = Map<String, SendMessageInputDTO>();
    if (json != null && json.isNotEmpty) {
      json.forEach((String key, dynamic value) => map[key] = SendMessageInputDTO.fromJson(value));
    }
    return map;
  }

  // maps a json object with a list of SendMessageInputDTO-objects as value to a dart map
  static Map<String, List<SendMessageInputDTO>> mapListFromJson(Map<String, dynamic> json) {
    var map = Map<String, List<SendMessageInputDTO>>();
     if (json != null && json.isNotEmpty) {
       json.forEach((String key, dynamic value) {
         map[key] = SendMessageInputDTO.listFromJson(value);
       });
     }
     return map;
  }
}

