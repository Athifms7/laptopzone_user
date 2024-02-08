import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laptopzone_user/model/order_model.dart';
import 'package:laptopzone_user/view/profile_screen/your_orders/order_details.dart';
import 'package:firebase_auth/firebase_auth.dart';

class YourOrders extends StatelessWidget {
  const YourOrders({super.key});

  @override
  Widget build(BuildContext context) {
    final currentemail = FirebaseAuth.instance.currentUser!.email;
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
              .collection('users')
              .doc('myorder')
              .collection('allOrders')
              .where('user', isEqualTo: currentemail)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }
            return GridView.builder(
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.9,
                    // crossAxisSpacing: 5,
                    mainAxisSpacing: 2),
                // scrollDirection: Axis.horizontal,

                itemBuilder: (context, index) {
                  List<OrderModel> allOrderModel = [];
                  allOrderModel.addAll(snapshot.data!.docs
                      .map((e) => OrderModel.fromJson(e.data())));
                  return Column(children: [
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.to(OrderDetails(
                                order: allOrderModel[index],
                              ));
                            },
                            child: Container(
                              width: 185,
                              height: 200,
                              decoration: BoxDecoration(
                                  border: Border.all(width: .7),
                                  borderRadius: BorderRadius.circular(10)),

                              // color: Colors.white,
                              child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Column(children: [
                                    Stack(
                                      children: [
                                        Container(
                                          width: 130,
                                          height: 90,
                                          decoration: BoxDecoration(
                                            // border: Border.all(),
                                            image: DecorationImage(
                                                image: NetworkImage(
                                                    allOrderModel[index]
                                                        .productImg1),
                                                fit: BoxFit.cover),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: height * 0.01,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8),
                                      child: Text(
                                        allOrderModel[index].productName,
                                        style: const TextStyle(
                                            fontSize: 19,
                                            fontWeight: FontWeight.bold),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    SizedBox(
                                      height: height * 0.01,
                                    ),
                                    const Text('Order Status',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold)),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                            allOrderModel[index].deliveryStatus,
                                            style: const TextStyle(
                                                fontSize: 22,
                                                fontWeight: FontWeight.bold)),
                                      ],
                                    )
                                  ])),
                            ),
                          )
                        ],
                      ),
                    )
                  ]);
                },
                // separatorBuilder: (context, index) => kwidth5,
                itemCount: snapshot.data!.docs.length);
          }),
    );
  }
}
