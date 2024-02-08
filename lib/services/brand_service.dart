// import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:laptopzone_user/model/brand_model.dart';

class BrandServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<BrandModel>> fetchBrands() async {
    try {
      final snapshot = await _firestore
          .collection('admin_details')
          .doc('admin')
          .collection('brand')
          .get();
      

      List<BrandModel> brands =
          snapshot.docs.map((e) => BrandModel.fromJson(e.data())).toList();
      
      return brands;
    } catch (e) {
      // Handle error if needed
      return [];
    }
  }
}