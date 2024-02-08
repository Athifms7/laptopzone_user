import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laptopzone_user/services/profile_service.dart';
import 'package:laptopzone_user/view/profile_screen/your_orders/your_orders.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late TextEditingController nameController;
  final user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        elevation: 10,
        toolbarHeight: height * 0.10,
        title: Center(
          child: Image.asset(
            'assets/images/laptopzone-high-resolution-logo-transparent.png',
            width: width * 0.500,
          ),
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('user_details')
            .doc(user!.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return const CircularProgressIndicator();
          }

          final data = snapshot.data!.data();
          final name = data?['name'] ?? 'Unknown';

          // Only update the text when the controller is not being edited
          if (!nameController.text.isNotEmpty) {
            nameController.text = name;
          }

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                  width: width * 0.95,
                  height: height * 0.20,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Text(
                              "Profile",
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Spacer(),
                            IconButton(
                              onPressed: () {
                                showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  builder: (BuildContext context) {
                                    return SingleChildScrollView(
                                      child: Container(
                                        color: Colors.grey[300],
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.5,
                                        child: Column(
                                          children: [
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            const Text(
                                              'Edit Profile',
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Column(
                                              children: [
                                                SizedBox(
                                                  width: 250,
                                                  height: 100,
                                                  child: TextFormField(
                                                    controller: nameController,
                                                    decoration: InputDecoration(
                                                      filled: true,
                                                      fillColor: Colors.white,
                                                      labelStyle:
                                                          const TextStyle(
                                                        color: Colors.black,
                                                      ),
                                                      labelText: 'Name',
                                                      border:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: width * 0.5,
                                                  child: ElevatedButton(
                                                    onPressed: () async {
                                                      await ProfileService()
                                                          .editProfile(
                                                        name:
                                                            nameController.text,
                                                      );
                                                      Navigator.of(context)
                                                          .pop();
                                                      Get.snackbar('Edited',
                                                          'Successfully',
                                                          backgroundColor:
                                                              Colors.grey);
                                                    },
                                                   
                                                    style: ButtonStyle(
                                                      backgroundColor:
                                                          MaterialStateProperty
                                                              .all<Color>(
                                                                  Colors.red),
                                                    ),
                                                     child:const Text(
                                                      'Edit',
                                                      style:  TextStyle(
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                              icon: const Icon(Icons.edit),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Container(
                            height: 1.0,
                            width: 200.0,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Name : $name',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Email : ${data?['email'] ?? 'Unknown'}',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) {
                        return const YourOrders();
                      },
                    ));
                  },
                  child: Container(
                    width: width * 0.95,
                    height: height * 0.10,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Your Orders',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) {
                                  return const YourOrders();
                                },
                              ));
                            },
                            icon: const Icon(Icons.navigate_next),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
