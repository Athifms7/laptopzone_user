import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:laptopzone_user/model/order_model.dart';

class MyOrderService {
  final currentemail = FirebaseAuth.instance.currentUser!.email;

  addOrder(OrderModel order) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc('myorder')
          .collection("allOrders")
          .doc(order.productName)
          .set(order.toJson());
    } catch (e) {
      log('Error adding order: $e');
    }
  }
  
}
