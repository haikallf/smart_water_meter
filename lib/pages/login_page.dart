import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:iconoir_flutter/iconoir_flutter.dart' as iconoir;
import 'package:smart_water_meter/components/custom_button.dart';
import 'package:smart_water_meter/components/custom_passwordfield.dart';
import 'package:smart_water_meter/components/custom_snackbar.dart';
import 'package:smart_water_meter/components/custom_textfield.dart';
import 'package:smart_water_meter/controllers/auth.dart';
import 'package:smart_water_meter/enums/color_constant.dart';
import 'package:smart_water_meter/enums/text_style_constant.dart';
import 'package:smart_water_meter/models/user_response_model.dart';
import 'package:smart_water_meter/pages/home_page.dart';
import 'package:smart_water_meter/utils/local_storage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // @override
  // void initState() {
  //   super.initState();

  //   Future.delayed(Duration(seconds: 3))
  //       .then((value) => {FlutterNativeSplash.remove()});
  // }

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool isEmailFieldFocus = false;
  bool isPasswordFieldFocus = false;
  String email = "";
  String password = "";
  String snackBarMessage = "";

  final authController = AuthController();
  var sessionManager = SessionManager();

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

  void setSnackBarMessage(String message) {
    setState(() {
      snackBarMessage = message;
    });
  }

  bool isEmailValid(String email) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    void signIn(BuildContext context) async {
      if (isEmailValid(email)) {
        UserResponseModel response =
            await authController.signIn(email, password);

        if (response.responseStatusCode == 400) {
          setSnackBarMessage("Login Gagal!");
          if (context.mounted) {
            ScaffoldMessenger.of(context)
                .showSnackBar(CustomSnackBar().showSnackBar(snackBarMessage));
          }
          setSnackBarMessage("");
        } else {
          await LocalStorage.setFullName('${response.currentUser?.name}');
          await sessionManager.set("token", response.currentUser?.token);
          if (context.mounted) {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => HomePage()));
          }
        }
      } else {
        setSnackBarMessage("Email tidak valid");
        ScaffoldMessenger.of(context)
            .showSnackBar(CustomSnackBar().showSnackBar(snackBarMessage));
        setSnackBarMessage("");
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
