import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:qra/constants.dart';
import 'package:qra/data/datasource/auth_local_datasource.dart';
import 'package:qra/data/fb_student_model/student_model.dart';
import 'package:qra/presentation/widgets/search_button.dart';
import 'package:qra/presentation/student/courses/subscribe_to_course.dart';
import 'package:qra/presentation/student/generate/generator_improved.dart';
import 'package:qra/presentation/student/student_options_view.dart';
import 'package:qra/presentation/student/student_search_delegate/student_delegate.dart';

class StudentPage extends HookConsumerWidget {
  static const id = 'student_page';

  StudentPage({Key? key}) : super(key: key);

  final auth = FirebaseAuth.instance;
  final _fireStore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final greeting = useState("Welcome");
    useEffect(() {
      WidgetsBinding.instance?.addPostFrameCallback((_) async {
        final user = ref.read(AuthLocalDataSource.provider).getCachedUser();
        greeting.value = "Welcome, ${user!.firstName}";
      });
      return;
    }, const []);

    final tabIndex = useState(0);
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Constants.coolBlue,
            elevation: 0,
            title: Text(greeting.value, style: GoogleFonts.exo2()),
            bottom: TabBar(
              onTap: (index) {
                tabIndex.value = index;
              },
              tabs: [
                Tab(
                  child: Text("Generate QR", style: GoogleFonts.exo2()),
                ),
                Tab(
                    child:
                        Text("Subscribe to course", style: GoogleFonts.exo2()))
              ],
            ),
            actions: [
              if (tabIndex.value == 1)
                SearchButton(
                  onPressed: () async {
                    await showSearch(
                      context: context,
                      delegate: StudentDelegate(),
                    );
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
            children: [
              const ImprovedQrGenerator(),
              SubscribeToCourseScreen(),
            ],
          ),
        ));
  }
}
