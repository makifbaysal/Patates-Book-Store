import 'dart:io';

import 'package:app/enums/ServerState.dart';
import 'package:app/models/base_model.dart';
import 'package:app/utils/api.dart';
import 'package:http/http.dart';
import 'package:openapi/api.dart';

class ShippingProvider extends BaseModel {
  Future<String> updatePhotoShippingCompany(String companyId, File imageFile) async {
    setState(ServerState.Busy);
    try {
      var multipartFile = await MultipartFile.fromPath("file", imageFile.path);
      var response = await api.shippingCompany.updatePhotoShippingCompany(companyId, file: multipartFile);
      return response;
    } catch (e) {
      setState(ServerState.Error);
      return "Error";
    }
  }

  Future<ShippingCompanyDetailsOutputDTO> getShippingCompanyDetails(String companyId) async {
    setState(ServerState.Busy);
    try {
      var response = await api.shippingCompany.getShippingCompanyDetails(
        companyId: companyId,
      );
      setState(ServerState.Success);
      return response;
    } catch (e) {
      setState(ServerState.Error);
      return null;
    }
  }

  Future<String> addShippingCompany(String website, double price, String name, DateTime date, String contactNumber, File image) async {
    setState(ServerState.Busy);
    try {
      var multipartFile = await MultipartFile.fromPath("file", image.path);
      var response = await api.shippingCompany.addShippingCompany(website, price, name, date, contactNumber, file: multipartFile);
      setState(ServerState.Success);
      return response;
    } catch (e) {
      setState(ServerState.Error);
      return "Error";
    }
  }

  Future<List<ListingShippingCompaniesOutputDTO>> getShippingCompanies({String search}) async {
    try {
      var response = await api.shippingCompany.getShippingCompanies(search: search);
      return response;
    } catch (e) {
      return [];
    }
  }

  Future<String> deleteShippingCompany(String companyId) async {
    setState(ServerState.Busy);
    try {
      DeleteShippingCompanyInputDTO deleteShippingCompanyInputDTO = DeleteShippingCompanyInputDTO();
      deleteShippingCompanyInputDTO.id = companyId;
      var response = await api.shippingCompany.deleteShippingCompany(deleteShippingCompanyInputDTO);
      setState(ServerState.Success);
      return response;
    } catch (e) {
      setState(ServerState.Error);
      return "Error";
    }
  }

  Future<String> updateShippingCompany(String companyId, String name, double price, String website, String contactNumber, DateTime endDate) async {
    setState(ServerState.Busy);
    try {
      UpdateShippingCompanyInputDTO updateShippingCompanyInputDTO = UpdateShippingCompanyInputDTO();
      updateShippingCompanyInputDTO.id = companyId;
      updateShippingCompanyInputDTO.name = name;
      updateShippingCompanyInputDTO.price = price;
      updateShippingCompanyInputDTO.website = website;
      updateShippingCompanyInputDTO.contactNumber = contactNumber;
      updateShippingCompanyInputDTO.endDate = endDate;
      var response = await api.shippingCompany.updateShippingCompany(updateShippingCompanyInputDTO);
      setState(ServerState.Success);
      return response;
    } catch (e) {
      setState(ServerState.Error);
      return "Error";
    }
  }
}
