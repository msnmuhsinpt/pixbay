import 'package:flutter/cupertino.dart';
import 'package:pixabay/view/home/screen/home_page.dart';
import 'package:pixabay/view/image_view.dart';
import 'package:pixabay/view/splash/splash_page.dart';

Route onGenerateRoute(RouteSettings settings) {
  Route page = CupertinoPageRoute(builder: (context) => const SplashPage());
  switch (settings.name) {
    case "/splash":
      page = CupertinoPageRoute(builder: (context) => const SplashPage());
      break;
    case "/home":
      page = CupertinoPageRoute(
        builder: (context) => HomePage(),
      );
      break;
    case "/imageView":
      page = CupertinoPageRoute(builder: (context) => const ImageView());
      break;
  }
  return page;
}
