import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:qra/data/course/course_model.dart';

part 'student_model.freezed.dart';
part 'student_model.g.dart';

@freezed
class StudentModel with _$StudentModel{
  const StudentModel._();

  factory StudentModel({
    required String fullName,
    required String iD,
    required String isEligible,
    required String major,
    required String email,
    required String phoneNumber,
    required String firstName,
    required String lastName,
    required String gender,
    required String status,
    List<CourseModel>? courses,
  }) = _StudentModel;

  factory StudentModel.fromJson(Map<String, dynamic> map) =>
      _$StudentModelFromJson(map);
}
