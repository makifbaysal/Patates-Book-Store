package com.patates.webapi.Services.PhotoServices;

import com.google.auth.oauth2.GoogleCredentials;
import com.google.cloud.storage.BlobId;
import com.google.cloud.storage.BlobInfo;
import com.google.cloud.storage.Storage;
import com.google.cloud.storage.StorageOptions;
import org.apache.http.HttpEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;
import org.json.JSONObject;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.FileInputStream;
import java.io.IOException;

@Service
public class FirebasePhotoService implements PhotoServices {

  public String uploadImages(String imageName, MultipartFile imageFile, String folder)
      throws IOException {

    String bucketName = "project-nameappspot.com";

    String originalFile = imageFile.getOriginalFilename();

    String fileType = originalFile.split("\\.")[1];

    imageName = imageName + "." + fileType;

    imageName = imageName.replace("?", "");

    StorageOptions storageOptions =
        StorageOptions.newBuilder()
            .setProjectId("project-name")
            .setCredentials(GoogleCredentials.fromStream(new FileInputStream("firebase.json")))
            .build();

    Storage storage = storageOptions.getService();
    BlobId blobId = BlobId.of(bucketName, folder + "/" + imageName);
    BlobInfo blobInfo = BlobInfo.newBuilder(blobId).build();

    storage.create(blobInfo, imageFile.getBytes());

    String url =
        "https://firebasestorage.googleapis.com/v0/b/project-name.appspot.com/o/"
            + folder
            + "%2F"
            + imageName;
    HttpGet request = new HttpGet(url);

    try (CloseableHttpClient httpClient = HttpClients.createDefault();
        CloseableHttpResponse response = httpClient.execute(request)) {

      HttpEntity entity = response.getEntity();

      if (entity != null) {
        String result = EntityUtils.toString(entity);
        JSONObject jsonObject = new JSONObject(result);
        return url + "?alt=media&token=" + jsonObject.get("downloadTokens");
      }

    } catch (Exception e) {
      e.printStackTrace();
      return "Error";
    }
    return "Error";
  }
}
