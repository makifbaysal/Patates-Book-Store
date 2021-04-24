package com.patates.webapi.Repositories.Firebase;

import com.google.cloud.firestore.DocumentReference;
import com.google.cloud.firestore.DocumentSnapshot;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.ExecutionException;

@Repository
public class PaymentRepository extends FirebaseConnection {
  public boolean makePayment(String cartId, double amountPaid)
      throws ExecutionException, InterruptedException {
    DocumentSnapshot creditCart = db.collection("creditCarts").document(cartId).get().get();

    if (creditCart.getDouble("balance") < amountPaid) {
      return false;
    }

    Map<String, Object> data = new HashMap<>();
    data.put("balance", creditCart.getDouble("balance") - amountPaid);
    creditCart.getReference().update(data);

    return true;
  }

  public String refund(String cartId, double amountRefund)
      throws ExecutionException, InterruptedException {
    DocumentReference cartReference = db.collection("creditCarts").document(cartId);

    Map<String, Object> data = new HashMap<>();
    data.put("balance", cartReference.get().get().getDouble("balance") + amountRefund);
    cartReference.update(data);
    return "Success";
  }
}
