package com.patates.webapi;

import com.patates.webapi.Repositories.Firebase.FirebaseConnection;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cache.annotation.EnableCaching;

import java.io.IOException;

@SpringBootApplication
@EnableCaching
public class JavaspringApplication {
  public static void main(String[] args) throws IOException {

    SpringApplication.run(JavaspringApplication.class, args);
    FirebaseConnection.FirebaseStartConnection();
  }
}
