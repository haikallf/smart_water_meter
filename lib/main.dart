import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:smart_water_meter/enums/color_constant.dart';
import 'package:smart_water_meter/pages/home_page.dart';
import 'package:smart_water_meter/pages/login_page.dart';
import 'package:smart_water_meter/utils/local_storage.dart';
import 'package:permission_handler/permission_handler.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  await LocalStorage.init();
  dynamic isLoggedIn = await SessionManager().containsKey("token");

  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  runApp(MaterialApp(
    title: 'Flutter Demo',
    theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: ColorConstant.colorsprimary,
          primary: Colors.white,
          secondary: Colors.black,
        ),
        appBarTheme: const AppBarTheme(
          color: Colors.white,
          //other options
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
                overlayColor: MaterialStateProperty.all<Color>(
                    Colors.white.withOpacity(0.1)))),
        iconButtonTheme: IconButtonThemeData(
            style: ButtonStyle(
                overlayColor: MaterialStateProperty.all<Color>(
                    Colors.grey.withOpacity(0.05)))),
        textSelectionTheme: const TextSelectionThemeData(
            cursorColor: ColorConstant.colorsprimary)),
    home: isLoggedIn ? HomePage() : LoginPage(),
  ));

  Future.delayed(Duration(seconds: 2))
      .then((value) => {FlutterNativeSplash.remove()});

  await Permission.notification.isDenied.then((value) {
    if (value) {
      Permission.notification.request();
    }
  });
}
