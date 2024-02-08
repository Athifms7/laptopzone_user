// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:laptopzone_user/model/product_model.dart';
// import 'package:laptopzone_user/services/product_service.dart';
// import 'package:laptopzone_user/view/product_details/product_details.dart';

// class SearchController extends GetxController {
  

//   TextEditingController searchController = TextEditingController();
//   List<ProductModel> allProducts = [];
//   List<ProductModel> displayProducts = [];

//   @override
//   void onInit() {
//     super.onInit();
//     _fetchProducts();
//   }

//   void _fetchProducts() async {
//     try {
//       List<ProductModel> products = await ProductServices().fetchProducts();
//       // Update both lists when products are fetched
//       allProducts = products;
//       displayProducts = List.from(allProducts);
//       update();
//     } catch (e) {
//       // Handle error if needed
//       print("Error fetching products: $e");
//     }
//   }

//   void updateSearch(String value) {
//     displayProducts = allProducts
//         .where((product) =>
//             product.productName.toLowerCase().contains(value.toLowerCase()) ||
//             product.productDes.toLowerCase().contains(value.toLowerCase()))
//         .toList();
//     update();
//   }

//   void navigateToProductDetails(int index) {
//     Get.to(() => ProductDetailsScreen(
//           imgPath1: displayProducts[index].productImg1,
//           imgPath2: displayProducts[index].productImg2,
//           imgPath3: displayProducts[index].productImg3,
//           productNames: displayProducts[index].productName,
//           productDes: displayProducts[index].productDes,
//           productRate: displayProducts[index].productPrice,
//           sellingPrice: displayProducts[index].discountPrice,
//           productBrand: displayProducts[index].productBrand,
//         ));
//   }
// }