// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scanner_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ScannerModel _$$_ScannerModelFromJson(Map<String, dynamic> json) =>
    _$_ScannerModel(
      name: json['name'] as String,
      iD: json['iD'] as String,
      eligible: json['eligible'] as String,
      courses: (json['courses'] as List<dynamic>?)
          ?.map((e) => CourseModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_ScannerModelToJson(_$_ScannerModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'iD': instance.iD,
      'eligible': instance.eligible,
      'courses': instance.courses,
    };
