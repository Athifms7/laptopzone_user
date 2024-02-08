import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:laptopzone_user/view/home_screen/home_gridview.dart';
import 'package:laptopzone_user/view/product_details/product_details.dart';

class BrandWise extends StatelessWidget {
  String? title;
  BrandWise({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          title: Text(
            '$title',
            style: const TextStyle(fontSize: 25, color: Colors.black),
          ),
          centerTitle: true,
          backgroundColor: const Color.fromARGB(240, 249, 247, 247),
          elevation: 10,
          toolbarHeight: height * 0.10,
        ),
        body: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('admin_details')
                .doc('admin')
                .collection('products')
                .where('productBrand', isEqualTo: title)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.data == null) {
                return const Center(child: CircularProgressIndicator());
              }
              return GridView.builder(
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.86,
                    crossAxisSpacing: 1,
                    mainAxisSpacing: 2),
                itemBuilder: (context, index) {
                  return InkWell(
                      onTap: () {
                        Get.to(ProductDetailsScreen(
                          imgPath1: snapshot.data!.docs[index]['productImg1'],
                          imgPath2: snapshot.data!.docs[index]['productImg2'],
                          imgPath3: snapshot.data!.docs[index]['productImg3'],
                          productDes: snapshot.data!.docs[index]['productDes'],
                          productNames: snapshot.data!.docs[index]
                              ['productName'],
                          productRate: snapshot.data!.docs[index]
                              ['productPrice'],
                          sellingPrice: snapshot.data!.docs[index]
                              ['discountPrice'],
                          productBrand: snapshot.data!.docs[index]
                              ['productBrand'],
                        ));
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
                                          image: NetworkImage(
                                              '${snapshot.data!.docs[index]['productImg1']}'),
                                          fit: BoxFit.cover),
                                    ),
                                  ),
                                  // Positioned(
                                  // left: 112,
                                  // child: IconButton(
                                  //   onPressed: () async {
                                  //     FavModel model = FavModel(
                                  //         productBrand: widget.productBrand,
                                  //         productName: widget.productName!,
                                  //         productDes: widget.productDes!,
                                  //         discountPrice: widget.sellingRate!,
                                  //         productPrice: widget.productRate!,
                                  //         currentUser: currentemail!,
                                  //         productImg1: widget.imgPath1!,
                                  //         productImg2: widget.imgPath2!,
                                  //         productImg3: widget.imgPath3!);
                                  //     await checkFavoriteStatus();

                                  //     bool newFavStatus = !isFav; // Toggle the favorite status

                                  //     setState(() {
                                  //       isFav = newFavStatus; // Update the UI immediately

                                  //       if (newFavStatus) {
                                  //         FavouriteService().addFavourite(product: model);
                                  //       } else {
                                  //         FavouriteService().removeFavourite(product: model);
                                  //       }
                                  //     });
                                  //   },
                                  //   icon: Icon(
                                  //     Icons.favorite,
                                  //     size: 30,
                                  //     color: isFav ? kred : kblack,
                                  //   ),
                                  // ),
                                  // )
                                ],
                              ),
                              SizedBox(
                                height: height * 0.01,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8),
                                child: Text(
                                  '${snapshot.data!.docs[index]['productName']}',
                                  style: const TextStyle(
                                      fontSize: 19,
                                      fontWeight: FontWeight.bold),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              SizedBox(
                                height: height * 0.01,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                      '₹${snapshot.data!.docs[index]['discountPrice']}',
                                      style: const TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                      )),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                      '₹${snapshot.data!.docs[index]['productPrice']}',
                                      style: const TextStyle(
                                          color: Colors.redAccent,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          decoration:
                                              TextDecoration.lineThrough))
                                ],
                              )
                            ]),
                          ),
                        ),
                      )
                      //  HomeGridView(
                      //     imgPath1: snapshot.data!.docs[index]['productImg1'],
                      //     productName: snapshot.data!.docs[index]['productName'],
                      //     productRate: snapshot.data!.docs[index]['productPrice'],
                      //     sellingRate: snapshot.data!.docs[index]
                      //         ['discountPrice'],

                      //         ),
                      );
                },
                itemCount: snapshot.data!.docs.length,
              );
            }));
  }
}
