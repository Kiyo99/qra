import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:qra/constants.dart';
import 'package:qra/presentation/detail.dart';
import 'package:qra/data/lesson.dart';

class MakeBody extends HookConsumerWidget {
  static const id = "/MakeBody";

  const MakeBody({Key? key}) : super(key: key);

  //todo: You will have to accept arguments here

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Lesson> getLessons() {
      return [
        Lesson(
            title: "Godsfavour Ngo Kio",
            level: "218CS01004885",
            indicatorValue: 1,
            price: 20,
            checked: false,
            content:
                "Godsfavour Ngo Kio is from the Computer Science department. In level 300 having courses in Cos3, Cose33 this semester."),
        Lesson(
            title: "Bernice Yevugah",
            level: "222CS bla bla bla",
            indicatorValue: 0.70,
            price: 50,
            checked: false,
            content: "She is my first wife, fullstop"),
        Lesson(
            title: "Emefa Jemimah Atikpu",
            level: "221IT Bla bla bla",
            indicatorValue: 0.66,
            price: 30,
            checked: false,
            content: "This one is just a rat. A sexy rat"),
        Lesson(
            title: "Reversing around the corner",
            level: "Intermidiate",
            indicatorValue: 0.66,
            price: 30,
            checked: false,
            content:
                "Start by taking a couple of minutes to read the info in this section. Launch your app and click on the Settings menu.  While on the settings page, click the Save button.  You should see a circular progress indicator display in the middle of the page and the user interface elements cannot be clicked due to the modal barrier that is constructed."),
        Lesson(
            title: "Incorrect Use of Signal",
            level: "Advanced",
            indicatorValue: 1.0,
            price: 50,
            checked: false,
            content:
                "Start by taking a couple of minutes to read the info in this section. Launch your app and click on the Settings menu.  While on the settings page, click the Save button.  You should see a circular progress indicator display in the middle of the page and the user interface elements cannot be clicked due to the modal barrier that is constructed."),
        Lesson(
            title: "Engine Challenges",
            level: "Advanced",
            indicatorValue: 1.0,
            price: 50,
            checked: false,
            content:
                "Start by taking a couple of minutes to read the info in this section. Launch your app and click on the Settings menu.  While on the settings page, click the Save button.  You should see a circular progress indicator display in the middle of the page and the user interface elements cannot be clicked due to the modal barrier that is constructed."),
        Lesson(
            title: "Self Driving Car",
            level: "Advanced",
            indicatorValue: 1.0,
            checked: false,
            price: 50,
            content:
                "Start by taking a couple of minutes to read the info in this section. Launch your app and click on the Settings menu.  While on the settings page, click the Save button.  You should see a circular progress indicator display in the middle of the page and the user interface elements cannot be clicked due to the modal barrier that is constructed.  ")
      ];
    }

    List<Lesson> lessons = getLessons();
    final l = lessons[0];
    print("Value of lessons: ${l}");

    final checkItem = useState(lessons);

    // ListTile makeListTile(Lesson lesson) {
    //   checkItem.value = lesson.checked;
    //
    //   return ListTile(
    //     contentPadding:
    //         const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
    //     leading: Container(
    //         padding: const EdgeInsets.only(right: 5.0),
    //         decoration: const BoxDecoration(
    //             border: Border(
    //                 right: BorderSide(width: 1.0, color: Colors.white24))),
    //         child: Checkbox(
    //           shape: RoundedRectangleBorder(
    //             borderRadius: BorderRadius.circular(5),
    //           ),
    //           value: checkItem.value,
    //           onChanged: (v) {
    //             checkItem.value = v!;
    //           },
    //         )),
    //     title: Text(
    //       lesson.title,
    //       style:
    //           const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
    //     ),
    //     // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),
    //
    //     subtitle: Row(
    //       children: <Widget>[
    //         Expanded(
    //             flex: 1,
    //             child: LinearProgressIndicator(
    //                 backgroundColor: const Color.fromRGBO(209, 224, 224, 0.2),
    //                 value: lesson.indicatorValue,
    //                 valueColor: const AlwaysStoppedAnimation(Colors.green))),
    //         Expanded(
    //           flex: 4,
    //           child: Padding(
    //               padding: const EdgeInsets.only(left: 10.0),
    //               child: Text(lesson.level,
    //                   style: const TextStyle(color: Colors.white))),
    //         )
    //       ],
    //     ),
    //     trailing: const Icon(Icons.keyboard_arrow_right,
    //         color: Colors.white, size: 30.0),
    //     onTap: () {
    //       Navigator.push(
    //           context,
    //           MaterialPageRoute(
    //               builder: (context) => DetailPage(
    //                     lesson: lesson,
    //                   )));
    //     },
    //   );
    // }

    Card makeCard(Lesson lesson) => Card(
          elevation: 4.0,
          color: Constants.coolBlue,
          margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
          child: Container(
            decoration: const BoxDecoration(
                color: Color.fromRGBO(64, 75, 96, .9),
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: ListTile(
              contentPadding:
              const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
              leading: Container(
                  padding: const EdgeInsets.only(right: 5.0),
                  decoration: const BoxDecoration(
                      border: Border(
                          right: BorderSide(width: 1.0, color: Colors.white24))),
                  child: Checkbox(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    value: checkItem.value[0].checked,
                    onChanged: (v) {
                      checkItem.value[0].checked = v!;
                      print("Lesson is: ${lesson.title}");
                      // checkItem.value = v;
                    },
                  )),
              title: Text(
                lesson.title,
                style:
                const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

              subtitle: Row(
                children: <Widget>[
                  Expanded(
                      flex: 1,
                      child: LinearProgressIndicator(
                          backgroundColor: const Color.fromRGBO(209, 224, 224, 0.2),
                          value: lesson.indicatorValue,
                          valueColor: const AlwaysStoppedAnimation(Colors.green))),
                  Expanded(
                    flex: 4,
                    child: Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text(lesson.level,
                            style: const TextStyle(color: Colors.white))),
                  )
                ],
              ),
              trailing: const Icon(Icons.keyboard_arrow_right,
                  color: Colors.white, size: 30.0),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DetailPage(
                          lesson: lesson,
                        )));
              },
            ),
          ),
        );

    return Scaffold(
      appBar: AppBar(
        elevation: 0.1,
        backgroundColor: const Color(0xff3A4256),
        title: const Text("Qra"),
      ),
      backgroundColor: Constants.coolBlue,
      body: RefreshIndicator(
        onRefresh: () {
          print("Refreshed!");
          print(lessons);
          return Future.value(0);
        },
        child: ListView.builder(
          padding: const EdgeInsets.all(8),
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: checkItem.value.length,
          itemBuilder: (BuildContext context, int index) {
            return makeCard(checkItem.value[index]);
            // return CheckboxListTile(
            //   value: checkItem.value[index].checked,
            //   controlAffinity: ListTileControlAffinity.leading,
            //   contentPadding: EdgeInsets.zero,
            //   onChanged: (v) {
            //     // for (var element in checkItem.value) {
            //     //   element.checked = false;
            //     // }
            //     checkItem.value[index].checked = v!;
            //     // reason.value = checkItem.value[index]["title"];
            //   },
            //   title: Text(checkItem.value[index].title),
            // );

          },
        ),
      ),
    );
  }
}

// class Caleb extends HookWidget {
//   @override
//   Widget build(BuildContext context) {
//     return
//   }
// }
