package com.patates.webapi.Services.PaymentServices;

import java.util.concurrent.ExecutionException;

public interface PaymentServices {
    boolean makePayment(String cartId, double amountPaid) throws ExecutionException, InterruptedException;

    String refund(String cartId, double amountRefund) throws ExecutionException, InterruptedException;
}
