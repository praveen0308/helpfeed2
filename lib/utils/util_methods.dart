import 'dart:math' show cos, sqrt, asin;
import 'dart:typed_data';

import 'dart:ui' as ui;

import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class UtilMethods {
  static double calculateDistance(double lat1,double lon1, double lat2,double lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  static Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  static Future<void> openPhone(String number) async {
    Uri uri = Uri.parse('tel:$number');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);

    } else {
      throw 'Could not call.';
    }
  }


}
