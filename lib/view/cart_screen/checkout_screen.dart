// import 'package:flutter/material.dart';

// class CheckoutScreen extends StatelessWidget {
//   const CheckoutScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final height = MediaQuery.of(context).size.height;
//     final width = MediaQuery.of(context).size.width;
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 10,
//         toolbarHeight: height * 0.10, title:const Text('Checkout')),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.only(left: 18, right: 18),
//           child: Column(
//             children: [
//              const SizedBox(
//                 height: 10,
//               ),
//              const Text(
//                 'Shipping Address',
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//               ),
//              const SizedBox(
//                 height: 10,
//               ),
//               GestureDetector(
//                 onTap: () {
//                   showModalBottomSheet(
//                     // enableDrag: true,
//                     context: context,
//                     isScrollControlled:
//                         true, // Set to true to allow the content to be taller than the screen
//                     builder: (BuildContext context) {
//                       return SingleChildScrollView(
//                         child: Container(
//                           color: Colors.grey[300],
//                           height: MediaQuery.of(context).size.height *
//                               0.8, // Set the desired height
//                           child: Column(
//                             children: [
//                            const   SizedBox(
//                                 height: 10,
//                               ),
//                            const   Text(
//                                 'Add Address',
//                                 style: TextStyle(
//                                     fontSize: 20, fontWeight: FontWeight.bold),
//                               ),
//                             const  SizedBox(
//                                 height: 10,
//                               ),
//                               Column(
//                                 children: [
//                                   formfield('Local Address'),
//                                   formfield('City'),
//                                   formfield('District'),
//                                   formfield('State'),
//                                   formfield('Pincode'),
//                                   loginButton(
//                                       width * 0.99, 'Add Address', context)
//                                 ],
//                               )
//                             ],
//                           ), // Replace with your widget/content
//                         ),
//                       );
//                     },
//                   );
//                 },
//                 child: Container(
//                   width: width * 0.9,
//                   height: height * 0.2,
//                   decoration: BoxDecoration(
//                     border: Border.all(
//                       color: Colors.black, // Set border color
//                       width: 1.0, // Set border width
//                     ),
//                     borderRadius:
//                         BorderRadius.circular(8.0), // Set border radius
//                   ),
//                   child: const Center(
//                       child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text(
//                         "Add Address",
//                         style: TextStyle(fontSize: 19),
//                       ),
//                       Icon(Icons.add_location)
//                     ],
//                   )),
//                 ),
//               ),
//             const  SizedBox(
//                 height: 10,
//               ),
//             const  Text(
//                 'Order List',
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//               ),
//              const SizedBox(
//                 height: 10,
//               ),
//               Container(
//                 decoration: BoxDecoration(
//                   color: Colors.grey[300],
//                   border: Border.all(
//                     color: Colors.black, // Set border color
//                     width: 1.0, // Set border width
//                   ),
//                   borderRadius: BorderRadius.circular(5.0), // Set border radius
//                 ),
//                 width: double.infinity,
//                 height: height * 0.20,
//                 child: Row(children: [
//                   Padding(
//                     padding: const EdgeInsets.only(left: 1),
//                     child: Container(
//                       width: 150,
//                       height: 100,
//                       decoration:const BoxDecoration(
//                         // border: Border.all(),
//                         image:  DecorationImage(
//                             image: AssetImage('assets/images/macbook.jpg'),
//                             fit: BoxFit.cover),
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(top: 5, left: 10),
//                     child: Column(
//                       children: [
//                       const  SizedBox(
//                           height: 13,
//                         ),
//                        const Text(
//                           'Samsung 34-inches 86.34\n Led odyssey G5 Ultra ....',
//                           style: TextStyle(fontSize: 15),
//                         ),
//                        const SizedBox(
//                           height: 5,
//                         ),
//                       const  Text(
//                           '₹53,300',
//                           style: TextStyle(
//                               fontSize: 25, fontWeight: FontWeight.bold),
//                         ),
//                        const SizedBox(
//                           height: 10,
//                         ),
//                         Container(
//                           width: width * 0.1,
//                           height: height * 0.05,
//                           // color: Colors.black,
//                           decoration: BoxDecoration(
//                             border: Border.all(
//                               color: Colors.black, // Set border color
//                               width: 2.0, // Set border width
//                             ),
//                             borderRadius:
//                                 BorderRadius.circular(5.0), // Set border radius
//                           ),
//                           child: Container(
//                             width: 55,
//                             height: 70,
//                             color: Colors.white,
//                             child:const Center(child: Text('1')),
//                           ),
//                         )
//                       ],
//                     ),
//                   )
//                 ]),
//               ),
//              const SizedBox(
//                 height: 10,
//               ),
//              const Text(
//                 'Select the payment method',
//                 style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
//               ),
//              const SizedBox(
//                 height: 10,
//               ),
//               Container(
//                 decoration: BoxDecoration(
//                   border: Border.all(
//                     color: Colors.black, // Set border color
//                     width: 1.0, // Set border width
//                   ),
//                   borderRadius: BorderRadius.circular(5.0), // Set border radius
//                 ),
//                 width: double.infinity,
//                 height: height * 0.07,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Container(
//                       width: 200,
//                       height: 40,
//                       decoration:const BoxDecoration(
//                         image: DecorationImage(
//                           image: AssetImage(
//                               'assets/images/razorpay.png'), // Replace with your image asset
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//              const SizedBox(
//                 height: 5,
//               ),
//               Container(
//                 decoration: BoxDecoration(
//                   border: Border.all(
//                     color: Colors.black, // Set border color
//                     width: 1.0, // Set border width
//                   ),
//                   borderRadius: BorderRadius.circular(5.0), // Set border radius
//                 ),
//                 width: double.infinity,
//                 height: height * 0.07,
//                 child:const Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(
//                       'CASH ON DELIVERY',
//                       style: TextStyle(fontSize: 22),
//                     )
//                   ],
//                 ),
//               ),
//             const  SizedBox(
//                 height: 10,
//               ),
//              const Row(
//                 children: [
//                   Text(
//                     'Total',
//                     style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//                   ),
//                   Spacer(),
//                   Text(
//                     '₹53,300',
//                     style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//                   )
//                 ],
//               ),
//               // Container(
//               //   decoration: BoxDecoration(
//               //     border: Border.all(
//               //       color: Colors.black, // Set border color
//               //       width: 1.0, // Set border width
//               //     ),
//               //     borderRadius: BorderRadius.circular(5.0), // Set border radius
//               //   ),
//               //   width: double.infinity,
//               //   height: height * 0.07,
//               //   child: Row(
//               //     mainAxisAlignment: MainAxisAlignment.center,
//               //     children: [
//               //       Text(
//               //         'CASH ON DELIVERY',
//               //         style: TextStyle(fontSize: 22),
//               //       )
//               //     ],
//               //   ),
//               // ),
//               loginButton(width * 0.99, 'Proceed to Buy', context),
//              const SizedBox(
//                 height: 13,
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   SizedBox formfield(String name) {
//     return SizedBox(
//       width: 250,
//       height: 100,
//       child: TextFormField(
//         decoration: InputDecoration(
//             filled: true,
//             fillColor: Colors.white,
//             labelStyle:const TextStyle(color: Colors.black),
//             labelText: name,
//             border:
//                 OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
//       ),
//     );
//   }
// }

// SizedBox loginButton(double width, String name, BuildContext context) {
//   return SizedBox(
//       width: width * 0.5,
//       child: ElevatedButton(
//         onPressed: () {
//           snack(context, message: 'Order Placed', color: Colors.green);
//         },
//         child: Text(
//           name,
//           style:const TextStyle(color: Colors.white), // Set the text color to white
//         ),
//         style: ButtonStyle(
//           backgroundColor: MaterialStateProperty.all<Color>(
//               Colors.red), // Set the background color to black
//         ),
//       ));
// }

// void snack(BuildContext context,
//     {required String message, required Color color}) {
//   ScaffoldMessenger.of(context)
//     ..removeCurrentSnackBar()
//     ..showSnackBar(SnackBar(
//       content: Text(
//         message,
//         style:const TextStyle(color: Colors.black54),
//       ),
//       duration:const Duration(seconds: 2),
//       backgroundColor: color,
//       elevation: 6,
//       behavior: SnackBarBehavior.floating,
//       margin:const EdgeInsets.symmetric(horizontal: 21),
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//     ));
// }

import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laptopzone_user/constants/constants.dart';
import 'package:laptopzone_user/controller/address_controller.dart';
import 'package:laptopzone_user/model/order_model.dart';
import 'package:laptopzone_user/services/cart_service.dart';
import 'package:laptopzone_user/services/my_order_service.dart';

import 'package:laptopzone_user/view/cart_screen/widgets/payment_widget.dart';
import 'package:laptopzone_user/view/cart_screen/widgets/shipping_address_widget.dart';
import 'package:laptopzone_user/view/cart_screen/widgets/shipping_addresses.dart';
import 'package:laptopzone_user/view/razporpay/razorpay.dart';
import 'package:laptopzone_user/view/success/success.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

String address = '';

class CheckoutScreen extends StatelessWidget {
  int? total;
  CheckoutScreen({super.key, required this.total});

  AddressController ad = Get.put(AddressController());
  OrderModel? ordery;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final currentemail = FirebaseAuth.instance.currentUser!.email;
    log('checking one :${AddressController().selectedIdx}');
    List<QueryDocumentSnapshot<Map<String, dynamic>>> tmp = [];
    ad.fetchAddresses();
    return Scaffold(
        backgroundColor: kwhite,
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(
                Icons.arrow_back_ios_new_rounded,
                color: kblack,
              )),
          backgroundColor: kwhite,
          centerTitle: true,
          elevation: 10,
          title: const Text(
            'Checkout',
            style: TextStyle(fontSize: 25, color: Colors.black),
          ),
        ),
        body: SingleChildScrollView(
          child: SizedBox(
            height: 790,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  kheight30,
                  const Text(
                    'Shipping Address',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  kheight10,
                  Container(
                    height: 150,
                    width: 350,
                    decoration: BoxDecoration(
                        border: Border.all(color: kblack),
                        borderRadius: BorderRadius.circular(20)),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GetBuilder<AddressController>(
                            init: ad,
                            builder: (controller) {
                              log('checking one :${ad.selectedIdx}');
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  kheight10,
                                  (ad.selectedIdx != null ||
                                          AddressController().selectedIdx !=
                                              null)
                                      ? StreamBuilder(
                                          stream: FirebaseFirestore.instance
                                              .collection('users')
                                              .doc('address')
                                              .collection(currentemail!)
                                              .snapshots(),
                                          builder: (context, snapshot) {
                                            if (snapshot.hasData &&
                                                snapshot
                                                    .data!.docs.isNotEmpty) {
                                              address = '';
                                              address =
                                                  '${snapshot.data!.docs[ad.selectedIdx!]['name']},${snapshot.data!.docs[ad.selectedIdx!]['area']}${snapshot.data!.docs[ad.selectedIdx!]['district']},${snapshot.data!.docs[ad.selectedIdx!]['state']},${snapshot.data!.docs[ad.selectedIdx!]['pincode']}';
                                            }
                                            if (snapshot.data == null) {
                                              return const Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              );
                                            } else if (snapshot.hasError) {
                                              return const Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              );
                                            }
                                            return snapshot.hasData
                                                ? ShippingFields(
                                                    name: snapshot.data!
                                                            .docs[ad.selectedIdx!]
                                                        ['name'],
                                                    area: snapshot.data!
                                                            .docs[ad.selectedIdx!]
                                                        ['area'],
                                                    district: snapshot.data!
                                                            .docs[ad.selectedIdx!]
                                                        ['district'],
                                                    state: snapshot.data!
                                                            .docs[ad.selectedIdx!]
                                                        ['state'],
                                                    pincode: snapshot.data!
                                                            .docs[ad.selectedIdx!]
                                                        ['pincode'])
                                                : const Center(
                                                    child: Text('loading'),
                                                  );
                                          })
                                      : const Center(
                                          child: Text('add address'),
                                        )
                                ],
                              );
                            }),
                        const Spacer(),
                        IconButton(
                            onPressed: () {
                              Get.to(const ShippingAddress());
                            },
                            icon: const Icon(
                              Icons.add_location_alt_rounded,
                              size: 30,
                            ))
                      ],
                    ),
                  ),
                  kheight10,
                  const Text(
                    'Order List',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 200,
                    child: StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('users')
                            .doc('cart')
                            .collection(currentemail!)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const CircularProgressIndicator();
                          } else if (snapshot.hasError &&
                              snapshot.data!.docs.isNotEmpty) {
                            return Text('Error: ${snapshot.error}');
                          }
                          tmp.addAll(snapshot.data!.docs);
                          return ListView.separated(
                            separatorBuilder: (context, index) =>
                                const SizedBox(
                              height: 10,
                            ),
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(10),
                                child: Container(
                                  height: 150,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(color: kblack)),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        height: 100,
                                        width: 100,
                                        child: Image(
                                          image: NetworkImage(snapshot
                                              .data!.docs[index]['image1']),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      kwidth30,
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: 210,
                                            child: Text(
                                              snapshot.data!.docs[index]
                                                  ['productName'],
                                              style: const TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          Text(
                                              "₹${snapshot.data!.docs[index]['price']}",
                                              style: const TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold)),
                                          kheight10,
                                          // Text(
                                          //     "SIze: ${snapshot.data!.docs[index]['size']}"),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        }),
                  ),
                  Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        border: Border.all(color: kblack),
                        borderRadius: BorderRadius.circular(20)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Select the Payment Method',
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                          ),
                          kheight10,
                          InkWell(
                            onTap: () async {
                              final orderList = <OrderModel>[];
                              for (var x in tmp) {
                                ordery = OrderModel(
                                  productName: x['productName'],
                                  productDes: x['des'],
                                  discountPrice: x['price'],
                                  productImg1: x['image1'],
                                  productImg2: x['image2'],
                                  productImg3: x['image3'],
                                  currentUser: x['user'],
                                  address: address,
                                  deliveryStatus: 'pending',
                                );
                                orderList.add(ordery!);

                                await Razor(orderList: orderList).pay();
                              }
                            },
                            child: PaymentsWidgets(
                                imgPath:
                                    'assets/images/3da34d9a-be70-4440-a4a4-47a937b6daf4_razorpy.PNG',
                                payments: 'Razorpay'),
                          ),
                          kheight20,
                          InkWell(
                            onTap: () async {
                              log('cod');
                              Get.dialog(Center(
                                child: LoadingAnimationWidget.waveDots(
                                    color: Colors.white, size: 50),
                              ));
                              for (var x in tmp) {
                                ordery = OrderModel(
                                  productName: x['productName'],
                                  productDes: x['des'],
                                  discountPrice: x['price'],
                                  productImg1: x['image1'],
                                  productImg2: x['image2'],
                                  productImg3: x['image3'],
                                  currentUser: x['user'],
                                  address: address,
                                  deliveryStatus: 'pending',
                                );
                                log('looping');
                                await MyOrderService().addOrder(ordery!);
                              }
                              log('added');

                              await CartService().deleteWholeCart();
                              log('deleted');

                              Get.to(const Success());
                            },
                            child: PaymentsWidgets(
                                imgPath: 'assets/images/pngwing.com (7).png',
                                payments: 'Cash on Delivery'),
                          ),
                          kheight5,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Total',
                                style: TextStyle(
                                    fontSize: 21, fontWeight: FontWeight.bold),
                              ),
                              kwidth30,
                              Text(
                                '₹$total',
                                style: TextStyle(
                                    fontSize: 27,
                                    fontWeight: FontWeight.bold,
                                    color: kblack),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
