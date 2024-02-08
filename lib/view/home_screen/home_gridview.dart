import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:laptopzone_user/constants/constants.dart';
import 'package:laptopzone_user/model/favourite_model.dart';
import 'package:laptopzone_user/services/favourite_service.dart';

class HomeGridView extends StatefulWidget {
  String? imgPath1;
  String? imgPath2;
  String? imgPath3;
  String? productDes;
  String? productName;
  String? productRate;
  String? sellingRate;
  String? productBrand;
  HomeGridView(
      {super.key,
      required this.imgPath1,
      this.productBrand,
      this.imgPath2,
      this.imgPath3,
      this.productDes,
      required this.productName,
      required this.productRate,
      required this.sellingRate});

  @override
  State<HomeGridView> createState() => _HomeGridViewState();
}

class _HomeGridViewState extends State<HomeGridView> {
  @override
  void initState() {
    checkFavoriteStatus();
    super.initState();
  }

  final currentemail = FirebaseAuth.instance.currentUser!.email;
  bool isFav = false;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    // final width = MediaQuery.of(context).size.width;
    return Padding(
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
                        image: NetworkImage('${widget.imgPath1}'),
                        fit: BoxFit.cover),
                  ),
                ),
                Positioned(
                  left: 112,
                  child: IconButton(
                    onPressed: () async {
                      FavModel model = FavModel(
                          productBrand: widget.productBrand,
                          productName: widget.productName!,
                          productDes: widget.productDes!,
                          discountPrice: widget.sellingRate!,
                          productPrice: widget.productRate!,
                          currentUser: currentemail!,
                          productImg1: widget.imgPath1!,
                          productImg2: widget.imgPath2!,
                          productImg3: widget.imgPath3!);
                      await checkFavoriteStatus();

                      bool newFavStatus = !isFav; // Toggle the favorite status

                      setState(() {
                        isFav = newFavStatus; // Update the UI immediately

                        if (newFavStatus) {
                          FavouriteService().addFavourite(product: model);
                        } else {
                          FavouriteService().removeFavourite(product: model);
                        }
                      });
                    },
                    icon: Icon(
                      Icons.favorite,
                      size: 30,
                      color: isFav ? kred : kblack,
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
                '${widget.productName}',
                style:
                    const TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(
              height: height * 0.01,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('₹${widget.sellingRate}',
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    )),
                const SizedBox(
                  width: 5,
                ),
                Text('₹${widget.productRate}',
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
    );
  }

  checkFavoriteStatus() async {
    final isFavoriteProduct = await FavouriteService().checkFav(
        product: FavModel(
      productBrand: widget.productBrand,
      currentUser: currentemail!,
      productName: widget.productName!,
      productPrice: widget.productRate!,
      discountPrice: widget.sellingRate!,
      productDes: widget.productDes!,
      productImg1: widget.imgPath1!,
      productImg2: widget.imgPath2!,
      productImg3: widget.imgPath3!,
    ));
    setState(() {
      isFav = isFavoriteProduct;
    });
  }
}
