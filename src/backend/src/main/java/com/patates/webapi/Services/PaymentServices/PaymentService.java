package com.patates.webapi.Services.PaymentServices;

import com.patates.webapi.Repositories.Firebase.PaymentRepository;

import java.util.concurrent.ExecutionException;

public class PaymentService implements PaymentServices {
    PaymentRepository paymentRepository = new PaymentRepository();

    public boolean makePayment(String cartId, double amountPaid) throws ExecutionException, InterruptedException {
        return paymentRepository.makePayment(cartId, amountPaid);
    }

    public String refund(String cartId, double amountRefund) throws ExecutionException, InterruptedException {
        return paymentRepository.refund(cartId, amountRefund);
    }

}
