import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laptopzone_user/constants/constants.dart';
import 'package:laptopzone_user/model/brand_model.dart';
import 'package:laptopzone_user/model/product_model.dart';
import 'package:laptopzone_user/services/brand_service.dart';
import 'package:laptopzone_user/services/product_service.dart';
import 'package:laptopzone_user/view/home_screen/home_gridview.dart';
import 'package:laptopzone_user/view/popular_brands/brand_wise.dart';
import 'package:laptopzone_user/view/popular_brands/popular_brands.dart';
import 'package:laptopzone_user/view/product_details/product_details.dart';
import 'package:laptopzone_user/view/search_screen/search_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String? sortingOption;
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
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) =>const SearchScreen()));
              },
              icon:const Icon(Icons.search))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(
            width: double.infinity,
            height: height * .18,
            // color: Colors.amber,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 3,
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Text(
                    'Brands',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                SizedBox(
                  height: 97,
                  child: FutureBuilder(
                      future: BrandServices().fetchBrands(),
                      builder: (context, snapshot) {
                        if (snapshot.data == null) {
                          return const CircularProgressIndicator();
                        } else if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          // log('waiting');
                          return const CircularProgressIndicator();
                        }
                        final List<BrandModel> allBrandModel = snapshot.data!;

                        // log(allBrandModel.length.toString());
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListView.separated(
                            separatorBuilder: (context, index) => kwidth5,
                            scrollDirection: Axis.horizontal,
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              // log('enter');
                              return InkWell(
                                onTap: () => Get.to(BrandWise(
                                    title: allBrandModel[index].brand)),
                                child: PopularBrands(
                                  imgpath: allBrandModel[index].image,
                                  brandName: allBrandModel[index].brand,
                                ),
                              );
                            },
                          ),
                        );
                      }),
                ),
              ],
            ),
          ),
          // kheight20,
          const Padding(
            padding:  EdgeInsets.only(left: 10),
            child: Text(
              'All Products',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          FutureBuilder(
              future: ProductServices().fetchProducts(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.data == null) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                final List<ProductModel> allProductModel = snapshot.data!;
                if (sortingOption == "asc") {
                  allProductModel.sort((a, b) {
                    double aPrice = double.parse(a.discountPrice);
                    double bPrice = double.parse(b.discountPrice);
                    return aPrice.compareTo(bPrice);
                  });
                } else if (sortingOption == "desc") {
                  allProductModel.sort((a, b) {
                    double aPrice = double.parse(a.discountPrice);
                    double bPrice = double.parse(b.discountPrice);
                    return bPrice.compareTo(aPrice);
                  });
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
                    return InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) {
                            return ProductDetailsScreen(
                              imgPath1: allProductModel[index].productImg1,
                              imgPath2: allProductModel[index].productImg2,
                              imgPath3: allProductModel[index].productImg3,
                              productBrand: allProductModel[index].productBrand,
                              productDes: allProductModel[index].productDes,
                              productNames: allProductModel[index].productName,
                              productRate: allProductModel[index].productPrice,
                              sellingPrice:
                                  allProductModel[index].discountPrice,
                            );
                          },
                        ));
                      },
                      child: HomeGridView(
                        productDes: allProductModel[index].productDes,
                        imgPath3: allProductModel[index].productImg3,
                        imgPath2: allProductModel[index].productImg2,
                        imgPath1: allProductModel[index].productImg1,
                        productName: allProductModel[index].productName,
                        productRate: allProductModel[index].productPrice,
                        sellingRate: allProductModel[index].discountPrice,
                      ),
                    );
                  },
                  itemCount: allProductModel.length,
                );
              }),
          const SizedBox(
            height: 15,
          ),
        ]),
      ),
    );
  }
}

