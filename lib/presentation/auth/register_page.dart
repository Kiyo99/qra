import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:qra/constants.dart';
import 'package:qra/presentation/auth/login_page.dart';
import 'package:qra/presentation/staff/staff_page/staff_page.dart';

class RegisterPage extends HookConsumerWidget {
  RegisterPage({Key? key}) : super(key: key);

  static const id = "register";

  final TextEditingController emailController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController iDController = TextEditingController();
  final TextEditingController majorController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController numberController = TextEditingController();
  final TextEditingController cPasswordController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = useState(false);
    return Scaffold(
        backgroundColor: Constants.coolBlue,
        body: isLoading.value == false
            ? Padding(
                padding: const EdgeInsets.all(10),
                child: ListView(
                  children: <Widget>[
                    Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(10),
                        child: const Text(
                          'QRA',
                          style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.w500,
                              fontSize: 30),
                        )),
                    Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          "Let's get you registered 😃",
                          style: GoogleFonts.exo2(
                              fontSize: 28, color: Colors.white),
                        )),
                    const SizedBox(height: 50),
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
                        controller: firstNameController,
                        decoration: InputDecoration(
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            border: const OutlineInputBorder(),
                            labelText: 'First Name',
                            labelStyle: GoogleFonts.exo2(color: Colors.white)),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: TextField(
                        controller: lastNameController,
                        decoration: InputDecoration(
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            border: const OutlineInputBorder(),
                            labelText: 'Last Name',
                            labelStyle: GoogleFonts.exo2(color: Colors.white)),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: TextField(
                        controller: iDController,
                        decoration: InputDecoration(
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            border: const OutlineInputBorder(),
                            labelText: 'Student ID',
                            labelStyle: GoogleFonts.exo2(color: Colors.white)),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: TextField(
                        controller: majorController,
                        decoration: InputDecoration(
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            border: const OutlineInputBorder(),
                            labelText: 'Major',
                            labelStyle: GoogleFonts.exo2(color: Colors.white)),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: TextField(
                        controller: genderController,
                        decoration: InputDecoration(
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            border: const OutlineInputBorder(),
                            labelText: 'Gender',
                            labelStyle: GoogleFonts.exo2(color: Colors.white)),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: TextField(
                        controller: numberController,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            border: const OutlineInputBorder(),
                            labelText: 'Phone number',
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
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: TextField(
                        controller: cPasswordController,
                        obscureText: true,
                        decoration: InputDecoration(
                            enabledBorder: const OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.white),
                            ),
                            border: const OutlineInputBorder(),
                            labelText: 'Confirm Password',
                            labelStyle: GoogleFonts.exo2(color: Colors.white)),
                      ),
                    ),
                    const SizedBox(height: 50),
                    TextButton(
                      onPressed: () {
                        //forgot password screen
                      },
                      child: const Text(
                        'Forgot Password',
                      ),
                    ),
                    Container(
                      height: 50,
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: ElevatedButton(
                        child: const Text('Regsiter'),
                        onPressed: () async {
                          if (emailController.text.isEmpty ||
                              firstNameController.text.isEmpty ||
                              lastNameController.text.isEmpty ||
                              passwordController.text.isEmpty ||
                              cPasswordController.text.isEmpty ||
                              majorController.text.isEmpty ||
                              genderController.text.isEmpty ||
                              iDController.text.isEmpty ||
                              numberController.text.isEmpty) {
                            _showToast(context, 'Please enter all fields');
                            return;
                          }

                          if (numberController.text.length < 10) {
                            _showToast(
                                context, 'Please enter a valid phone number');
                            return;
                          }

                          if (!(passwordController.text ==
                              cPasswordController.text)) {
                            _showToast(context, 'Passwords don\'t match');
                            return;
                          }

                          if (passwordController.text.length < 6) {
                            _showToast(context,
                                'Password should not be less than 6 characters');
                            return;
                          }

                          isLoading.value = true;

                          try {
                            await auth.createUserWithEmailAndPassword(
                                email: emailController.text,
                                password: cPasswordController.text);

                            Map<String, Object> db = {};
                            db['firstName'] = firstNameController.text;
                            db['lastName'] = lastNameController.text;
                            db['fullName'] =
                                "${firstNameController.text} ${lastNameController.text}";
                            db['email'] = emailController.text;
                            db['gender'] = genderController.text;
                            db['iD'] = iDController.text;
                            db['major'] = majorController.text;
                            db['isEligible'] = "false";
                            db['phoneNumber'] = numberController.text;
                            db['status'] = "Student";

                            _firestore
                                .collection("Users")
                                .doc(auth.currentUser!.email.toString())
                                .set(db)
                                .whenComplete(() {
                              _showToast(context, 'Successfully saved user');
                              isLoading.value = false;
                              Get.offAllNamed(StaffPage.id);
                            }).catchError((error, stackTrace) => () {
                                      _showToast(context, 'Failed to save 😪');
                                      print('Failed: $error');
                                    });
                          } on FirebaseAuthException catch (e) {
                            isLoading.value = false;
                            Get.dialog(
                              AlertDialog(
                                  title: const Text(
                                    "Registration failed 😪",
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
                    ),
                    Row(
                      children: <Widget>[
                        const Text('Does not have account?'),
                        TextButton(
                          child: const Text(
                            'Sign in',
                            style: TextStyle(fontSize: 20),
                          ),
                          onPressed: () {
                            Get.to(LoginPage());
                            //signup screen
                          },
                        )
                      ],
                      mainAxisAlignment: MainAxisAlignment.center,
                    ),
                  ],
                ))
            : const Center(child: CircularProgressIndicator()));
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
