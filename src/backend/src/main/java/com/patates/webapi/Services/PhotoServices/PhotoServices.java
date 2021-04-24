package com.patates.webapi.Services.PhotoServices;

import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;

public interface PhotoServices {
  String uploadImages(String imageName, MultipartFile imageFile, String folder) throws IOException;
}
