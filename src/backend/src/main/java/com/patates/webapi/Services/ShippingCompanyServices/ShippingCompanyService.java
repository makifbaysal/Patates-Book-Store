package com.patates.webapi.Services.ShippingCompanyServices;

import com.patates.webapi.Models.ShippingCompany.DeleteShippingCompanyInputDTO;
import com.patates.webapi.Models.ShippingCompany.ListingShippingCompaniesOutputDTO;
import com.patates.webapi.Models.ShippingCompany.ShippingCompanyDetailsOutputDTO;
import com.patates.webapi.Models.ShippingCompany.UpdateShippingCompanyInputDTO;
import com.patates.webapi.Repositories.Firebase.ShippingCompanyRepository;
import com.patates.webapi.Services.PhotoServices.PhotoServices;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.Date;
import java.util.List;
import java.util.concurrent.ExecutionException;

@Service
public class ShippingCompanyService {
  private final ShippingCompanyRepository shippingCompanyRepository;
  private final PhotoServices photoServices;

  public ShippingCompanyService(
      ShippingCompanyRepository shippingCompanyRepository, PhotoServices photoServices) {
    this.shippingCompanyRepository = shippingCompanyRepository;
    this.photoServices = photoServices;
  }

  public String addShippingCompanies(
      MultipartFile file,
      String website,
      double price,
      String name,
      Date endDate,
      String contactNumber)
      throws IOException {
    String photoLink =
        photoServices.uploadImages(name.toLowerCase().replace(" ", "_"), file, "shippingCompanies");
    return shippingCompanyRepository.addCompany(
        file, name, website, price, endDate, contactNumber, photoLink);
  }

  public String deleteShippingCompany(DeleteShippingCompanyInputDTO id) {
    return shippingCompanyRepository.deleteCompany(id.getId());
  }

  public String updateShippingCompany(UpdateShippingCompanyInputDTO company) {
    return shippingCompanyRepository.updateCompany(company);
  }

  public String updatePhotoShippingCompany(MultipartFile file, String companyId)
      throws InterruptedException, ExecutionException, IOException {
    String fileName = shippingCompanyRepository.getFileName(companyId);
    String photoLink = photoServices.uploadImages(fileName, file, "shippingCompanies");
    return shippingCompanyRepository.updatePhotoCompany(photoLink, companyId);
  }

  public List<ListingShippingCompaniesOutputDTO> getShippingCompanies(String search)
      throws InterruptedException, ExecutionException {
    return shippingCompanyRepository.getShippingCompanies(search);
  }

  public ShippingCompanyDetailsOutputDTO getShippingCompanyDetails(String companyId)
      throws ExecutionException, InterruptedException {
    return shippingCompanyRepository.getShippingCompanyDetails(companyId);
  }
}
