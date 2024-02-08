class FavModel {
  final String productName;
  final String productDes;
  final String discountPrice;
  final String productPrice;
  final String currentUser;
  final String productImg1;
  final String productImg2;
  final String productImg3;
  final String? productBrand;

  FavModel(
      {
      required this.productName,
      required this.productDes,
      required this.discountPrice,
      required this.productPrice,
      required this.currentUser,
      required this.productImg1,
      required this.productImg2,
      required this.productImg3,
      this.productBrand
      });

  Map<String, dynamic> toJson() {
    return {
      'produtName': productName,
      'image1': productImg1,
      'image2': productImg2,
      'image3': productImg3,
      'disprice': discountPrice,
      'proprice': productPrice,
      'des': productDes,
      'user': currentUser,
      'brand': productBrand
    };
  }

  static FavModel fromJson(Map<String, dynamic> json) => FavModel(
        productName: json["produtName"] ?? '',
        productDes: json["des"] ?? '',
        discountPrice: json['disprice'] ?? '',
        productPrice: json['proprice'] ?? '',
        currentUser: json['user'] ?? '',
        productImg1: json['image1'] ?? '',
        productImg2: json['image2'] ?? '',
        productImg3: json['image3'] ?? '',
        productBrand: json['brand'] ?? '',
      );
}
