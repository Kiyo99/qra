// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_AppUser _$$_AppUserFromJson(Map<String, dynamic> json) => _$_AppUser(
      fullName: json['fullName'],
      iD: json['iD'],
      isEligible: json['isEligible'],
      major: json['major'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      gender: json['gender'],
      status: json['status'],
    );

Map<String, dynamic> _$$_AppUserToJson(_$_AppUser instance) =>
    <String, dynamic>{
      'fullName': instance.fullName,
      'iD': instance.iD,
      'isEligible': instance.isEligible,
      'major': instance.major,
      'email': instance.email,
      'phoneNumber': instance.phoneNumber,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'gender': instance.gender,
      'status': instance.status,
    };
