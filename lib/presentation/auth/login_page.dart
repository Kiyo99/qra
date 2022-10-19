import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:qra/constants.dart';
import 'package:qra/presentation/auth/register_page.dart';
import 'package:qra/presentation/staff/staff_page/staff_page.dart';

class LoginPage extends HookConsumerWidget {
  LoginPage({Key? key}) : super(key: key);

  static const id = 'login';

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final auth = FirebaseAuth.instance;
  final store = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = useState(false);
    return Scaffold(
        backgroundColor: Constants.coolBlue,
        body: isLoading.value == false
            ? Container(
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
                        cursorColor: Constants.coolOrange,
                        controller: emailController,
                        decoration: InputDecoration(
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Constants.coolOrange)),
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
                        cursorColor: Constants.coolOrange,
                        decoration: InputDecoration(
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Constants.coolOrange)),
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
                        style: GoogleFonts.exo2(color: Constants.coolOrange),
                      ),
                    ),
                    Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: TextButton(
                        onPressed: () async {
                          //todo All of these should be done in the viewmodel.
                          //todo cache the user using shared preferences so that the user doesnt have to log in multiple times

                          if (emailController.text.isEmpty ||
                              passwordController.text.isEmpty) {
                            print("Please enter all fields");
                            _showToast(context, 'Please enter all fields');
                            // const AlertDialog(
                            //   title: Text("Please enter all fields"),
                            // );
                            return;
                          }

                          isLoading.value = true;

                          try {
                            await auth.signInWithEmailAndPassword(
                                email: emailController.text,
                                password: passwordController.text);
                            isLoading.value = false;
                            Get.offAllNamed(StaffPage.id);
                          } on FirebaseAuthException catch (e) {
                            isLoading.value = false;
                            Get.dialog(
                              AlertDialog(
                                  title: const Text(
                                    "Login failed 😪",
                                    textAlign: TextAlign.center,
                                  ),
                                  content: Text(
                                    "${e.message}",
                                    textAlign: TextAlign.center,
                                  ),
                                  contentPadding: const EdgeInsets.all(10)),
                            );
                          }
                        },
                        child: Text('Login',
                            style: GoogleFonts.exo2(
                                color: Constants.blueish,
                                fontWeight: FontWeight.w600)),
                        style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 15),
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                width: 1,
                                color: Constants.coolOrange,
                              ),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            backgroundColor: Constants.coolOrange),
                      ),
                    ),
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
                                color: Constants.coolOrange, fontSize: 20),
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
            : Center(
                child: CircularProgressIndicator(color: Constants.coolOrange)));
  }
}

void _showToast(BuildContext context, String message) {
  final scaffold = ScaffoldMessenger.of(context);
  scaffold.showSnackBar(
    SnackBar(
      content: Text(message),
      action: SnackBarAction(
          label: 'Got it', onPressed: scaffold.hideCurrentSnackBar),
    ),
  );
}
