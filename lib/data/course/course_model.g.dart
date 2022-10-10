// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_CourseModel _$$_CourseModelFromJson(Map<String, dynamic> json) =>
    _$_CourseModel(
      courseName: json['courseName'] as String,
      courseCode: json['courseCode'] as String,
      teacher: json['teacher'] as String,
      students: json['students'] as List<dynamic>?,
    );

Map<String, dynamic> _$$_CourseModelToJson(_$_CourseModel instance) =>
    <String, dynamic>{
      'courseName': instance.courseName,
      'courseCode': instance.courseCode,
      'teacher': instance.teacher,
      'students': instance.students,
    };
