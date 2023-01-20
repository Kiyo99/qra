// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_StudentModel _$$_StudentModelFromJson(Map<String, dynamic> json) =>
    _$_StudentModel(
      fullName: json['fullName'] as String,
      iD: json['iD'] as String,
      isEligible: json['isEligible'] as String,
      attended: json['attended'] as String?,
      major: json['major'] as String,
      email: json['email'] as String,
      phoneNumber: json['phoneNumber'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      gender: json['gender'] as String,
      status: json['status'] as String,
      courses: (json['courses'] as List<dynamic>?)
          ?.map((e) => CourseModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_StudentModelToJson(_$_StudentModel instance) =>
    <String, dynamic>{
      'fullName': instance.fullName,
      'iD': instance.iD,
      'isEligible': instance.isEligible,
      'attended': instance.attended,
      'major': instance.major,
      'email': instance.email,
      'phoneNumber': instance.phoneNumber,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'gender': instance.gender,
      'status': instance.status,
      'courses': instance.courses,
    };
