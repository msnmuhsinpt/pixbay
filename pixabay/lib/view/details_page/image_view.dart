import 'package:flutter/material.dart';
import 'package:pixabay/util/app_%20constant.dart';

class ImageView extends StatelessWidget {
  final String imageUrl;

  const ImageView({required this.imageUrl, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: screenWidth(context),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(imageUrl),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
    ));
  }
}
