import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:qra/constants.dart';
import 'package:qra/data/detail.dart';
import 'package:qra/data/lesson.dart';
import 'package:qra/presentation/auth/login_page.dart';
import 'package:qra/presentation/generate/generator_improved.dart';

class AttendancePage extends HookWidget {
  const AttendancePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    void navigate(BuildContext context) {
      Navigator.pushNamed(context, LoginPage.id);
    }

    List getLessons() {
      return [
        Lesson(
            title: "Godsfavour Ngo Kio",
            level: "218CS01004885",
            indicatorValue: 1,
            price: 20,
            content:
                "Godsfavour Ngo Kio is from the Computer Science department. In level 300 having courses in Cos3, Cose33 this semester."),
        Lesson(
            title: "Bernice Yevugah",
            level: "222CS bla bla bla",
            indicatorValue: 0.70,
            price: 50,
            content: "She is my first wife, fullstop"),
        Lesson(
            title: "Emefa Jemimah Atikpu",
            level: "221IT Bla bla bla",
            indicatorValue: 0.66,
            price: 30,
            content: "This one is just a rat. A sexy rat"),
        Lesson(
            title: "Reversing around the corner",
            level: "Intermidiate",
            indicatorValue: 0.66,
            price: 30,
            content:
                "Start by taking a couple of minutes to read the info in this section. Launch your app and click on the Settings menu.  While on the settings page, click the Save button.  You should see a circular progress indicator display in the middle of the page and the user interface elements cannot be clicked due to the modal barrier that is constructed."),
        Lesson(
            title: "Incorrect Use of Signal",
            level: "Advanced",
            indicatorValue: 1.0,
            price: 50,
            content:
                "Start by taking a couple of minutes to read the info in this section. Launch your app and click on the Settings menu.  While on the settings page, click the Save button.  You should see a circular progress indicator display in the middle of the page and the user interface elements cannot be clicked due to the modal barrier that is constructed."),
        Lesson(
            title: "Engine Challenges",
            level: "Advanced",
            indicatorValue: 1.0,
            price: 50,
            content:
                "Start by taking a couple of minutes to read the info in this section. Launch your app and click on the Settings menu.  While on the settings page, click the Save button.  You should see a circular progress indicator display in the middle of the page and the user interface elements cannot be clicked due to the modal barrier that is constructed."),
        Lesson(
            title: "Self Driving Car",
            level: "Advanced",
            indicatorValue: 1.0,
            price: 50,
            content:
                "Start by taking a couple of minutes to read the info in this section. Launch your app and click on the Settings menu.  While on the settings page, click the Save button.  You should see a circular progress indicator display in the middle of the page and the user interface elements cannot be clicked due to the modal barrier that is constructed.  ")
      ];
    }

    List lessons = getLessons();
    final _selectedIndex = useState(0);
    final checked = useState(false);
    PageController pageController = PageController();
    // final pageControl = usePageController();

    ListTile makeListTile(Lesson lesson) => ListTile(
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
                value: checked.value,
                onChanged: (v) {
                  checked.value = v!;
                },
              )),
          title: Text(
            lesson.title,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold),
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
        );

    Card makeCard(Lesson lesson) => Card(
          elevation: 4.0,
          color: Constants.coolBlue,
          margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
          child: Container(
            decoration: const BoxDecoration(
                color: Color.fromRGBO(64, 75, 96, .9),
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: makeListTile(lesson),
          ),
        );

    final ultimateBottom = BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.blur_on), label: "QR"),
        BottomNavigationBarItem(
            icon: Icon(Icons.account_box), label: "Profile"),
      ],
      backgroundColor: const Color(0xff3A4256),
      currentIndex: _selectedIndex.value,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.grey,
      showUnselectedLabels: false,
      onTap: (index) {
        _selectedIndex.value = index;
        // pageController.animateToPage(_selectedIndex.value, duration: const Duration(milliseconds: 1000), curve: Curves.bounceOut);
        pageController.jumpToPage(_selectedIndex.value);
      },
    );

    final makeBody = ListView.builder(
      padding: const EdgeInsets.all(8),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: lessons.length,
      itemBuilder: (BuildContext context, int index) {
        return makeCard(lessons[index]);
      },
    );

    final topAppBar = AppBar(
      elevation: 0.1,
      backgroundColor: const Color(0xff3A4256),
      title: const Text("Qra"),
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.list),
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(Icons.logout_outlined),
          onPressed: () async {
            final auth = FirebaseAuth.instance;
            //
            await auth.signOut();
            //todo: find a way to take the user back to the login page after this is done
            // print(auth.currentUser);
            // Get.to(LoginPage());
            // navigate(context);
          },
        )
      ],
    );

    final ultimateBody = PageView(
      controller: pageController,
      onPageChanged: (value) {
        _selectedIndex.value = value;
      },
      physics: const NeverScrollableScrollPhysics(),
      children: [
        makeBody,
        const ImprovedQrGenerator(),
        Container(
          color: Colors.yellow,
        )
      ],
    );

    return Scaffold(
      backgroundColor: const Color(0xff3A4256),
      appBar: topAppBar,
      body: ultimateBody,
      bottomNavigationBar: ultimateBottom,
    );
  }
}
