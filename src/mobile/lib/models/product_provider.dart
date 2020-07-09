import 'dart:io';

import 'package:app/enums/ServerState.dart';
import 'package:app/models/base_model.dart';
import 'package:app/utils/api.dart';
import 'package:http/http.dart';
import 'package:openapi/api.dart';

class ProductProvider extends BaseModel {
  List<String> comparedProducts = [];

  clearCompareProducts() {
    comparedProducts = [];
    notifyListeners();
  }

  Future<Map<String, int>> getCategories() async {
    setState(ServerState.Busy);
    try {
      var response = await api.products.categoriesCount();
      setState(ServerState.Success);
      return response;
    } catch (e) {
      setState(ServerState.Error);
      return null;
    }
  }

  Future<ProductListingReturnOutputDTO> getProducts(
      {int from,
      int size,
      int highestPage,
      int lowestPage,
      List<String> category,
      List<String> languages,
      int lowestPrice,
      int highestPrice,
      String sort,
      String search}) async {
    try {
      var response = await api.products.getProducts(
          from: from,
          size: size,
          highestPage: highestPage,
          lowestPage: lowestPage,
          category: category,
          languages: languages,
          lowestPrice: lowestPrice,
          highestPrice: highestPrice,
          sort: sort,
          search: search);
      return response;
    } catch (e) {
      return null;
    }
  }

  Future<void> addProduct(
    String description,
    double price,
    List<String> category,
    String name,
    String author,
    String language,
    int stock,
    int page,
    File imageFile,
  ) async {
    setState(ServerState.Busy);
    try {
      var multipartFile = await MultipartFile.fromPath("file", imageFile.path);
      var response = await api.products.addProduct(description, price, category, name, author, language, stock, page, file: multipartFile);
      if (response != "Error")
        setState(ServerState.Success);
      else
        setState(ServerState.Error);
    } catch (e) {
      setState(ServerState.Error);
    }
  }

  Future<ProductDetailOutputDTO> getProductDetail({String productId, String userId}) async {
    try {
      var response = await api.products.productDetails(productId: productId, userId: userId);
      // ignore: unrelated_type_equality_checks
      if (response != "Error") {
        return response;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<void> updateProduct(UpdateProductInputDTO updateProductInputDTO) async {
    setState(ServerState.Busy);
    try {
      var response = await api.products.updateProduct(updateProductInputDTO);
      if (response != "Error") {
        setState(ServerState.Success);
      } else {
        setState(ServerState.Error);
      }
    } catch (e) {
      setState(ServerState.Error);
    }
  }

  Future<void> updateProductImage(String productID, File file) async {
    setState(ServerState.Busy);
    try {
      var multipartFile = await MultipartFile.fromPath("file", file.path);
      var response = await api.products.updateProductImage(productID, file: multipartFile);
      if (response != "Error") {
        setState(ServerState.Success);
      } else {
        setState(ServerState.Error);
      }
    } catch (e) {
      setState(ServerState.Error);
    }
  }

  Future<void> deleteProduct(String productID) async {
    setState(ServerState.Busy);
    try {
      DeleteProductInputDTO dto = DeleteProductInputDTO();
      dto.id = productID;
      var response = await api.products.deleteProduct(dto);
      if (response != "Error") {
        setState(ServerState.Success);
      } else {
        setState(ServerState.Error);
      }
    } catch (e) {
      setState(ServerState.Error);
    }
  }

  Future<List<ProductListingOutputDTO>> getBestSellerTen() async {
    try {
      var response = await api.products.getBestSellerTen();
      return response;
    } catch (e) {
      return [];
    }
  }

  Future<List<ProductListingOutputDTO>> getWeeklyDealsTen() async {
    try {
      var response = await api.products.getWeeklyDealsTen();
      return response;
    } catch (e) {
      return [];
    }
  }

  Future<List<CommentOutputDTO>> getProductComments(String productID) async {
    try {
      var response = await api.products.getProductComments(productID);
      if (response != null) {
        return response;
      } else {
        return List();
      }
    } catch (e) {
      return List();
    }
  }

  Future<List<ProductListingOutputDTO>> getRelationalProducts(String productID) async {
    try {
      var response = await api.products.getRelationalProducts(productID);
      if (response != null) {
        return response;
      } else {
        return List();
      }
    } catch (e) {
      return List();
    }
  }
}
