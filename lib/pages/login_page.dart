import 'package:flutter/material.dart';
import 'package:smart_water_meter/components/custom_button.dart';
import 'package:smart_water_meter/components/custom_passwordfield.dart';
import 'package:smart_water_meter/components/custom_textfield.dart';
import 'package:smart_water_meter/pages/home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool isLoginButtonDisabled() {
    return (email == "" && password == "");
  }

  bool isEmailFieldFocus = false;
  bool isPasswordFieldFocus = false;
  String email = "";
  String password = "";

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
    void signIn() {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomePage()));
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
                  const Text(
                    "Masuk",
                    style: TextStyle(fontSize: 31, fontWeight: FontWeight.w600),
                  ),
                  const Text(
                    "Masuk untuk mengakses alat kamu",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Text(
                    "Email",
                    style: TextStyle(
                        color: isEmailFieldFocus ? Colors.blue : Colors.black),
                  ),
                  CustomTextField(
                    controller: handleEmailChange,
                    hintText: "contoh@email.com",
                    obscureText: false,
                    prefixIcon: Icon(Icons.person_outline,
                        color: isEmailFieldFocus ? Colors.blue : Colors.black),
                    formFocusHandler: handleEmailFieldFocusChange,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text("Password",
                      style: TextStyle(
                          color: isPasswordFieldFocus
                              ? Colors.blue
                              : Colors.black)),
                  CustomPasswordField(
                    controller: handlePasswordChange,
                    hintText: "···········",
                    formFocusHandler: handlePasswordFieldFocusChange,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  AbsorbPointer(
                    absorbing: isLoginButtonDisabled(),
                    child: CustomButton(
                      onTap: signIn,
                      text: "Masuk",
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
