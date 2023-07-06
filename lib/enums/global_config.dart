import "dart:io" show Platform;

class GlobalConfig {
  const GlobalConfig();

  static String baseUrl =
      Platform.isAndroid ? "http://10.0.2.2:8000" : "http://localhost:8000";
}
