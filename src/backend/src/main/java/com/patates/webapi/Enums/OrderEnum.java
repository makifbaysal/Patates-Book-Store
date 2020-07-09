package com.patates.webapi.Enums;

public enum OrderEnum {
    WaitingForApproval(-1), Shipped(1), Refund(0), Denied(2), Cancelled(3), Accepted(4);

    private final int value;

    OrderEnum(int value) {
        this.value = value;
    }

    public int getValue() {
        return this.value;
    }


}
