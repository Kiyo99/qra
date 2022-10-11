import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:qra/constants.dart';
import 'package:qra/presentation/course_delegate.dart';
import 'package:qra/presentation/search_button.dart';
import 'package:qra/presentation/student/courses/subscribe_to_course.dart';
import 'package:qra/presentation/student/courses/upload_course.dart';
import 'package:qra/presentation/student/generate/generator_improved.dart';
import 'package:qra/presentation/student/student_options_view.dart';

class StudentPage extends HookWidget {
  const StudentPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    final tabIndex = useState(0);
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Constants.coolBlue,
            elevation: 0,
            title: Text(title),
            bottom: TabBar(
              onTap: (index) {
                tabIndex.value = index;
              },
              tabs: const [
                Tab(text: "Generate QR"),
                Tab(text: "Subscribe to course"),
              ],
            ),
            actions: [
              if (tabIndex.value == 1)
                SearchButton(
                  onPressed: () async {
                    final searchResult = await showSearch(
                      context: context,
                      delegate:
                          CourseDelegate(), //todo this will be student delegate
                    );

                    // if (searchResult != null) {
                    //   final typedProduct = Product.fromJson(
                    //     searchResult,
                    //   );
                    //   createPostViewModel.setProduct(
                    //     typedProduct,
                    //   );
                    // }
                  },
                ),
              IconButton(
                icon: const Icon(Icons.menu_outlined),
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25.0),
                        topRight: Radius.circular(25.0),
                      ),
                    ),
                    isScrollControlled: true,
                    builder: (ctx) => const StudentOptionsScreen(
                      title: 'Hey there, select an option',
                    ),
                  );
                },
              ),
            ],
          ),
          body: TabBarView(
            physics: const NeverScrollableScrollPhysics(),
            children: [const ImprovedQrGenerator(), SubscribeToCourseScreen()],
          ),
        ));
  }
}
