import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laptopzone_user/services/profile_service.dart';

class ProfileController extends GetxController {
  RxBool isLoading = true.obs;
  RxBool isEditing = false.obs;
  RxString name = ''.obs;

  late TextEditingController nameController;

  final user = FirebaseAuth.instance.currentUser;

  @override
  void onInit() {
    super.onInit();
    nameController = TextEditingController();
    _loadProfileData();
  }

  void _loadProfileData() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('user_details')
        .doc(user!.uid)
        .get();

    if (snapshot.exists) {
      final data = snapshot.data();
      name.value = data?['name'] ?? 'Unknown';
      isLoading.value = false;
    }
  }

  void editProfile() async {
    isEditing.value = true;

    await ProfileService().editProfile(
      name: nameController.text,
    );

    isEditing.value = false;

    Get.snackbar('Edited', 'Successfully', backgroundColor: Colors.grey);
  }
}
