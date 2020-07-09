package com.patates.webapi.Controllers;


import com.patates.webapi.Models.ShippingCompany.DeleteShippingCompanyInputDTO;
import com.patates.webapi.Models.ShippingCompany.ListingShippingCompaniesOutputDTO;
import com.patates.webapi.Models.ShippingCompany.ShippingCompanyDetailsOutputDTO;
import com.patates.webapi.Models.ShippingCompany.UpdateShippingCompanyInputDTO;
import com.patates.webapi.Services.ShippingCompanyServices.ShippingCompanyService;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.Date;
import java.util.List;
import java.util.concurrent.ExecutionException;

@RestController
@RequestMapping("/api/shippingCompany")
public class ShippingCompanyController {
    ShippingCompanyService shippingCompanyService = new ShippingCompanyService();

    @RequestMapping(consumes = MediaType.MULTIPART_FORM_DATA_VALUE, value = "/addShippingCompany", method = RequestMethod.POST)
    @CacheEvict(value = "getShippingCompanies", allEntries = true)
    public String addShippingCompany(@RequestParam("file") MultipartFile file, @RequestParam String website, @RequestParam double price, @RequestParam String name, @RequestParam("date") @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) Date endDate, @RequestParam String contactNumber) throws IOException {
        return shippingCompanyService.addShippingCompanies(file, website, price, name, endDate, contactNumber);
    }

    @RequestMapping(value = "/deleteShippingCompany", method = RequestMethod.POST)
    @CacheEvict(value = "getShippingCompanies", allEntries = true)
    public String deleteShippingCompany(@RequestBody DeleteShippingCompanyInputDTO id) {
        return shippingCompanyService.deleteShippingCompany(id);
    }

    @RequestMapping(value = "/updateShippingCompany", method = RequestMethod.POST)
    @CacheEvict(value = "getShippingCompanies", allEntries = true)
    public String updateShippingCompany(@RequestBody UpdateShippingCompanyInputDTO company) {
        return shippingCompanyService.updateShippingCompany(company);
    }

    @RequestMapping(consumes = MediaType.MULTIPART_FORM_DATA_VALUE, value = "/updatePhotoShippingCompany", method = RequestMethod.POST)
    @CacheEvict(value = "getShippingCompanies", allEntries = true)
    public String updatePhotoShippingCompany(@RequestParam("file") MultipartFile file, @RequestParam String companyId) throws InterruptedException, ExecutionException, IOException {
        return shippingCompanyService.updatePhotoShippingCompany(file, companyId);
    }

    @GetMapping(value = "/getShippingCompanies")
    @Cacheable("getShippingCompanies")
    public List<ListingShippingCompaniesOutputDTO> getShippingCompanies(@RequestParam(value = "search", defaultValue = "") String search) throws InterruptedException, ExecutionException {
        return shippingCompanyService.getShippingCompanies(search);
    }

    @GetMapping(value = "/getShippingCompanyDetails")
    public ShippingCompanyDetailsOutputDTO getShippingCompanyDetails(@RequestParam(value = "companyId", defaultValue = "") String companyId) throws ExecutionException, InterruptedException {
        return shippingCompanyService.getShippingCompanyDetails(companyId);
    }

}
