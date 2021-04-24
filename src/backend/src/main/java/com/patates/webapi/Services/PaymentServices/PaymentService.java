package com.patates.webapi.Services.PaymentServices;

import com.patates.webapi.Repositories.Firebase.PaymentRepository;
import org.springframework.stereotype.Service;

import java.util.concurrent.ExecutionException;

@Service
public class PaymentService implements PaymentServices {
  private final PaymentRepository paymentRepository;

  public PaymentService(PaymentRepository paymentRepository) {
    this.paymentRepository = paymentRepository;
  }

  public boolean makePayment(String cartId, double amountPaid)
      throws ExecutionException, InterruptedException {
    return paymentRepository.makePayment(cartId, amountPaid);
  }

  public String refund(String cartId, double amountRefund)
      throws ExecutionException, InterruptedException {
    return paymentRepository.refund(cartId, amountRefund);
  }
}
