import 'package:flutter/material.dart';


class PopularBrands extends StatelessWidget {
  String? imgpath;
  String? brandName;
  
  PopularBrands({super.key, required this.imgpath, required this.brandName});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.black, // Set the color of the border
              width: 1.0, // Set the width of the border
            ),
          ),
          child: CircleAvatar(
            radius: 30,
            backgroundColor: Colors.white,
            child: Image(
              image: NetworkImage('$imgpath'),
              height: 30,
            ),
          ),
        ),
        Text('$brandName')
      ],
    );
  }
}
