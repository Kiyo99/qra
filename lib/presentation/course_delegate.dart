import 'package:flutter/material.dart';

class CourseDelegate extends SearchDelegate<Map<String, dynamic>> {
  // final int brandId;
  //
  // CourseDelegate(this.brandId);

  @override
  List<Widget>? buildActions(BuildContext context) =>
      [const SizedBox(width: 20)];

  // @override
  // ThemeData appBarTheme(BuildContext context) {
  //   return context.resources.theme.lightTheme.copyWith(
  //     inputDecorationTheme: InputDecorationTheme(
  //       contentPadding: const EdgeInsets.symmetric(
  //         vertical: 25,
  //         horizontal: 20,
  //       ),
  //       fillColor: Colors.white,
  //       filled: true,
  //       border: OutlineInputBorder(
  //         borderRadius: context.resources.dimension.inputFieldBorderRadius,
  //         borderSide: const BorderSide(color: Colors.transparent),
  //       ),
  //       enabledBorder: OutlineInputBorder(
  //         borderRadius: context.resources.dimension.inputFieldBorderRadius,
  //         borderSide: const BorderSide(color: Colors.transparent),
  //       ),
  //       focusedBorder: OutlineInputBorder(
  //         borderRadius: context.resources.dimension.inputFieldBorderRadius,
  //         borderSide: const BorderSide(color: Colors.transparent),
  //       ),
  //     ),
  //     appBarTheme: const AppBarTheme(
  //         elevation: 0,
  //         titleSpacing: -5,
  //         backgroundColor: Colors.white,
  //         shadowColor: Colors.white),
  //   );
  // }

  @override
  Widget? buildLeading(BuildContext context) => const BackButton();

  @override
  Widget buildResults(BuildContext context) {
    return const Center(
      child: Text("Courses will appear here when you search for them"),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return const Center(
      child: Text("Courses will appear here as you search for them"),
    );
  }

  // @override
  // Widget buildResults(BuildContext context) => Consumer(
  //   builder: (_, watch, __) {
  //     watch(CategoryViewModel.provider).setSelectedBrandId(brandId);
  //     final searchResponse = watch(
  //       CategoryViewModel.productsSearchProvider(query),
  //     );
  //
  //     return searchResponse.when(
  //       data: (predictions) {
  //         if (predictions.isNotEmpty) {
  //           return Container(
  //             color: Colors.white,
  //             child: ListView.separated(
  //               separatorBuilder: (context, index) => Divider(),
  //               itemCount: predictions.length,
  //               itemBuilder: (ctx, idx) {
  //                 final prediction = predictions[idx];
  //
  //                 return Consumer(builder: (_, watch, __) {
  //                   return ListTile(
  //                     onTap: () => Get.back(result: prediction),
  //                     title: Text("${prediction["productName"]}"),
  //                     horizontalTitleGap: 1,
  //                   );
  //                 });
  //               },
  //             ),
  //           );
  //         }
  //
  //         return const EmptyBody(
  //           icon: Icons.search_off_outlined,
  //           title: "Uhmmm...",
  //           message: "No products found",
  //         );
  //       },
  //       loading: () => const PageLoader(),
  //       error: (err, stk) => const EmptyBody(
  //         icon: Icons.search_off_outlined,
  //         title: "Ooops...",
  //         message: "No products found",
  //       ),
  //     );
  //   },
  // );
  //
  // @override
  // Widget buildSuggestions(BuildContext context) => Consumer(
  //   builder: (_, watch, __) {
  //     watch(CategoryViewModel.provider).setSelectedBrandId(brandId);
  //     final searchResponse = watch(
  //       CategoryViewModel.productsSearchProvider(query),
  //     );
  //
  //     return searchResponse.when(
  //       data: (predictions) {
  //         if (predictions.isNotEmpty) {
  //           return Container(
  //             color: Colors.white,
  //             child: ListView.separated(
  //               separatorBuilder: (context, index) => Divider(),
  //               itemCount: predictions.length,
  //               itemBuilder: (ctx, idx) {
  //                 final prediction = predictions[idx];
  //
  //                 return Consumer(builder: (_, watch, __) {
  //                   return ListTile(
  //                     onTap: () => Get.back(result: prediction),
  //                     title: Text("${prediction["productName"]}"),
  //                     horizontalTitleGap: 1,
  //                   );
  //                 });
  //               },
  //             ),
  //           );
  //         }
  //
  //         return const EmptyBody(
  //           icon: Icons.search_off_outlined,
  //           title: "Uhmmm...",
  //           message: "No products found",
  //         );
  //       },
  //       loading: () => const PageLoader(),
  //       error: (err, stk) => const EmptyBody(
  //         icon: Icons.search_off_outlined,
  //         title: "Ooops...",
  //         message: "No products found",
  //       ),
  //     );
  //   },
  // );
}
