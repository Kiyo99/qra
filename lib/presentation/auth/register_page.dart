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
import 'package:qra/presentation/auth/login_page.dart';
import 'package:qra/presentation/staff/staff_page/staff_page.dart';
import 'package:qra/presentation/student/student_page/student_page.dart';
import 'package:qra/presentation/widgets/app_dialogs.dart';
import 'package:qra/presentation/widgets/app_modal.dart';
import 'package:qra/presentation/widgets/app_text_field.dart';
import 'package:qra/presentation/widgets/primary_app_button.dart';

class RegisterPage extends HookConsumerWidget {
  RegisterPage({Key? key}) : super(key: key);

  static const id = "register";

  final TextEditingController emailController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController iDController = TextEditingController();
  final TextEditingController majorController = TextEditingController();
  final TextEditingController numberController = TextEditingController();
  final TextEditingController cPasswordController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final auth = FirebaseAuth.instance;
  final _fireStore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final brightness = Theme.of(context).brightness;
    final isLoading = useState(false);
    final statusItems = useState(["Registering as ...", "Student", "Staff"]);
    final selectedStatusValue = useState(statusItems.value[0]);

    final genderItems = useState(["Gender ...", "Male", "Female"]);
    final selectedGenderValue = useState(genderItems.value[0]);

    final registeringAsStaff = useState(false);

    return Scaffold(
        body: isLoading.value == false
            ? Padding(
                padding: const EdgeInsets.all(10),
                child: ListView(
                  children: <Widget>[
                    Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          'QRA',
                          style: TextStyle(
                              color: Constants.coolOrange,
                              fontWeight: FontWeight.w500,
                              fontSize: 30),
                        )),
                    Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          "Let's get you registered 😃",
                          style: GoogleFonts.exo2(fontSize: 28),
                        )),
                    const SizedBox(height: 50),
                    Container(
                      height: 55,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: brightness == Brightness.light
                                ? Constants.coolBlue
                                : Constants.coolWhite),
                        borderRadius: BorderRadius.circular(
                          15.0,
                        ),
                      ),
                      child: DropdownButtonFormField(
                        items: statusItems.value
                            .map<DropdownMenuItem<String>>(
                                (String value) => DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(
                                        value,
                                        style: GoogleFonts.exo(
                                            color:
                                                brightness == Brightness.light
                                                    ? Constants.coolBlue
                                                    : Constants.coolWhite),
                                      ),
                                    ))
                            .toList(),
                        value: selectedStatusValue.value,
                        focusColor: Colors.white,
                        iconEnabledColor: Constants.coolOrange,
                        style: GoogleFonts.exo2(fontSize: 16),
                        dropdownColor: brightness == Brightness.light
                            ? Constants.coolWhite
                            : Constants.coolBlue,
                        onChanged: (val) {
                          selectedStatusValue.value = val.toString();
                          if (selectedStatusValue.value == "Staff") {
                            registeringAsStaff.value = true;
                          } else {
                            registeringAsStaff.value = false;
                          }
                        },
                      ),
                    ),
                    AppTextField(
                      controller: emailController,
                      title: "Email",
                    ),
                    AppTextField(
                      controller: firstNameController,
                      title: "First Name",
                    ),
                    AppTextField(
                      controller: lastNameController,
                      title: "Last Name",
                    ),
                    AppTextField(
                      controller: iDController,
                      title:
                          registeringAsStaff.value ? "Staff ID" : "Student ID",
                    ),
                    registeringAsStaff.value
                        ? const SizedBox()
                        : AppTextField(
                            controller: majorController,
                            title: "Major",
                          ),
                    Container(
                      height: 55,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: brightness == Brightness.light
                                ? Constants.coolBlue
                                : Constants.coolWhite),
                        borderRadius: BorderRadius.circular(
                          15.0,
                        ),
                      ),
                      child: DropdownButtonFormField(
                        items: genderItems.value
                            .map<DropdownMenuItem<String>>(
                                (String value) => DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value,
                                          style: GoogleFonts.exo(
                                              color:
                                                  brightness == Brightness.light
                                                      ? Constants.coolBlue
                                                      : Constants.coolWhite)),
                                    ))
                            .toList(),
                        value: selectedGenderValue.value,
                        focusColor: Colors.white,
                        iconEnabledColor: Constants.coolOrange,
                        style: GoogleFonts.exo2(fontSize: 16),
                        dropdownColor: brightness == Brightness.light
                            ? Constants.coolWhite
                            : Constants.coolBlue,
                        onChanged: (val) {
                          selectedGenderValue.value = val.toString();
                        },
                      ),
                    ),
                    AppTextField(
                      controller: numberController,
                      title: "Phone number",
                    ),
                    AppTextField(
                        controller: passwordController,
                        title: "Password",
                        obscureText: true),
                    AppTextField(
                        controller: cPasswordController,
                        title: "Confirm Password",
                        obscureText: true),
                    const SizedBox(height: 50),
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
                      title: "Register",
                      onPressed: () async {
                        if (selectedStatusValue.value == "Registering as ...") {
                          Constants.showToast(
                              context, "Select what you're registering as");
                          return;
                        }

                        if (registeringAsStaff.value == true) {
                          if (emailController.text.isEmpty ||
                              firstNameController.text.isEmpty ||
                              lastNameController.text.isEmpty ||
                              passwordController.text.isEmpty ||
                              cPasswordController.text.isEmpty ||
                              iDController.text.isEmpty ||
                              numberController.text.isEmpty ||
                              selectedGenderValue.value == "Gender ...") {
                            Constants.showToast(
                                context, 'Please enter all fields');
                            return;
                          }

                          if (numberController.text.length < 10) {
                            Constants.showToast(
                                context, 'Please enter a valid phone number');
                            return;
                          }

                          if (!(passwordController.text ==
                              cPasswordController.text)) {
                            Constants.showToast(
                                context, 'Passwords don\'t match');
                            return;
                          }

                          if (passwordController.text.length < 6) {
                            Constants.showToast(context,
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
                            db['gender'] = selectedGenderValue.value;
                            db['iD'] = iDController.text;
                            db['phoneNumber'] = numberController.text;
                            db['status'] = selectedStatusValue.value;

                            _fireStore
                                .collection("Users")
                                .doc(auth.currentUser!.email.toString())
                                .set(db)
                                .whenComplete(() {
                              Constants.showToast(
                                  context, 'Successfully saved staff');

                              final user = AppUser.fromJson(db);
                              ref
                                  .read(AuthLocalDataSource.provider)
                                  .cacheUser(user);
                              isLoading.value = false;

                              Get.offAllNamed(StaffPage.id);
                            }).catchError((error, stackTrace) => () {
                                      Constants.showToast(
                                          context, 'Failed to save 😪');
                                      print('Failed: $error');
                                    });
                          } on FirebaseAuthException catch (e) {
                            isLoading.value = false;
                            AppModal.showModal(
                              context: context,
                              title: "Registration failed 😪",
                              message: e.message!,
                              asset: "assets/lottie/error.json",
                              primaryAction: () => Get.back(),
                              buttonText: "Okay",
                            );
                          }
                        } else {
                          if (emailController.text.isEmpty ||
                              firstNameController.text.isEmpty ||
                              lastNameController.text.isEmpty ||
                              passwordController.text.isEmpty ||
                              cPasswordController.text.isEmpty ||
                              majorController.text.isEmpty ||
                              iDController.text.isEmpty ||
                              numberController.text.isEmpty ||
                              selectedStatusValue.value ==
                                  "Registering as ..." ||
                              selectedGenderValue.value == "Gender ...") {
                            Constants.showToast(
                                context, 'Please enter all fields');
                            return;
                          }

                          if (numberController.text.length < 10) {
                            Constants.showToast(
                                context, 'Please enter a valid phone number');
                            return;
                          }

                          if (!(passwordController.text ==
                              cPasswordController.text)) {
                            Constants.showToast(
                                context, 'Passwords don\'t match');
                            return;
                          }

                          if (passwordController.text.length < 6) {
                            Constants.showToast(context,
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
                            db['gender'] = selectedGenderValue.value;
                            db['iD'] = iDController.text;
                            db['major'] = majorController.text;
                            db['isEligible'] = "false";
                            db['phoneNumber'] = numberController.text;
                            db['status'] = selectedStatusValue.value;

                            _fireStore
                                .collection("Users")
                                .doc(auth.currentUser!.email.toString())
                                .set(db)
                                .whenComplete(() {
                              Constants.showToast(
                                  context, 'Successfully saved student');

                              final user = AppUser.fromJson(db);
                              ref
                                  .read(AuthLocalDataSource.provider)
                                  .cacheUser(user);
                              isLoading.value = false;
                              Get.offAllNamed(StudentPage.id);
                            }).catchError((error, stackTrace) => () {
                                      Constants.showToast(
                                          context, 'Failed to save 😪');
                                      print('Failed: $error');
                                    });
                          } on FirebaseAuthException catch (e) {
                            isLoading.value = false;
                            AppModal.showModal(
                              context: context,
                              title: "Registration failed 😪",
                              message: e.message!,
                              asset: "assets/lottie/error.json",
                              primaryAction: () => Get.back(),
                              buttonText: "Okay",
                            );
                          }
                        }
                      },
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                    ),
                    Row(
                      children: <Widget>[
                        const Text('Have an account?'),
                        TextButton(
                          child: Text(
                            'Sign in',
                            style: GoogleFonts.exo2(
                                color: Constants.coolOrange, fontSize: 20),
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
            : Center(
                child: AppDialogs.loader(),
              ));
  }
}
