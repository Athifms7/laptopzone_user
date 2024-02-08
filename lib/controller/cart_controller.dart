// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// // import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:laptopzone_user/model/cart_model.dart';
// import 'package:laptopzone_user/services/cart_service.dart';
// import 'package:laptopzone_user/view/favourite_screen/favourite_screen.dart';

// class CartController extends GetxController {
//   List<CartModel> cartList = [];
//   int totalCartPrice = 0;

//   getCartList() async {
//     List data = await FirebaseFirestore.instance
//         .collection('users')
//         .doc('cart')
//         .collection(currentEmail!)
//         .get()
//         .then((value) => value.docs);

//     totalCartPrice = 0;

//     cartList.clear();
//     for (var element in data) {
//       CartModel cartItem = CartModel.fromData(data: element);
//       totalCartPrice += (cartItem.price! * cartItem.quantity!);
//       cartList.add(cartItem);
//     }
//     update();
//   }

//   productQtyInc({required int index, required BuildContext context}) {
//     CartModel data = cartList[index];
//     data.quantity = data.quantity! + 1;
//     data.totalPrice = data.totalPrice! + data.price!;
//     totalCartPrice += data.price!;
//     update();
//     CartService().updateCartItem(
//         productId: data.productId!,
//         updateQty: data.quantity!,
//         price: data.price!);
//   }

//   productDelete({required int index}) {
//     CartModel data = cartList[index];
//     CartService().deleteCartItem(productId: data.productId!);
//     totalCartPrice -= cartList[index].totalPrice!;
//     cartList.removeAt(index);

//     update();
//   }

//   productQtyDec({required int index, required BuildContext context}) {
//     CartModel data = cartList[index];
//     if (data.quantity! > 1) {
//       data.quantity = data.quantity! - 1;
//       data.totalPrice = data.totalPrice! - data.price!;
//       totalCartPrice -= data.price!;
//       update();
//       CartService().updateCartItem(
//           productId: data.productId!,
//           updateQty: data.quantity!,
//           price: data.price!);
//     }
//   }
// }
