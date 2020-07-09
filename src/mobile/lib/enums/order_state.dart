enum OrderState { WaitingForApproval, Shipped, Refund, Denied, Cancelled, Accepted }

class OrderStateHelper {
  static OrderState getEnum(int state) {
    switch (state) {
      case -1:
        return OrderState.WaitingForApproval;
      case 0:
        return OrderState.Refund;
      case 1:
        return OrderState.Shipped;
      case 2:
        return OrderState.Denied;
      case 3:
        return OrderState.Cancelled;
      case 4:
        return OrderState.Accepted;
      default:
        return OrderState.WaitingForApproval;
    }
  }
}
