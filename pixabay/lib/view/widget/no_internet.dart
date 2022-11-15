import 'package:flutter/material.dart';
import '../../../util/app_color.dart';
import '../../util/app_ constant.dart';
import '../../util/common_methods.dart';

Widget noInternetWidget(BuildContext context, String routeName,
    {dynamic args}) {
  return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Image.asset(
            icnNoInternet,
            height: 150,
          ),
          const Align(
            alignment: Alignment.center,
            child: Text("NO INTERNET"),
          ),
          Padding(
            padding: commonPaddingAll,
            child: const Align(
              alignment: Alignment.center,
              child: Text(
                  "You are not connected to internet.make sure wifi or mobile data is on, Airplane mode is off and try again.",
                  maxLines: 5),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.kRed,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5))),
                  onPressed: () async {
                    if (checkMultipleClick(DateTime.now())) {
                      return;
                    }
                    if (await hasNetwork()) {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, routeName, arguments: args);
                    }
                  },
                  child: const SizedBox(
                    width: 150,
                    child: Text(
                      "TRY AGAIN",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )),
          )
        ],
      ));
}
