class Lesson {
  String title;
  String level;
  double indicatorValue;
  int price;
  String content;
  bool checked;

  Lesson(
      {required this.title,
      required this.level,
      required this.indicatorValue,
      required this.price,
      required this.content,
      required this.checked});
}

class Course {
  String title;
  String level;
  double? indicatorValue;
  List<Map<String, dynamic>> content;
  // List<Map<String, dynamic>> students;
  bool checked;

  Course(
      {required this.title,
      required this.level,
      this.indicatorValue,
      required this.content,
      required this.checked});
}
