import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laptopzone_user/controller/cart_controller.dart';
import 'package:laptopzone_user/model/cart_model.dart';
import 'package:laptopzone_user/services/cart_service.dart';
import 'package:laptopzone_user/view/cart_screen/checkout_screen.dart';
import 'package:laptopzone_user/view/cart_screen/widgets/checkout_section.dart';

import '../../controller/total_controller.dart';

class CartScreen extends StatelessWidget {
  CartScreen({super.key});
  @override
  TotalController totalController = Get.put(TotalController());
  Widget build(BuildContext context) {
    int total = 0;
    final currentEmail = FirebaseAuth.instance.currentUser!.email;
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
      body: SingleChildScrollView(
          child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .doc('cart')
                  .collection(currentEmail!)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasData && snapshot.data!.docs.isEmpty) {
                  // Update the total value in the controller
                  totalController.total.value = 0;

                  return const Center(
                    child: Text('Cart is empty'),
                  );
                }
                totalController.priceList.clear();
                totalController.total.value = 0;
                List<CartModel> allCartModel = [];
                allCartModel.addAll(snapshot.data!.docs.map((e) =>
                    CartModel.fromJson(e.data() as Map<String, dynamic>)));

                total = 0;
                for (var x in snapshot.data!.docs) {
                  total = total + int.parse(x['price'].replaceAll(',', ''));
                }
                return Column(children: [
                  const SizedBox(
                    height: 50,
                  ),
                  Column(children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Subtotal',
                          style: TextStyle(
                            fontSize: 25,
                          ),
                        ),
                        SizedBox(
                          width: width * 0.07,
                        ),
                        Text('₹$total',
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold))
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    const Text(
                        "Your order is eligible for FREE Delivery. Select this \n option at checkout.",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold)),
                    const SizedBox(
                      height: 8,
                    ),
                    // loginButton(width * 0.99, 'Proceed to Buy', context),
                    SizedBox(
                        width: width * 0.5,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) {
                                return CheckoutSection(
                                  totalList: totalController.priceList,
                                  currentEmail: currentEmail,
                                );
                              },
                            ));
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Colors
                                    .red), // Set the background color to black
                          ),
                          child: Text(
                            'Proceed To Buy',
                            style: const TextStyle(
                                color: Colors
                                    .white), // Set the text color to white
                          ),
                        )),
                    const SizedBox(
                      height: 20,
                    ),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) => InkWell(
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: double.infinity,
                            height: height * 0.20,
                            decoration: BoxDecoration(
                                border: Border.all(width: .7),
                                borderRadius: BorderRadius.circular(10)),
                            // color: Colors.grey[500],
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(children: [
                                Container(
                                  width: 150,
                                  height: height * 0.2,
                                  decoration: BoxDecoration(
                                    // border: Border.all(),
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            '${allCartModel[index].productImg1}'),
                                        fit: BoxFit.cover),
                                  ),
                                ),
                                Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(
                                          height: 13,
                                        ),
                                        Container(
                                          width: 150,
                                          child: Text(
                                            '${allCartModel[index].productName}',
                                            style: const TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              '₹${allCartModel[index].discountPrice}',
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            IconButton(
                                                onPressed: () async {
                                                  await CartService()
                                                      .removeCart(
                                                    product: CartModel(
                                                      productName:
                                                          allCartModel[index]
                                                              .productName,
                                                      productDes:
                                                          allCartModel[index]
                                                              .productDes,
                                                      discountPrice:
                                                          allCartModel[index]
                                                              .discountPrice,
                                                      productImg1:
                                                          allCartModel[index]
                                                              .productImg1,
                                                      productImg2:
                                                          allCartModel[index]
                                                              .productImg2,
                                                      productImg3:
                                                          allCartModel[index]
                                                              .productImg3,
                                                      currentUser:
                                                          allCartModel[index]
                                                              .currentUser,
                                                    ),
                                                  );
                                                },
                                                icon: const Icon(
                                                  Icons.delete,
                                                  color: Colors.red,
                                                )),
                                          ],
                                        ),
                                        // Container(
                                        //   width: width * 0.4,
                                        //   height: height * 0.047,
                                        //   // color: Colors.black,
                                        //   decoration: BoxDecoration(
                                        //     border: Border.all(
                                        //       color: Colors
                                        //           .black, // Set border color
                                        //       width: 1.0, // Set border width
                                        //     ),
                                        //     borderRadius: BorderRadius.circular(
                                        //         8.0), // Set border radius
                                        //   ),
                                        //   child: Row(children: [
                                        //     IconButton(
                                        //         onPressed: () {},
                                        //         icon: const Icon(Icons.remove)),
                                        //     Container(
                                        //       width: 55,
                                        //       height: 70,
                                        //       color: Colors.white,
                                        //       child:
                                        //           const Center(child: Text('1')),
                                        //     ),
                                        //     // Text('1'),
                                        //     IconButton(
                                        //         onPressed: () {},
                                        //         icon: const Icon(Icons.add)),
                                        //   ]),
                                        // )
                                      ],
                                    ),
                                  ),
                                )
                              ]),
                            ),
                          ),
                        ),
                      ),
                      separatorBuilder: (context, index) => SizedBox(
                        height: 15,
                      ),
                      itemCount: snapshot.data!.docs.length,
                    )
                  ]),
                  const SizedBox(
                    height: 20,
                  ),
                ]);
              })),
    );
  }
}

// SizedBox loginButton(double width, String name, BuildContext context) {
//   return SizedBox(
//       width: width * 0.5,
//       child: ElevatedButton(
//         onPressed: () {
//           Navigator.of(context).push(MaterialPageRoute(
//             builder: (context) {
//               return  CheckoutScreen();
//             },
//           ));
//         },
//         style: ButtonStyle(
//           backgroundColor: MaterialStateProperty.all<Color>(
//               Colors.red), // Set the background color to black
//         ),
//         child: Text(
//           name,
//           style: const TextStyle(
//               color: Colors.white), // Set the text color to white
//         ),
//       ));
// }
