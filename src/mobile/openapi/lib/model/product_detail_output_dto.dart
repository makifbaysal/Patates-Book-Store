part of openapi.api;

class ProductDetailOutputDTO {
  
  String description;
  
  List<String> category = [];
  
  double price;
  
  String name;
  
  String author;
  
  String language;
  
  String imageUrl;
  
  int stock;
  
  int page;
  
  bool bookmark;
  
  double star;
  
  int commentCount;
  ProductDetailOutputDTO();

  @override
  String toString() {
    return 'ProductDetailOutputDTO[description=$description, category=$category, price=$price, name=$name, author=$author, language=$language, imageUrl=$imageUrl, stock=$stock, page=$page, bookmark=$bookmark, star=$star, commentCount=$commentCount, ]';
  }

  ProductDetailOutputDTO.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
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
    imageUrl = json['imageUrl'];
    stock = json['stock'];
    page = json['page'];
    bookmark = json['bookmark'];
    star = (json['star'] == null) ?
      null :
      json['star'].toDouble();
    commentCount = json['commentCount'];
  }

  Map<String, dynamic> toJson() {
    Map <String, dynamic> json = {};
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
    if (imageUrl != null)
      json['imageUrl'] = imageUrl;
    if (stock != null)
      json['stock'] = stock;
    if (page != null)
      json['page'] = page;
    if (bookmark != null)
      json['bookmark'] = bookmark;
    if (star != null)
      json['star'] = star;
    if (commentCount != null)
      json['commentCount'] = commentCount;
    return json;
  }

  static List<ProductDetailOutputDTO> listFromJson(List<dynamic> json) {
    return json == null ? List<ProductDetailOutputDTO>() : json.map((value) => ProductDetailOutputDTO.fromJson(value)).toList();
  }

  static Map<String, ProductDetailOutputDTO> mapFromJson(Map<String, dynamic> json) {
    var map = Map<String, ProductDetailOutputDTO>();
    if (json != null && json.isNotEmpty) {
      json.forEach((String key, dynamic value) => map[key] = ProductDetailOutputDTO.fromJson(value));
    }
    return map;
  }

  // maps a json object with a list of ProductDetailOutputDTO-objects as value to a dart map
  static Map<String, List<ProductDetailOutputDTO>> mapListFromJson(Map<String, dynamic> json) {
    var map = Map<String, List<ProductDetailOutputDTO>>();
     if (json != null && json.isNotEmpty) {
       json.forEach((String key, dynamic value) {
         map[key] = ProductDetailOutputDTO.listFromJson(value);
       });
     }
     return map;
  }
}

