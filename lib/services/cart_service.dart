// import 'dart:developer';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:laptopzone_user/model/cart_model.dart';
// import 'package:laptopzone_user/view/favourite_screen/favourite_screen.dart';

// class CartService {
//   CartService();
//   addToCart({required CartModel cartItem}) async {
//     try {
//       FirebaseFirestore.instance
//           .collection('users')
//           .doc('cart')
//           .collection(currentEmail!)
//           .doc(cartItem.productId)
//           .set(cartItem.toMap(), SetOptions(merge: true))
//           .then((value) {});
//     } on FirebaseException catch (e) {
//       log(e.message ?? '');
//     }
//   }

//   updateCartItem(
//       {required String productId, required int updateQty, required int price}) {
//     try {
//       FirebaseFirestore.instance
//           .collection('users')
//           .doc('cart')
//           .collection(currentEmail!)
//           .doc(productId)
//           .set({'quantity': updateQty, 'totalPrice': price},
//               SetOptions(merge: true));
//     } on FirebaseException catch (e) {
//       log(e.message.toString());
//     }
//   }

//   deleteCartItem({required String productId}) async {
//     await FirebaseFirestore.instance
//         .collection('users')
//         .doc('cart')
//         .collection(currentEmail!)
//         .doc(productId)
//         .delete();
//   }
// }
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:laptopzone_user/controller/total_controller.dart';
import 'package:laptopzone_user/model/cart_model.dart';

class CartService {
  final currentemail = FirebaseAuth.instance.currentUser!.email;
  TotalController totalController = Get.put(TotalController());

  addCart({required CartModel product}) async {
    final cart = FirebaseFirestore.instance
        .collection('users')
        .doc('cart')
        .collection(currentemail!)
        .doc(product.productName);

    final json = product.toJson();
    // totalController.addTotal(int.parse(product.discountPrice));

    await cart.set(json);
    Get.snackbar('Success', 'Product added to cart');
  }

  Future<bool> checkcart({required CartModel product}) async {
    final cart = FirebaseFirestore.instance
        .collection('users')
        .doc('cart')
        .collection(currentemail!)
        .doc(product.productName);

    final snapshot = await cart.get();
    return snapshot.exists;
  }

  removeCart({required CartModel product}) async {
    final cart = FirebaseFirestore.instance
        .collection('users')
        .doc('cart')
        .collection(currentemail!)
        .doc(product.productName);

    totalController.removeTotal(int.parse(product.discountPrice));

    await cart.delete();
    

    if (Get.isSnackbarOpen) {
      Get.closeCurrentSnackbar();
    }
    Get.snackbar('Success', 'Product removed from cart',
        animationDuration: const Duration(milliseconds: 100));
  }

  deleteWholeCart() async {
    final cartCollection = FirebaseFirestore.instance
        .collection('users')
        .doc('cart')
        .collection(currentemail!);

    final querySnapshot = await cartCollection.get();

    for (final doc in querySnapshot.docs) {
      await doc.reference.delete();
    }
  }
}
