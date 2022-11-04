import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qra/constants.dart';
import 'package:qra/data/fb_student_model/student_model.dart';

class StudentDetailPage extends HookWidget {
  static const id = "/student_detail_page";

  const StudentDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;

    final studentModel = useState<StudentModel>(Get.arguments);

    // final coursePrice = Container(
    //   padding: const EdgeInsets.all(7.0),
    //   decoration: BoxDecoration(
    //       border: Border.all(color: Colors.white),
    //       borderRadius: BorderRadius.circular(5.0)),
    //   child: Text(
    //     "\$" + lesson.price.toString(),
    //     style: const TextStyle(color: Colors.white),
    //   ),
    // );

    final topContentText = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(height: 10.0),
        const Icon(
          Icons.account_circle_outlined,
          color: Colors.white,
          size: 40.0,
        ),
        const SizedBox(
          width: 90.0,
          child: Divider(color: Colors.green),
        ),
        const SizedBox(height: 10.0),
        Text(
          studentModel.value.fullName,
          style: const TextStyle(color: Colors.white, fontSize: 45.0),
        ),
        const SizedBox(height: 30.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
                flex: 3,
                child: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(
                      studentModel.value.iD,
                      style: const TextStyle(color: Colors.white),
                    ))),
          ],
        ),
      ],
    );

    final topContent = Stack(
      children: <Widget>[
        Container(
            padding: const EdgeInsets.only(left: 10.0),
            height: MediaQuery.of(context).size.height * 0.5,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/qra_logo.jpg"),
                fit: BoxFit.cover,
              ),
            )),
        Container(
          height: MediaQuery.of(context).size.height * 0.5,
          padding: const EdgeInsets.all(40.0),
          width: MediaQuery.of(context).size.width,
          decoration:
              const BoxDecoration(color: Color.fromRGBO(58, 66, 86, .9)),
          child: Center(
            child: topContentText,
          ),
        ),
        Positioned(
          left: 8.0,
          top: 60.0,
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back, color: Colors.white),
          ),
        )
      ],
    );

    final bottomContentText = Text(
      studentModel.value.major,
      style: GoogleFonts.exo(fontSize: 22),
    );
    // final readButton = Container(
    //     padding: const EdgeInsets.symmetric(vertical: 16.0),
    //     decoration: BoxDecoration(
    //       borderRadius: BorderRadius.circular(20),
    //     ),
    //     width: MediaQuery.of(context).size.width,
    //     child: RaisedButton(
    //       onPressed: () => {},
    //       color: const Color.fromRGBO(58, 66, 86, 1.0),
    //       child: const Text("Mark this student",
    //           style: TextStyle(color: Colors.white)),
    //     ));

    final readButton = Container(
      padding: const EdgeInsets.symmetric(vertical: 25.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      width: MediaQuery.of(context).size.width,
      child: GestureDetector(
        onTap: () {
          print("This was clicked");
        },
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            border: Border.all(
                color: brightness == Brightness.light
                    ? Constants.coolBlue
                    : Constants.coolWhite),
            borderRadius: BorderRadius.circular(20),
          ),
          height: 60,
          child: Center(
            child: Text(
              "Mark this student",
              style: GoogleFonts.exo(fontSize: 18, color: Constants.coolOrange),
            ),
          ),
        ),
      ),
    );

    final bottomContent = Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(40.0),
      child: Center(
        child: Column(
          children: <Widget>[bottomContentText, readButton],
        ),
      ),
    );

    return Scaffold(
      body: Column(
        children: <Widget>[topContent, bottomContent],
      ),
    );
  }
}
