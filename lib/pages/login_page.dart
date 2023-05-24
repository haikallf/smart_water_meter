import 'package:flutter/material.dart';
import 'package:smart_water_meter/components/custom_button.dart';
import 'package:smart_water_meter/components/custom_passwordfield.dart';
import 'package:smart_water_meter/components/custom_textfield.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void signIn() {}

  @override
  Widget build(BuildContext context) {
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
                  const Text("Email"),
                  CustomTextField(
                    controller: emailController,
                    hintText: "contoh@email.com",
                    obscureText: false,
                    prefixIcon: Icon(Icons.person_outline),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text("Password"),
                  CustomPasswordField(
                    controller: passwordController,
                    hintText: "······",
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomButton(
                    onTap: signIn,
                    text: "Masuk",
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
