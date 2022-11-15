import 'dart:developer';
import 'dart:io';

DateTime? loginClickTime;

bool checkMultipleClick(DateTime currentTime) {
  if (loginClickTime == null) {
    loginClickTime = currentTime;
    return false;
  }
  if (currentTime.difference(loginClickTime!).inMilliseconds < 200) {
    //set this difference time in seconds
    return true;
  }

  loginClickTime = currentTime;
  return false;
}

Future<bool> hasNetwork() async {
  try {
    log("MSN>>>HasNetwork" "Entered1");

    final result = await InternetAddress.lookup('www.google.com');
    log("MSN>>>HasNetworkEntered3$result");

    return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
  } on SocketException catch (_) {
    log("MSN>>>HasNetworkEntered2${_.message}");

    return false;
  }
}
