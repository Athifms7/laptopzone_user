class CartModel {
  final String productName;
  final String productDes;
  final String discountPrice;
  final String currentUser;
  final String productImg1;
  final String productImg2;
  final String productImg3;

  CartModel(
      {required this.productName,
      required this.productDes,
      required this.discountPrice,
      required this.currentUser,
      required this.productImg1,
      required this.productImg2,
      required this.productImg3});
        Map<String, dynamic> toJson() {
    return {
      'productName': productName,
      'image1': productImg1,
      'image2': productImg2,
      'image3': productImg3,
      'price': discountPrice,
      'des': productDes,
      'user': currentUser
    };
  }

  static CartModel fromJson(Map<String, dynamic> json) => CartModel(
      productName: json['productName'],
      productImg1: json['image1'],
      productImg2: json['image2'],
      productImg3: json['image3'],
      productDes: json['des'],
      currentUser: json['user'],
      discountPrice: json['price'],
      );
}
