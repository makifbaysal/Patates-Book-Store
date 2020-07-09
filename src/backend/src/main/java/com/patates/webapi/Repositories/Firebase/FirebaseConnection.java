package com.patates.webapi.Repositories.Firebase;

import com.google.auth.oauth2.GoogleCredentials;
import com.google.cloud.firestore.Firestore;
import com.google.cloud.storage.Bucket;
import com.google.firebase.FirebaseApp;
import com.google.firebase.FirebaseOptions;
import com.google.firebase.cloud.FirestoreClient;
import com.google.firebase.cloud.StorageClient;

import java.io.FileInputStream;
import java.io.IOException;

public class FirebaseConnection {

    public static Firestore db;
    public static Bucket bucket;

    public static void FirebaseStartConnection() throws IOException {
        FileInputStream serviceAccount = new FileInputStream("firebase.json");

        FirebaseOptions options = new FirebaseOptions.Builder()
                .setCredentials(GoogleCredentials.fromStream(serviceAccount))
                .setDatabaseUrl("https://project-name.firebaseio.com")
                .setStorageBucket("project-name.appspot.com")
                .build();


        FirebaseApp.initializeApp(options);

        db = FirestoreClient.getFirestore();
        bucket = StorageClient.getInstance().bucket();

    }


}
