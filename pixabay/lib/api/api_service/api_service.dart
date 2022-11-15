import 'dart:convert';
import 'dart:developer';

import '../../util/app_url.dart';
import '../api_model/pixabar_response.dart';

import 'package:http/http.dart' as http;

class APIService {
  Future<PixabayResponse> getData() async {
    try {
      var response = await http.Client().post(Uri.parse(AppUrl.baseUrl),
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
          },
          body: jsonEncode({}));

      log("API>>>URL>>${AppUrl.baseUrl}<<<RES>>>${response.body}<<<REQ>>>${jsonEncode({})}");

      if (response.statusCode == 200) {
        return PixabayResponse.fromJson(json.decode(response.body));
      } else if (response.statusCode == 201) {
        return PixabayResponse.fromJson(json.decode(response.body));
      } else {
        return PixabayResponse(code: 500);
      }
    } catch (e) {
      log("Error in API$e");
      if (e.toString().startsWith("SocketException")) {
        //no inter net case
        return PixabayResponse(code: 200);
      } else {
        return PixabayResponse(code: 500);
      }
    }
  }
}
