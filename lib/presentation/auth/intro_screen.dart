// import 'package:flutter/material.dart';
// import 'package:flutter_hooks/flutter_hooks.dart';
// import 'package:get/get.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
//
// class IntroScreen extends HookConsumerWidget {
//   static const id = "/intro";
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final currentSlide = useState(0);
//     final pageController = usePageController();
//
//     return ProviderListener<AuthViewModelState>(
//       provider: AuthViewModel.provider,
//       onChange: (BuildContext ctx, AuthViewModelState state) async {
//         if (state.status == UserStatus.anonymousUser) {
//           Get.offNamedUntil(MainApp.id, (route) => false);
//         }
//       },
//       child: OnboardingWrapper.noPadding(
//         onBackPressed: () => Future.value(true),
//         hasBackgroundImage: true,
//         padding: EdgeInsets.zero,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Expanded(
//               child: Container(
//                 padding: EdgeInsets.fromLTRB(20, 20, 20, 30),
//                 child: PageView(
//                   controller: pageController,
//                   onPageChanged: (idx) => currentSlide.value = idx,
//                   children: IntroPagerModel.slides
//                       .map((e) => IntroPagerItem(slide: e))
//                       .toList(),
//                 ),
//               ),
//             ),
//             Container(
//               padding: EdgeInsets.symmetric(horizontal: 20),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.only(bottom: 30),
//                     child: SliderIndicator(
//                       slideCount: IntroPagerModel.slides.length,
//                       currentSlide: currentSlide.value,
//                     ),
//                   ),
//                   AppButton.primary(
//                     onPressed: () => currentSlide.value < 2
//                         ? pageController.nextPage(
//                             duration: Duration(milliseconds: 300),
//                             curve: Curves.linear,
//                           )
//                         : context
//                             .read(AuthViewModel.provider.notifier)
//                             .anonymousLogin(),
//                     text: currentSlide.value < 2 ? "Next" : "Done",
//                   ),
//                   AnimatedContainer(
//                     curve: Curves.linear,
//                     duration: Duration(milliseconds: 300),
//                     child: Visibility(
//                       replacement: SizedBox(height: 30,),
//                       visible: currentSlide.value < 2,
//                       child: AppButton.textOnly(
//                         onPressed: () => context
//                             .read(AuthViewModel.provider.notifier)
//                             .anonymousLogin(),
//                         text: "Skip",
//                         textColor: Colors.black,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
