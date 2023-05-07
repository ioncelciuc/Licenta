import 'dart:convert';
import 'dart:developer';

import 'package:flutter_app/network/response/response.dart';
import 'package:flutter_app/utils/dotenv_paths.dart';
import 'package:http/http.dart' as http;

class ImageHelper {
  static Future<Response> getImage(String cardId) async {
    try {
      String path = '${DotEnvPaths().getImage()}/$cardId';
      http.Response res = await http.get(Uri.parse(path));
      final jsonList = jsonDecode(res.body);
      final json = jsonList[0];
      final image = json['image_url'];
      return Response(success: true, obj: image);
    } catch (e) {
      String message = "Error on download cards!";
      log(message, error: e);
      return Response(
        success: false,
        message: message,
      );
    }
  }

  static Future<Response> getImageSmall(String cardId) async {
    try {
      String path = '${DotEnvPaths().getImageSmall()}/$cardId';
      http.Response res = await http.get(Uri.parse(path));
      final jsonList = jsonDecode(res.body);
      final json = jsonList[0];
      final image = json['image_url_small'];
      return Response(success: true, obj: image);
    } catch (e) {
      String message = "Error on download cards!";
      log(message, error: e);
      return Response(
        success: false,
        message: message,
      );
    }
  }

  static Future<Response> getArtwork(String cardId) async {
    try {
      String path = '${DotEnvPaths().getImageCropped()}/$cardId';
      log(path);
      http.Response res = await http.get(Uri.parse(path));
      final jsonList = jsonDecode(res.body);
      final json = jsonList[0];
      final image = json['image_url_cropped'];
      return Response(success: true, obj: image);
    } catch (e) {
      String message = "Error on download cards!";
      log(message, error: e);
      return Response(
        success: false,
        message: message,
      );
    }
  }
}
