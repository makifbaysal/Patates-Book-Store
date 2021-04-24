package com.patates.webapi.Services.NotificationServices;

import com.google.firebase.messaging.FirebaseMessagingException;

import java.io.IOException;
import java.util.concurrent.ExecutionException;

public interface NotificationService {
  String sendNotifications(String header, String body, String topic)
      throws IOException, FirebaseMessagingException, ExecutionException, InterruptedException;
}
