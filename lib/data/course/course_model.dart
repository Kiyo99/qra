import 'package:freezed_annotation/freezed_annotation.dart';

part 'course_model.freezed.dart';
part 'course_model.g.dart';

@freezed
class CourseModel with _$CourseModel{
  const CourseModel._();

  factory CourseModel({
    required String courseName,
    required String courseCode,
    required String teacher,
    List? students,
  }) = _CourseModel;

  factory CourseModel.fromJson(Map<String, dynamic> map) =>
      _$CourseModelFromJson(map);
}
