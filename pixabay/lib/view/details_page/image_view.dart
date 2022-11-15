import 'package:flutter/material.dart';
import 'package:pixabay/view/widget/app_text_view.dart';

class ImageView extends StatelessWidget {
  const ImageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: appTextView(name: 'Image view'),
      ),
    );
  }
}
