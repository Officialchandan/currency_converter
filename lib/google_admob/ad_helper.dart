import 'dart:io';

class AdHelper {
  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-3096560792937908~8277815192';
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }
}
