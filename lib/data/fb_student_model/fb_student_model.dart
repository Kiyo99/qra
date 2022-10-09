import 'package:freezed_annotation/freezed_annotation.dart';

part 'fb_student_model.freezed.dart';
part 'fb_student_model.g.dart';

@freezed
class FbStudentModel with _$FbStudentModel{
  const FbStudentModel._();

  factory FbStudentModel({
    required String name,
    required String iD,
    required String eligible,
  }) = _FbStudentModel;

  factory FbStudentModel.fromJson(Map<String, dynamic> map) =>
      _$FbStudentModelFromJson(map);
}
