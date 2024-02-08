import 'dart:developer';

import 'package:another_carousel_pro/another_carousel_pro.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:laptopzone_user/model/cart_model.dart';
import 'package:laptopzone_user/model/favourite_model.dart';
import 'package:laptopzone_user/services/cart_service.dart';
import 'package:laptopzone_user/services/favourite_service.dart';
import 'package:laptopzone_user/view/cart_screen/cart_screen.dart';
import 'package:laptopzone_user/view/favourite_screen/favourite_screen.dart';

class ProductDetailsScreen extends StatefulWidget {
  String? imgPath1;
  String? imgPath2;
  String? imgPath3;
  String? productNames;
  String? productDes;
  String? productRate;
  String? sellingPrice;
  String? productBrand;
  ProductDetailsScreen({
    super.key,
    required this.imgPath1,
    required this.imgPath2,
    required this.imgPath3,
    required this.productNames,
    required this.productDes,
    required this.productRate,
    required this.sellingPrice,
    required this.productBrand,
  });

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  bool isFav = false;
   bool isCart = false;
  @override
  void initState() {
    super.initState();
    checkFavoriteStatus();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    
    return Scaffold(
      appBar: AppBar(
        elevation: 10,
        toolbarHeight: height * 0.10,
        title: const Text('Product Details'),
        // actions: [
        //   IconButton(
        //       onPressed: () async {
        //         FavModel model = FavModel(
        //           productBrand: widget.productBrand,
        //           productName: widget.productNames!,
        //           productDes: widget.productDes!,
        //           discountPrice: widget.sellingPrice!,
        //           productPrice: widget.productRate!,
        //           currentUser: FirebaseAuth.instance.currentUser!.email!,
        //           productImg1: widget.imgPath1!,
        //           productImg2: widget.imgPath2!,
        //           productImg3: widget.imgPath3!,
        //         );

        //         bool newFavStatus = !isFav; // Toggle the favorite status

        //         setState(() async {
        //           isFav = newFavStatus; // Update the UI immediately

        //           if (newFavStatus) {
        //             FavouriteService().addFavourite(product: model);
        //           } else {
        //             FavouriteService().removeFavourite(product: model);
        //           }
        //           await checkFavoriteStatus();
        //         });
        //       },
        //       icon: Icon(
        //         Icons.favorite,
        //         size: 30,
        //         color: isFav
        //             ? Colors.red
        //             : Colors.grey, // Change color based on favorite status
        //       )),
        // ]

        // icon:const Icon(
        //   Icons.favorite,
        //   size: 30,
        //   color: Colors.red,
        // ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                  height: 300,
                  width: 400,
                  child: AnotherCarousel(
                    dotSize: 4.0,
                    dotSpacing: 15.0,
                    dotColor: Colors.lightGreenAccent,
                    indicatorBgPadding: 5.0,
                    borderRadius: true,
                    images: [
                      NetworkImage('${widget.imgPath1}'),
                      NetworkImage('${widget.imgPath2}'),
                      NetworkImage('${widget.imgPath3}'),
                    ],
                  )),
              // buildIndicator(),
              const SizedBox(
                height: 5,
              ),
              Text(
                "Brand: ${widget.productBrand}",
                style: const TextStyle(fontSize: 20, color: Colors.blueAccent),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                "${widget.productNames}",
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Text(
                    ' ₹${widget.sellingPrice}',
                    style: const TextStyle(
                        fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    ' ₹${widget.productRate}',
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                        decoration: TextDecoration.lineThrough),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Specification',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 6,
              ),
              Text(
                " ${widget.productDes}",
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Center(
                child: SizedBox(
                  width: width * 0.9,
                  child: ElevatedButton(
                    onPressed: () async{
                      CartModel model = CartModel(
                          productName: widget. productNames!,
                          productDes: widget.productDes!,
                          discountPrice: widget.sellingPrice!,
                          currentUser: currentEmail.toString(),
                          productImg1: widget.imgPath1!,
                          productImg2: widget.imgPath2!,
                          productImg3: widget.imgPath3!);

                          await checkCartStatus();

                        isCart
                            ? await CartService().removeCart(product: model)
                            : await CartService().addCart(product: model);



                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) {
                          return CartScreen();
                        },
                      ));
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Colors.red), // Set the background color to black
                    ),
                    child: const Text(
                      'Add To Cart',
                      style: TextStyle(
                          color: Colors.white), // Set the text color to white
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
            ],
          ),
        ),
      ),
    );
  }

  checkFavoriteStatus() async {
    final isFavoriteProduct = await FavouriteService().checkFav(
      product: FavModel(
        productBrand: widget.productBrand,
        currentUser: FirebaseAuth.instance.currentUser!.email!,
        productName: widget.productNames!,
        productPrice: widget.productRate!,
        discountPrice: widget.sellingPrice!,
        productDes: widget.productDes!,
        productImg1: widget.imgPath1!,
        productImg2: widget.imgPath2!,
        productImg3: widget.imgPath3!,
      ),
    );
    setState(() {
      isFav = isFavoriteProduct;
    });
  }

   checkCartStatus() async {
    final isCartProduct = await CartService().checkcart(
        product: CartModel(
            productName: widget.productNames!,
            productDes: widget.productDes!,
          
            discountPrice: widget.sellingPrice!,
            productImg1: widget.imgPath1!,
            productImg2: widget.imgPath2!,
            productImg3: widget.imgPath3!,
            currentUser: currentEmail.toString()));
    setState(() {
      isCart = isCartProduct;
      log(isCart.toString());
    });
  }
}
