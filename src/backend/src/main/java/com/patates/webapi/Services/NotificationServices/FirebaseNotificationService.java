package com.patates.webapi.Services.NotificationServices;

import com.google.firebase.messaging.FirebaseMessaging;
import com.google.firebase.messaging.FirebaseMessagingException;
import com.google.firebase.messaging.Message;
import com.google.firebase.messaging.Notification;

public class FirebaseNotificationService implements NotificationService {

    public String sendNotifications(String header, String body, String topic) throws FirebaseMessagingException {

        Message message = Message.builder().setNotification(new Notification(header, body))
                .setTopic(topic)
                .build();

        String response = FirebaseMessaging.getInstance().send(message);
        return "Successfully sent message: " + response;
    }
}
