import 'package:url_launcher/url_launcher.dart';

class MapUtils {
  static String? latitude;
  static String? longitude;

  static void init(String lat, String long) {
    latitude = lat;
    longitude = long;
  }

  static Future<void> openMap() async {
    if (latitude != null && longitude != null) {
      String googleUrl =
          'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
      if (await canLaunch(googleUrl)) {
        await launch(googleUrl);
      } else {
        throw 'Could not open the map.';
      }
    }
  }
}
