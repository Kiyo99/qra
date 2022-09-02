import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:qra/presentation/auth/register_page.dart';
import 'package:qra/presentation/generate/generator.dart';

class LoginPage extends HookConsumerWidget {
  LoginPage({Key? key}) : super(key: key);

  static const id = 'login';

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final auth = FirebaseAuth.instance;
  final store = FirebaseFirestore.instance;
  final isLoading = useState(false);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'QRA',
            style: GoogleFonts.exo2(),
          ),
          backgroundColor: Colors.blueGrey.shade800,
        ),
        body: isLoading.value == false
            ? Container(
                color: Colors.blueGrey.shade900,
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          'Sign in',
                          style: GoogleFonts.exo2(
                              color: Colors.white, fontSize: 25),
                        )),
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: TextField(
                        controller: emailController,
                        decoration: InputDecoration(
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            border: const OutlineInputBorder(),
                            labelText: 'Email',
                            labelStyle: GoogleFonts.exo2(color: Colors.white)),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: TextField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                            enabledBorder: const OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.white),
                            ),
                            border: const OutlineInputBorder(),
                            labelText: 'Password',
                            labelStyle: GoogleFonts.exo2(color: Colors.white)),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        //forgot password screen
                      },
                      child: Text(
                        'Forgot Password?',
                        style: GoogleFonts.exo2(color: Colors.blue),
                      ),
                    ),
                    Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: ElevatedButton(
                          child: Text('Login',
                              style: GoogleFonts.exo2(
                                  color: Colors.white, fontSize: 18)),
                          onPressed: () async {
                            //todo All of these should be done in the viewmodel.
                            //todo cache the user using shared preferences so that the user doesnt have to log in multiple times

                            print(emailController.text);
                            print(passwordController.text);
                            isLoading.value = true;

                            final user = await auth.signInWithEmailAndPassword(
                                email: emailController.text,
                                password: passwordController.text);

                            isLoading.value = false;
                            print("objectttttt: $user");
                            if (user == null) {
                              Get.dialog(const AlertDialog(
                                  title: Text(
                                    "Login failed 😪",
                                    textAlign: TextAlign.center,
                                  ),
                                  content: Text(
                                    "Please try again",
                                    textAlign: TextAlign.center,
                                  ),
                                  contentPadding: EdgeInsets.all(10)));
                            } else {
                              print("Singrdddd: ${user.user}");
                              Get.to(QrGenerator());
                            }
                            // Map<String, dynamic> userDetail = {
                            //   "Full name": user.user.
                            // };



                            print("objectttttt: ${user.user}");
                          },
                        )),
                    Row(
                      children: <Widget>[
                        Text(
                          'Don\'t have account?',
                          style: GoogleFonts.exo2(color: Colors.white),
                        ),
                        TextButton(
                          child: Text(
                            'Sign up',
                            style: GoogleFonts.exo2(
                                color: Colors.blue, fontSize: 20),
                          ),
                          onPressed: () {
                            Get.to(RegisterPage());
                            //signup screen
                          },
                        )
                      ],
                      mainAxisAlignment: MainAxisAlignment.center,
                    ),
                  ],
                ),
              )
            : const Center(child: CircularProgressIndicator()));
  }
}
