import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laptopzone_user/constants/constants.dart';
import 'package:laptopzone_user/model/favourite_model.dart';
import 'package:laptopzone_user/services/favourite_service.dart';
import 'package:laptopzone_user/view/product_details/product_details.dart';

final currentEmail = FirebaseAuth.instance.currentUser!.email;

class FavouriteScreen extends StatefulWidget {
  FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  final currentemail = FirebaseAuth.instance.currentUser!.email;
  bool isFav = false;
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
        body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc('favourites')
              .collection(currentemail!)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }
            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return const Center(
                child: Text("No Favourites found"),
              );
            }

            return GridView.builder(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.9,
                  // crossAxisSpacing: 5,
                  mainAxisSpacing: 2),
              itemBuilder: (context, index) {
                final favourite = snapshot.data!.docs[index].data();
                final product = FavModel.fromJson(favourite);
                List<FavModel> allFavModel = [];
                allFavModel.addAll(snapshot.data!.docs
                    .map((e) => FavModel.fromJson(e.data())));
                return GestureDetector(
                    onTap: () {
                      Get.to(ProductDetailsScreen(
                          imgPath1: allFavModel[index].productImg1,
                          imgPath2: allFavModel[index].productImg2,
                          imgPath3: allFavModel[index].productImg3,
                          productNames: allFavModel[index].productName,
                          productDes: allFavModel[index].productDes,
                          productRate: allFavModel[index].productPrice,
                          sellingPrice: allFavModel[index].discountPrice,
                          productBrand: allFavModel[index].productBrand));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: 160,
                        height: 70,
                        decoration: BoxDecoration(
                            border: Border.all(width: .7),
                            borderRadius: BorderRadius.circular(10)),
                        // color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Column(children: [
                            Stack(
                              children: [
                                Container(
                                  width: 150,
                                  height: 120,
                                  decoration: BoxDecoration(
                                    // border: Border.all(),
                                    image: DecorationImage(
                                        image:
                                            NetworkImage(product.productImg1),
                                        fit: BoxFit.cover),
                                  ),
                                ),
                                Positioned(
                                  left: 112,
                                  child: IconButton(
                                    onPressed: () async {
                                      await FavouriteService()
                                          .removeFavourite(product: product);

                                      // FavModel model = FavModel(
                                      //     productBrand: product.productBrand,
                                      //     productName: product.productName,
                                      //     productDes: product.productDes,
                                      //     discountPrice: product.discountPrice,
                                      //     productPrice: product.productPrice,
                                      //     currentUser: currentemail!,
                                      //     productImg1: product.productImg1,
                                      //     productImg2: product.productImg2,
                                      //     productImg3: product.productImg3);
                                      // _checkFavoriteStatus() async {
                                      //   final isFavoriteProduct =
                                      //       await FavouriteService().checkFav(
                                      //           product: FavModel(
                                      //               productBrand:
                                      //                   product.productBrand,
                                      //               productName:
                                      //                   product.productName,
                                      //               productDes:
                                      //                   product.productDes,
                                      //               discountPrice:
                                      //                   product.discountPrice,
                                      //               productPrice:
                                      //                   product.productPrice,
                                      //               currentUser: currentemail!,
                                      //               productImg1:
                                      //                   product.productImg1,
                                      //               productImg2:
                                      //                   product.productImg2,
                                      //               productImg3:
                                      //                   product.productImg3
                                      //               // productBrand: widget.productBrand,
                                      //               // currentUser: currentemail!,
                                      //               // productName: widget.productName!,
                                      //               // productPrice: widget.productRate!,
                                      //               // discountPrice: widget.sellingRate!,
                                      //               // productDes: widget.productDes!,
                                      //               // productImg1: widget.imgPath1!,
                                      //               // productImg2: widget.imgPath2!,
                                      //               // productImg3: widget.imgPath3!,
                                      //               ));
                                      //   setState(() {
                                      //     isFav = isFavoriteProduct;
                                      //   });
                                      // }

                                      // bool newFavStatus =
                                      //     !isFav; // Toggle the favorite status

                                      // setState(() {
                                      //   isFav =
                                      //       newFavStatus; // Update the UI immediately

                                      //   if (newFavStatus) {
                                      //     FavouriteService()
                                      //         .addFavourite(product: model);
                                      //   } else {
                                      //     FavouriteService()
                                      //         .removeFavourite(product: model);
                                      //   }
                                      // });
                                    },
                                    icon: Icon(
                                      Icons.favorite,
                                      size: 30,
                                      color: kred,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: height * 0.01,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: Text(
                                product.productName,
                                style: const TextStyle(
                                    fontSize: 19, fontWeight: FontWeight.bold),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            SizedBox(
                              height: height * 0.01,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(product.discountPrice,
                                    style: const TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                    )),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(product.productPrice,
                                    style: const TextStyle(
                                        color: Colors.redAccent,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        decoration: TextDecoration.lineThrough))
                              ],
                            )
                          ]),
                        ),
                      ),
                    ));
              },
              itemCount: snapshot.data!.docs.length,
            );
          },
        ));
  }
}



       // return ListView.separated(
            //     itemBuilder: (context, index) {
                  // final favourite = snapshot.data!.docs[index].data();
                  // final product = FavModel.fromJson(favourite);
                  // List<FavModel> allFavModel = [];
                  // allFavModel.addAll(snapshot.data!.docs
                  //     .map((e) => FavModel.fromJson(e.data())));

            //       return Padding(
            //         padding: const EdgeInsets.all(8.0),
            //         child: GestureDetector(
            //           onTap: () {
            //             Navigator.of(context).push(MaterialPageRoute(
            //               builder: (context) {
            //                 return ProductDetailsScreen(
            //                     imgPath1: allFavModel[index].productImg1,
            //                     imgPath2: allFavModel[index].productImg2,
            //                     imgPath3: allFavModel[index].productImg3,
            //                     productNames: allFavModel[index].productName,
            //                     productDes: allFavModel[index].productDes,
            //                     productRate: allFavModel[index].productPrice,
            //                     sellingPrice: allFavModel[index].discountPrice,
            //                     productBrand: allFavModel[index].productBrand);
            //               },
            //             ));
            //           },
            //           child: Container(
            //             width: 170,
            //             height: 200,
            //             decoration: BoxDecoration(
            //                 border: Border.all(width: .7),
            //                 borderRadius: BorderRadius.circular(10)),
            //             // color: Colors.white,
            //             child: Padding(
            //               padding: const EdgeInsets.all(5.0),
            //               child: Column(children: [
            //                 Row(
            //                   children: [
            //                     const SizedBox(
            //                       width: 100,
            //                     ),
            //                     Container(
            //                       width: 150,
            //                       height: 90,
            //                       decoration: BoxDecoration(
            //                         image: DecorationImage(
            //                             image:
            //                                 NetworkImage(product.productImg1),
            //                             fit: BoxFit.cover),
            //                       ),
            //                     ),
            //                     const Spacer(),
            //                     IconButton(
            //                       onPressed: () async {
            //                         await FavouriteService()
            //                             .removeFavourite(product: product);
            //                       },
            //                       icon: const Icon(
            //                         Icons.favorite,
            //                         size: 30,
            //                         color: Colors.red,
            //                       ),
            //                     ),
            //                   ],
            //                 ),
            //                 SizedBox(
            //                   height: height * 0.01,
            //                 ),
            //                 Padding(
            //                   padding: const EdgeInsets.only(left: 18),
            //                   child: Text(
            //                     product.productName,
            //                     style: const TextStyle(
            //                         fontSize: 17, fontWeight: FontWeight.bold),
            //                   ),
            //                 ),
            //                 SizedBox(
            //                   height: height * 0.01,
            //                 ),
            //                 Row(
            //                   mainAxisAlignment: MainAxisAlignment.center,
            //                   children: [
            //                     Text('₹${product.discountPrice}',
            //                         style: const TextStyle(
            //                             fontSize: 22,
            //                             fontWeight: FontWeight.bold)),
            //                     const SizedBox(
            //                       width: 5,
            //                     ),
            //                     Text('₹${product.productPrice}',
            //                         style: const TextStyle(
            //                             color: Colors.red,
            //                             fontSize: 15,
            //                             fontWeight: FontWeight.bold,
            //                             decoration: TextDecoration.lineThrough))
            //                   ],
            //                 )
            //               ]),
            //             ),
            //           ),
            //         ),
            //       );
            //     },
            //     separatorBuilder: (context, index) => const SizedBox(
            //           height: 7,
            //         ),
                // itemCount: snapshot.data!.docs.length);