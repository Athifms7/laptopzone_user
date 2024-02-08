class BrandModel {
  final String brand;
  final String image;

  BrandModel({required this.brand, required this.image});

  Map<String, dynamic> toJson() => {
        'brand': brand,
        'image': image,
      };

  static BrandModel fromJson(Map<String, dynamic> json) => BrandModel(
        brand: json['brand'],
        image: json['image'],
      );

    
}
