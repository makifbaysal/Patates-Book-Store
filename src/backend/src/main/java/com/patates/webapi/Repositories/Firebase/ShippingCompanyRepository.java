package com.patates.webapi.Repositories.Firebase;

import com.google.api.core.ApiFuture;
import com.google.cloud.firestore.DocumentReference;
import com.google.cloud.firestore.DocumentSnapshot;
import com.google.cloud.firestore.QueryDocumentSnapshot;
import com.patates.webapi.Models.ShippingCompany.ListingShippingCompaniesOutputDTO;
import com.patates.webapi.Models.ShippingCompany.ShippingCompanyDetailsOutputDTO;
import com.patates.webapi.Models.ShippingCompany.UpdateShippingCompanyInputDTO;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.*;
import java.util.concurrent.ExecutionException;

public class ShippingCompanyRepository extends FirebaseConnection {


    public String getFileName(String id) throws ExecutionException, InterruptedException {
        ApiFuture<DocumentSnapshot> queryProduct = db.collection("shippingCompanies").document(id).get();
        DocumentSnapshot documentSnapshot = queryProduct.get();
        return documentSnapshot.getString("name").toLowerCase().replace(" ", "_");
    }


    public String addCompany(MultipartFile file, String name, String website, double price, Date endDate, String contactNumber, String photoLink) throws IOException {

        DocumentReference docRef = db.collection("shippingCompanies").document();

        Map<String, Object> data = new HashMap<>();

        data.put("name", name);
        data.put("image-url", photoLink);
        data.put("website", website);
        data.put("price", price);
        data.put("endDate", endDate);
        data.put("contactNumber", contactNumber);
        data.put("state", true);

        docRef.set(data);

        return docRef.getId();
    }

    public String deleteCompany(String id) {
        DocumentReference docRef = db.collection("shippingCompanies").document(id);

        docRef.update("state", false);

        return "Success";
    }

    public String updateCompany(UpdateShippingCompanyInputDTO company) {


        DocumentReference docRef = db.collection("shippingCompanies").document(company.getId());

        Map<String, Object> data = new HashMap<>();
        data.put("name", company.getName());
        data.put("website", company.getWebsite());
        data.put("price", company.getPrice());
        data.put("endDate", company.getEndDate());
        data.put("contactNumber", company.getContactNumber());
        data.put("state", true);

        docRef.update(data);


        return "Success";
    }

    public String updatePhotoCompany(String photoLink, String companyId) {

        DocumentReference docRef = db.collection("shippingCompanies").document(companyId);
        Map<String, Object> data = new HashMap<>();
        data.put("image-url", photoLink);
        docRef.update(data);

        return "Success";
    }

    public List<ListingShippingCompaniesOutputDTO> getShippingCompanies(String search) throws ExecutionException, InterruptedException {
        ArrayList<ListingShippingCompaniesOutputDTO> listOfShippingCompanies = new ArrayList();
        List<QueryDocumentSnapshot> documents;
        if (search.equals("")) {
            documents = db.collection("shippingCompanies").whereEqualTo("state", true).get().get().getDocuments();
        } else {
            documents = db.collection("shippingCompanies").whereEqualTo("state", true).whereEqualTo("name", search).get().get().getDocuments();
        }


        for (QueryDocumentSnapshot document : documents) {
            listOfShippingCompanies.add(new ListingShippingCompaniesOutputDTO(document.getId(), document.getString("image-url"), document.getString("name"), document.getString("contactNumber"), document.getDate("endDate"), document.getDouble("price")));
        }

        return listOfShippingCompanies;
    }

    public ShippingCompanyDetailsOutputDTO getShippingCompanyDetails(String companyId) throws ExecutionException, InterruptedException {
        DocumentSnapshot document = db.collection("shippingCompanies").document(companyId).get().get();
        return new ShippingCompanyDetailsOutputDTO(document.getId(), document.getString("image-url"), document.getString("name"),
                document.getDouble("price"), document.getString("website"), document.getDate("endDate"), document.getString("contactNumber"));

    }

}
