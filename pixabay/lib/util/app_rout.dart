import 'package:flutter/cupertino.dart';
import 'package:pixabay/view/home/screen/home_page.dart';
import 'package:pixabay/view/details_page/image_view.dart';
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
      final arguments = settings.arguments as String;
      page = CupertinoPageRoute(
          builder: (context) => ImageView(
                imageUrl: arguments,
              ));
      break;
  }
  return page;
}
