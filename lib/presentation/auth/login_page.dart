import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:qra/constants.dart';
import 'package:qra/data/app_user/app_user.dart';
import 'package:qra/data/datasource/auth_local_datasource.dart';
import 'package:qra/presentation/auth/register_page.dart';
import 'package:qra/presentation/staff/staff_page/staff_page.dart';
import 'package:qra/presentation/student/student_page/student_page.dart';
import 'package:qra/presentation/widgets/app_dialogs.dart';
import 'package:qra/presentation/widgets/app_text_field.dart';
import 'package:qra/presentation/widgets/primary_app_button.dart';

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
                    AppTextField(
                      controller: emailController,
                      title: "Email",
                    ),
                    AppTextField(
                      controller: passwordController,
                      title: "Password",
                      obscureText: true,
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
                    PrimaryAppButton(
                      title: "Login",
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

                          //todo: Add something here like setting user destination

                          final studentsDoc = await store
                              .collection("Users")
                              .doc(emailController.text)
                              .get();

                          final user = AppUser.fromJson(studentsDoc.data()!);

                          ref
                              .read(AuthLocalDataSource.provider)
                              .cacheUser(user);

                          isLoading.value = false;

                          user.status == "Student"
                              ? Get.offAllNamed(StudentPage.id)
                              : Get.offAllNamed(StaffPage.id);
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
                child: Transform.scale(
                  scale: 1,
                  child: Lottie.asset(
                    "assets/lottie/loader.json",
                    frameRate: FrameRate(60),
                  ),
                ),
              ));
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
