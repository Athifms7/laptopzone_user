import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laptopzone_user/model/product_model.dart';
import 'package:laptopzone_user/services/product_service.dart';
import 'package:laptopzone_user/view/product_details/product_details.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<ProductModel> allProducts = [];

  List<ProductModel> displayProducts = [];

  @override
  void initState() {
    super.initState();

    _fetchProducts();
  }

  Future<void> _fetchProducts() async {
    try {
      List<ProductModel> products = await ProductServices().fetchProducts();
      setState(() {
        // Update both lists when products are fetched
        allProducts = products;
        displayProducts = List.from(allProducts);
      });
    } catch (e) {
      // Handle error if needed
      print("Error fetching products: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 10,
        toolbarHeight: height * 0.10,
        title: SizedBox(
          width: 300,
          height: 50,
          child: GestureDetector(
            onTap: () {
              // Navigator.of(context).push(MaterialPageRoute(builder: (context) => ))
            },
            child: TextFormField(
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[300],
                  labelStyle: const TextStyle(color: Colors.black),
                  labelText: 'Search Laptop',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20))),
              onChanged: (value) {
                setState(() {
                  displayProducts = allProducts
                      .where((product) =>
                          product.productName
                              .toLowerCase()
                              .contains(value.toLowerCase()) ||
                          product.productDes
                              .toLowerCase()
                              .contains(value.toLowerCase()))
                      .toList();
                });
              },
            ),
          ),
        ),
      ),
      body: GridView.builder(
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.9,
            // crossAxisSpacing: 5,
            mainAxisSpacing: 2),
        itemBuilder: (context, index) => GestureDetector(
            onTap: () {
              Get.to(ProductDetailsScreen(
                imgPath1: displayProducts[index].productImg1,
                imgPath2: displayProducts[index].productImg2,
                imgPath3: displayProducts[index].productImg3,
                productNames: displayProducts[index].productName,
                productDes: displayProducts[index].productDes,
                productRate: displayProducts[index].productPrice,
                sellingPrice: displayProducts[index].discountPrice,
                productBrand: displayProducts[index].productBrand,
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
                                    displayProducts[index].productImg1),
                                fit: BoxFit.cover),
                          ),
                        ),
                        // Positioned(
                        //   left: 112,
                        //   child: IconButton(
                        //     onPressed: () async {
                        //       FavModel model = FavModel(
                        //           productBrand: widget.productBrand,
                        //           productName: widget.productName!,
                        //           productDes: widget.productDes!,
                        //           discountPrice: widget.sellingRate!,
                        //           productPrice: widget.productRate!,
                        //           currentUser: currentemail!,
                        //           productImg1: widget.imgPath1!,
                        //           productImg2: widget.imgPath2!,
                        //           productImg3: widget.imgPath3!);
                        //       await checkFavoriteStatus();

                        //       bool newFavStatus = !isFav; // Toggle the favorite status

                        //       setState(() {
                        //         isFav = newFavStatus; // Update the UI immediately

                        //         if (newFavStatus) {
                        //           FavouriteService().addFavourite(product: model);
                        //         } else {
                        //           FavouriteService().removeFavourite(product: model);
                        //         }
                        //       });
                        //     },
                        //     icon: Icon(
                        //       Icons.favorite,
                        //       size: 30,
                        //       color: isFav ? kred : kblack,
                        //     ),
                        //   ),
                        // )
                      ],
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Text(
                        displayProducts[index].productName,
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
                        Text(displayProducts[index].discountPrice,
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            )),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(displayProducts[index].productPrice,
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
            )

            ),
        itemCount: displayProducts.length,
      ),
    );
  }
}
