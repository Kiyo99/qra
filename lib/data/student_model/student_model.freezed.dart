// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'student_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

StudentModel _$StudentModelFromJson(Map<String, dynamic> json) {
  return _StudentModel.fromJson(json);
}

/// @nodoc
class _$StudentModelTearOff {
  const _$StudentModelTearOff();

  _StudentModel call(
      {required String fullName,
      required String iD,
      required String isEligible,
      String? attended,
      required String major,
      required String email,
      required String phoneNumber,
      required String firstName,
      required String lastName,
      required String gender,
      required String status,
      List<CourseModel>? courses}) {
    return _StudentModel(
      fullName: fullName,
      iD: iD,
      isEligible: isEligible,
      attended: attended,
      major: major,
      email: email,
      phoneNumber: phoneNumber,
      firstName: firstName,
      lastName: lastName,
      gender: gender,
      status: status,
      courses: courses,
    );
  }

  StudentModel fromJson(Map<String, Object> json) {
    return StudentModel.fromJson(json);
  }
}

/// @nodoc
const $StudentModel = _$StudentModelTearOff();

/// @nodoc
mixin _$StudentModel {
  String get fullName => throw _privateConstructorUsedError;
  String get iD => throw _privateConstructorUsedError;
  String get isEligible => throw _privateConstructorUsedError;
  String? get attended => throw _privateConstructorUsedError;
  String get major => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String get phoneNumber => throw _privateConstructorUsedError;
  String get firstName => throw _privateConstructorUsedError;
  String get lastName => throw _privateConstructorUsedError;
  String get gender => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  List<CourseModel>? get courses => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $StudentModelCopyWith<StudentModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StudentModelCopyWith<$Res> {
  factory $StudentModelCopyWith(
          StudentModel value, $Res Function(StudentModel) then) =
      _$StudentModelCopyWithImpl<$Res>;
  $Res call(
      {String fullName,
      String iD,
      String isEligible,
      String? attended,
      String major,
      String email,
      String phoneNumber,
      String firstName,
      String lastName,
      String gender,
      String status,
      List<CourseModel>? courses});
}

/// @nodoc
class _$StudentModelCopyWithImpl<$Res> implements $StudentModelCopyWith<$Res> {
  _$StudentModelCopyWithImpl(this._value, this._then);

  final StudentModel _value;
  // ignore: unused_field
  final $Res Function(StudentModel) _then;

  @override
  $Res call({
    Object? fullName = freezed,
    Object? iD = freezed,
    Object? isEligible = freezed,
    Object? attended = freezed,
    Object? major = freezed,
    Object? email = freezed,
    Object? phoneNumber = freezed,
    Object? firstName = freezed,
    Object? lastName = freezed,
    Object? gender = freezed,
    Object? status = freezed,
    Object? courses = freezed,
  }) {
    return _then(_value.copyWith(
      fullName: fullName == freezed
          ? _value.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
              as String,
      iD: iD == freezed
          ? _value.iD
          : iD // ignore: cast_nullable_to_non_nullable
              as String,
      isEligible: isEligible == freezed
          ? _value.isEligible
          : isEligible // ignore: cast_nullable_to_non_nullable
              as String,
      attended: attended == freezed
          ? _value.attended
          : attended // ignore: cast_nullable_to_non_nullable
              as String?,
      major: major == freezed
          ? _value.major
          : major // ignore: cast_nullable_to_non_nullable
              as String,
      email: email == freezed
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      phoneNumber: phoneNumber == freezed
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String,
      firstName: firstName == freezed
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String,
      lastName: lastName == freezed
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String,
      gender: gender == freezed
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String,
      status: status == freezed
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      courses: courses == freezed
          ? _value.courses
          : courses // ignore: cast_nullable_to_non_nullable
              as List<CourseModel>?,
    ));
  }
}

/// @nodoc
abstract class _$StudentModelCopyWith<$Res>
    implements $StudentModelCopyWith<$Res> {
  factory _$StudentModelCopyWith(
          _StudentModel value, $Res Function(_StudentModel) then) =
      __$StudentModelCopyWithImpl<$Res>;
  @override
  $Res call(
      {String fullName,
      String iD,
      String isEligible,
      String? attended,
      String major,
      String email,
      String phoneNumber,
      String firstName,
      String lastName,
      String gender,
      String status,
      List<CourseModel>? courses});
}

/// @nodoc
class __$StudentModelCopyWithImpl<$Res> extends _$StudentModelCopyWithImpl<$Res>
    implements _$StudentModelCopyWith<$Res> {
  __$StudentModelCopyWithImpl(
      _StudentModel _value, $Res Function(_StudentModel) _then)
      : super(_value, (v) => _then(v as _StudentModel));

  @override
  _StudentModel get _value => super._value as _StudentModel;

  @override
  $Res call({
    Object? fullName = freezed,
    Object? iD = freezed,
    Object? isEligible = freezed,
    Object? attended = freezed,
    Object? major = freezed,
    Object? email = freezed,
    Object? phoneNumber = freezed,
    Object? firstName = freezed,
    Object? lastName = freezed,
    Object? gender = freezed,
    Object? status = freezed,
    Object? courses = freezed,
  }) {
    return _then(_StudentModel(
      fullName: fullName == freezed
          ? _value.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
              as String,
      iD: iD == freezed
          ? _value.iD
          : iD // ignore: cast_nullable_to_non_nullable
              as String,
      isEligible: isEligible == freezed
          ? _value.isEligible
          : isEligible // ignore: cast_nullable_to_non_nullable
              as String,
      attended: attended == freezed
          ? _value.attended
          : attended // ignore: cast_nullable_to_non_nullable
              as String?,
      major: major == freezed
          ? _value.major
          : major // ignore: cast_nullable_to_non_nullable
              as String,
      email: email == freezed
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      phoneNumber: phoneNumber == freezed
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String,
      firstName: firstName == freezed
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String,
      lastName: lastName == freezed
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String,
      gender: gender == freezed
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String,
      status: status == freezed
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      courses: courses == freezed
          ? _value.courses
          : courses // ignore: cast_nullable_to_non_nullable
              as List<CourseModel>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_StudentModel extends _StudentModel {
  _$_StudentModel(
      {required this.fullName,
      required this.iD,
      required this.isEligible,
      this.attended,
      required this.major,
      required this.email,
      required this.phoneNumber,
      required this.firstName,
      required this.lastName,
      required this.gender,
      required this.status,
      this.courses})
      : super._();

  factory _$_StudentModel.fromJson(Map<String, dynamic> json) =>
      _$$_StudentModelFromJson(json);

  @override
  final String fullName;
  @override
  final String iD;
  @override
  final String isEligible;
  @override
  final String? attended;
  @override
  final String major;
  @override
  final String email;
  @override
  final String phoneNumber;
  @override
  final String firstName;
  @override
  final String lastName;
  @override
  final String gender;
  @override
  final String status;
  @override
  final List<CourseModel>? courses;

  @override
  String toString() {
    return 'StudentModel(fullName: $fullName, iD: $iD, isEligible: $isEligible, attended: $attended, major: $major, email: $email, phoneNumber: $phoneNumber, firstName: $firstName, lastName: $lastName, gender: $gender, status: $status, courses: $courses)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _StudentModel &&
            (identical(other.fullName, fullName) ||
                const DeepCollectionEquality()
                    .equals(other.fullName, fullName)) &&
            (identical(other.iD, iD) ||
                const DeepCollectionEquality().equals(other.iD, iD)) &&
            (identical(other.isEligible, isEligible) ||
                const DeepCollectionEquality()
                    .equals(other.isEligible, isEligible)) &&
            (identical(other.attended, attended) ||
                const DeepCollectionEquality()
                    .equals(other.attended, attended)) &&
            (identical(other.major, major) ||
                const DeepCollectionEquality().equals(other.major, major)) &&
            (identical(other.email, email) ||
                const DeepCollectionEquality().equals(other.email, email)) &&
            (identical(other.phoneNumber, phoneNumber) ||
                const DeepCollectionEquality()
                    .equals(other.phoneNumber, phoneNumber)) &&
            (identical(other.firstName, firstName) ||
                const DeepCollectionEquality()
                    .equals(other.firstName, firstName)) &&
            (identical(other.lastName, lastName) ||
                const DeepCollectionEquality()
                    .equals(other.lastName, lastName)) &&
            (identical(other.gender, gender) ||
                const DeepCollectionEquality().equals(other.gender, gender)) &&
            (identical(other.status, status) ||
                const DeepCollectionEquality().equals(other.status, status)) &&
            (identical(other.courses, courses) ||
                const DeepCollectionEquality().equals(other.courses, courses)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(fullName) ^
      const DeepCollectionEquality().hash(iD) ^
      const DeepCollectionEquality().hash(isEligible) ^
      const DeepCollectionEquality().hash(attended) ^
      const DeepCollectionEquality().hash(major) ^
      const DeepCollectionEquality().hash(email) ^
      const DeepCollectionEquality().hash(phoneNumber) ^
      const DeepCollectionEquality().hash(firstName) ^
      const DeepCollectionEquality().hash(lastName) ^
      const DeepCollectionEquality().hash(gender) ^
      const DeepCollectionEquality().hash(status) ^
      const DeepCollectionEquality().hash(courses);

  @JsonKey(ignore: true)
  @override
  _$StudentModelCopyWith<_StudentModel> get copyWith =>
      __$StudentModelCopyWithImpl<_StudentModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_StudentModelToJson(this);
  }
}

abstract class _StudentModel extends StudentModel {
  factory _StudentModel(
      {required String fullName,
      required String iD,
      required String isEligible,
      String? attended,
      required String major,
      required String email,
      required String phoneNumber,
      required String firstName,
      required String lastName,
      required String gender,
      required String status,
      List<CourseModel>? courses}) = _$_StudentModel;
  _StudentModel._() : super._();

  factory _StudentModel.fromJson(Map<String, dynamic> json) =
      _$_StudentModel.fromJson;

  @override
  String get fullName => throw _privateConstructorUsedError;
  @override
  String get iD => throw _privateConstructorUsedError;
  @override
  String get isEligible => throw _privateConstructorUsedError;
  @override
  String? get attended => throw _privateConstructorUsedError;
  @override
  String get major => throw _privateConstructorUsedError;
  @override
  String get email => throw _privateConstructorUsedError;
  @override
  String get phoneNumber => throw _privateConstructorUsedError;
  @override
  String get firstName => throw _privateConstructorUsedError;
  @override
  String get lastName => throw _privateConstructorUsedError;
  @override
  String get gender => throw _privateConstructorUsedError;
  @override
  String get status => throw _privateConstructorUsedError;
  @override
  List<CourseModel>? get courses => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$StudentModelCopyWith<_StudentModel> get copyWith =>
      throw _privateConstructorUsedError;
}
