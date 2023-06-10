import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:iconoir_flutter/iconoir_flutter.dart' as iconoir;
import 'package:smart_water_meter/components/custom_button.dart';
import 'package:smart_water_meter/components/custom_passwordfield.dart';
import 'package:smart_water_meter/components/custom_textfield.dart';
import 'package:smart_water_meter/enums/color_constant.dart';
import 'package:smart_water_meter/enums/text_style_constant.dart';
import 'package:smart_water_meter/pages/home_page.dart';
import 'package:smart_water_meter/utils/local_storage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 3))
        .then((value) => {FlutterNativeSplash.remove()});
  }

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool isEmailFieldFocus = false;
  bool isPasswordFieldFocus = false;
  String email = "";
  String password = "";

  bool isLoginButtonDisabled() {
    return (email == "" || password == "");
  }

  void handleEmailFieldFocusChange(bool isFocused) {
    setState(() {
      isEmailFieldFocus = isFocused;
    });
  }

  void handlePasswordFieldFocusChange(bool isFocused) {
    setState(() {
      isPasswordFieldFocus = isFocused;
    });
  }

  void handleEmailChange(String value) {
    setState(() {
      email = value;
    });
  }

  void handlePasswordChange(String value) {
    setState(() {
      password = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    void signIn(BuildContext context) async {
      await LocalStorage.setEmail(email);
      if (context.mounted) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Container(
        padding:
            const EdgeInsets.only(top: 32, right: 16, bottom: 16, left: 16),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Masuk",
                    style: const TextStyleConstant().heading02,
                  ),
                  Text(
                    "Masuk untuk mengakses alat kamu",
                    style: const TextStyleConstant().paragraph02,
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Text("Email",
                      style: const TextStyleConstant().body03.copyWith(
                          color: isEmailFieldFocus
                              ? ColorConstant.colorsprimary
                              : ColorConstant.colorsNeutral50)),
                  const SizedBox(
                    height: 4,
                  ),
                  CustomTextField(
                    controller: handleEmailChange,
                    hintText: "contoh@email.com",
                    obscureText: false,
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(10),
                      child: iconoir.User(
                          color: isEmailFieldFocus
                              ? ColorConstant.colorsprimary
                              : Colors.black),
                    ),
                    formFocusHandler: handleEmailFieldFocusChange,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text("Kata Sandi",
                      style: const TextStyleConstant().body03.copyWith(
                          color: isPasswordFieldFocus
                              ? ColorConstant.colorsprimary
                              : ColorConstant.colorsNeutral50)),
                  const SizedBox(
                    height: 4,
                  ),
                  CustomPasswordField(
                    controller: handlePasswordChange,
                    hintText: "···········",
                    formFocusHandler: handlePasswordFieldFocusChange,
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  AbsorbPointer(
                    absorbing: isLoginButtonDisabled(),
                    child: CustomButton(
                      onTap: () {
                        signIn(context);
                      },
                      text: "Masuk",
                      isDisabled: isLoginButtonDisabled(),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}
