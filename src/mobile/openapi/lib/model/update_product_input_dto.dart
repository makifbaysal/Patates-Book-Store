part of openapi.api;

class UpdateProductInputDTO {
  
  String id;
  
  String description;
  
  List<String> category = [];
  
  double price;
  
  String name;
  
  String author;
  
  String language;
  
  int stock;
  
  int page;
  UpdateProductInputDTO();

  @override
  String toString() {
    return 'UpdateProductInputDTO[id=$id, description=$description, category=$category, price=$price, name=$name, author=$author, language=$language, stock=$stock, page=$page, ]';
  }

  UpdateProductInputDTO.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    id = json['id'];
    description = json['description'];
    category = (json['category'] == null) ?
      null :
      (json['category'] as List).cast<String>();
    price = (json['price'] == null) ?
      null :
      json['price'].toDouble();
    name = json['name'];
    author = json['author'];
    language = json['language'];
    stock = json['stock'];
    page = json['page'];
  }

  Map<String, dynamic> toJson() {
    Map <String, dynamic> json = {};
    if (id != null)
      json['id'] = id;
    if (description != null)
      json['description'] = description;
    if (category != null)
      json['category'] = category;
    if (price != null)
      json['price'] = price;
    if (name != null)
      json['name'] = name;
    if (author != null)
      json['author'] = author;
    if (language != null)
      json['language'] = language;
    if (stock != null)
      json['stock'] = stock;
    if (page != null)
      json['page'] = page;
    return json;
  }

  static List<UpdateProductInputDTO> listFromJson(List<dynamic> json) {
    return json == null ? List<UpdateProductInputDTO>() : json.map((value) => UpdateProductInputDTO.fromJson(value)).toList();
  }

  static Map<String, UpdateProductInputDTO> mapFromJson(Map<String, dynamic> json) {
    var map = Map<String, UpdateProductInputDTO>();
    if (json != null && json.isNotEmpty) {
      json.forEach((String key, dynamic value) => map[key] = UpdateProductInputDTO.fromJson(value));
    }
    return map;
  }

  // maps a json object with a list of UpdateProductInputDTO-objects as value to a dart map
  static Map<String, List<UpdateProductInputDTO>> mapListFromJson(Map<String, dynamic> json) {
    var map = Map<String, List<UpdateProductInputDTO>>();
     if (json != null && json.isNotEmpty) {
       json.forEach((String key, dynamic value) {
         map[key] = UpdateProductInputDTO.listFromJson(value);
       });
     }
     return map;
  }
}

