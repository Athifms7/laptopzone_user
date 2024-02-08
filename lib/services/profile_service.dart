import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileService {
  final user = FirebaseAuth.instance.currentUser;

  editProfile({required String name}) async {
    await FirebaseFirestore.instance
        .collection('user_details')
        .doc(user!.uid)
        .update({
      'name': name,
    });
    // Navigator.of(context).pop();
  }
}
