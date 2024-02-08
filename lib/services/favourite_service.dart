import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:laptopzone_user/model/favourite_model.dart';
import 'package:laptopzone_user/view/favourite_screen/favourite_screen.dart';

class FavouriteService {
  addFavourite({required FavModel product}) async {
    final favourite = FirebaseFirestore.instance
        .collection('users')
        .doc('favourites')
        .collection(currentEmail!)
        .doc(product.productName);
    final json = product.toJson();

    await favourite.set(json);

    Get.snackbar('Success', 'Added to favourite');
  }

  Future<bool> checkFav({required FavModel product}) async {
    final favourite = FirebaseFirestore.instance
        .collection('users')
        .doc('favourites')
        .collection(currentEmail!)
        .doc(product.productName);

    final snapshot = await favourite.get();
    return snapshot.exists;
  }

  removeFavourite({required FavModel product}) async {
    final favourite = FirebaseFirestore.instance
        .collection('users')
        .doc('favourites')
        .collection(currentEmail!)
        .doc(product.productName);

    await favourite.delete();
    if (Get.isSnackbarOpen) {
      Get.closeCurrentSnackbar();
    }
    Get.snackbar(
      'Success',
      'Product removed from favourites',
    );
  }
}
