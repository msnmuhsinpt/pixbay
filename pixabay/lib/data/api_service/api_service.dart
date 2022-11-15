import 'dart:convert';
import 'dart:developer';

import '../../util/app_url.dart';
import '../api_model/pixabar_response.dart';

import 'package:http/http.dart' as http;

class APIService {
  Future<ImageViewResponse> getData(item) async {
    try {
      var response = await http.Client()
          .post(Uri.parse(AppUrl.baseUrl + item + AppUrl.lastSection),
              headers: {
                "Content-Type": "application/json",
                "Accept": "application/json",
              },
              body: jsonEncode({}));

      log("API>>>URL>>${AppUrl.baseUrl + item + AppUrl.lastSection}<<<RES>>>${response.body}<<<REQ>>>${jsonEncode({
            "tags": item,
          })}");

      if (response.statusCode == 200) {
        return ImageViewResponse.fromJson(json.decode(response.body));
      } else if (response.statusCode == 201) {
        return ImageViewResponse.fromJson(json.decode(response.body));
      } else {
        return ImageViewResponse(code: 500);
      }
    } catch (e) {
      log("Error in API$e");
      if (e.toString().startsWith("SocketException")) {
        //no inter net case
        return ImageViewResponse(code: 200);
      } else {
        return ImageViewResponse(code: 500);
      }
    }
  }
}
