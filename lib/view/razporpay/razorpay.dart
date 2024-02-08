import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laptopzone_user/services/cart_service.dart';
import 'package:laptopzone_user/services/my_order_service.dart';
import 'package:laptopzone_user/view/success/success.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class Razor {
  final orderList;
  Razor({required this.orderList});
  Razorpay razorpay = Razorpay();
  var sum = 00.00;

  totalamount() {
    for (var element in orderList) {
      sum = sum + int.parse(element.discountPrice);
    }
  }

  pay() {
    totalamount();
    var options = {
      'key': 'rzp_test_BYlVG7aKgyUQ6V',
      'amount': sum * 10,
      'name': 'Laptopzone',
      'description': sum,
      'retry': {'enabled': true, 'max_count': 1},
      'send_sms_hash': true,
      'prefill': {
        'contact': '7736187753',
        'email': 'mohammedathifms.7@gmail.com'
      },
      'external': {
        'wallets': ['paytm']
      }
    };
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentErrorResponse);
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccessResponse);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWalletSelected);
    razorpay.open(options);
  }

  void handlePaymentErrorResponse(
      PaymentFailureResponse response, BuildContext context) {
    Get.dialog(const AlertDialog(
      content: Text('payment failed'),
    ));
  }

  void handlePaymentSuccessResponse(
    PaymentSuccessResponse response,
  ) async {
    log(response.toString());
    for (var order in orderList) {
      await MyOrderService().addOrder(order);
    }
    log('success');
    await CartService().deleteWholeCart();
    Get.to(const Success());
  }

  void handleExternalWalletSelected(
      ExternalWalletResponse response, BuildContext context) async {
    Get.dialog(const AlertDialog(
      content: Text('selected wallet'),
    ));
  }
}
