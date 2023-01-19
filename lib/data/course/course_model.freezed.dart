// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'course_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

CourseModel _$CourseModelFromJson(Map<String, dynamic> json) {
  return _CourseModel.fromJson(json);
}

/// @nodoc
class _$CourseModelTearOff {
  const _$CourseModelTearOff();

  _CourseModel call(
      {required String courseName,
      required String courseCode,
      required String? dueDate,
      String? attended,
      required String teacher,
      List<dynamic>? students}) {
    return _CourseModel(
      courseName: courseName,
      courseCode: courseCode,
      dueDate: dueDate,
      attended: attended,
      teacher: teacher,
      students: students,
    );
  }

  CourseModel fromJson(Map<String, Object> json) {
    return CourseModel.fromJson(json);
  }
}

/// @nodoc
const $CourseModel = _$CourseModelTearOff();

/// @nodoc
mixin _$CourseModel {
  String get courseName => throw _privateConstructorUsedError;
  String get courseCode => throw _privateConstructorUsedError;
  String? get dueDate => throw _privateConstructorUsedError;
  String? get attended => throw _privateConstructorUsedError;
  String get teacher => throw _privateConstructorUsedError;
  List<dynamic>? get students => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CourseModelCopyWith<CourseModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CourseModelCopyWith<$Res> {
  factory $CourseModelCopyWith(
          CourseModel value, $Res Function(CourseModel) then) =
      _$CourseModelCopyWithImpl<$Res>;
  $Res call(
      {String courseName,
      String courseCode,
      String? dueDate,
      String? attended,
      String teacher,
      List<dynamic>? students});
}

/// @nodoc
class _$CourseModelCopyWithImpl<$Res> implements $CourseModelCopyWith<$Res> {
  _$CourseModelCopyWithImpl(this._value, this._then);

  final CourseModel _value;
  // ignore: unused_field
  final $Res Function(CourseModel) _then;

  @override
  $Res call({
    Object? courseName = freezed,
    Object? courseCode = freezed,
    Object? dueDate = freezed,
    Object? attended = freezed,
    Object? teacher = freezed,
    Object? students = freezed,
  }) {
    return _then(_value.copyWith(
      courseName: courseName == freezed
          ? _value.courseName
          : courseName // ignore: cast_nullable_to_non_nullable
              as String,
      courseCode: courseCode == freezed
          ? _value.courseCode
          : courseCode // ignore: cast_nullable_to_non_nullable
              as String,
      dueDate: dueDate == freezed
          ? _value.dueDate
          : dueDate // ignore: cast_nullable_to_non_nullable
              as String?,
      attended: attended == freezed
          ? _value.attended
          : attended // ignore: cast_nullable_to_non_nullable
              as String?,
      teacher: teacher == freezed
          ? _value.teacher
          : teacher // ignore: cast_nullable_to_non_nullable
              as String,
      students: students == freezed
          ? _value.students
          : students // ignore: cast_nullable_to_non_nullable
              as List<dynamic>?,
    ));
  }
}

/// @nodoc
abstract class _$CourseModelCopyWith<$Res>
    implements $CourseModelCopyWith<$Res> {
  factory _$CourseModelCopyWith(
          _CourseModel value, $Res Function(_CourseModel) then) =
      __$CourseModelCopyWithImpl<$Res>;
  @override
  $Res call(
      {String courseName,
      String courseCode,
      String? dueDate,
      String? attended,
      String teacher,
      List<dynamic>? students});
}

/// @nodoc
class __$CourseModelCopyWithImpl<$Res> extends _$CourseModelCopyWithImpl<$Res>
    implements _$CourseModelCopyWith<$Res> {
  __$CourseModelCopyWithImpl(
      _CourseModel _value, $Res Function(_CourseModel) _then)
      : super(_value, (v) => _then(v as _CourseModel));

  @override
  _CourseModel get _value => super._value as _CourseModel;

  @override
  $Res call({
    Object? courseName = freezed,
    Object? courseCode = freezed,
    Object? dueDate = freezed,
    Object? attended = freezed,
    Object? teacher = freezed,
    Object? students = freezed,
  }) {
    return _then(_CourseModel(
      courseName: courseName == freezed
          ? _value.courseName
          : courseName // ignore: cast_nullable_to_non_nullable
              as String,
      courseCode: courseCode == freezed
          ? _value.courseCode
          : courseCode // ignore: cast_nullable_to_non_nullable
              as String,
      dueDate: dueDate == freezed
          ? _value.dueDate
          : dueDate // ignore: cast_nullable_to_non_nullable
              as String?,
      attended: attended == freezed
          ? _value.attended
          : attended // ignore: cast_nullable_to_non_nullable
              as String?,
      teacher: teacher == freezed
          ? _value.teacher
          : teacher // ignore: cast_nullable_to_non_nullable
              as String,
      students: students == freezed
          ? _value.students
          : students // ignore: cast_nullable_to_non_nullable
              as List<dynamic>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_CourseModel extends _CourseModel {
  _$_CourseModel(
      {required this.courseName,
      required this.courseCode,
      required this.dueDate,
      this.attended,
      required this.teacher,
      this.students})
      : super._();

  factory _$_CourseModel.fromJson(Map<String, dynamic> json) =>
      _$$_CourseModelFromJson(json);

  @override
  final String courseName;
  @override
  final String courseCode;
  @override
  final String? dueDate;
  @override
  final String? attended;
  @override
  final String teacher;
  @override
  final List<dynamic>? students;

  @override
  String toString() {
    return 'CourseModel(courseName: $courseName, courseCode: $courseCode, dueDate: $dueDate, attended: $attended, teacher: $teacher, students: $students)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _CourseModel &&
            (identical(other.courseName, courseName) ||
                const DeepCollectionEquality()
                    .equals(other.courseName, courseName)) &&
            (identical(other.courseCode, courseCode) ||
                const DeepCollectionEquality()
                    .equals(other.courseCode, courseCode)) &&
            (identical(other.dueDate, dueDate) ||
                const DeepCollectionEquality()
                    .equals(other.dueDate, dueDate)) &&
            (identical(other.attended, attended) ||
                const DeepCollectionEquality()
                    .equals(other.attended, attended)) &&
            (identical(other.teacher, teacher) ||
                const DeepCollectionEquality()
                    .equals(other.teacher, teacher)) &&
            (identical(other.students, students) ||
                const DeepCollectionEquality()
                    .equals(other.students, students)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(courseName) ^
      const DeepCollectionEquality().hash(courseCode) ^
      const DeepCollectionEquality().hash(dueDate) ^
      const DeepCollectionEquality().hash(attended) ^
      const DeepCollectionEquality().hash(teacher) ^
      const DeepCollectionEquality().hash(students);

  @JsonKey(ignore: true)
  @override
  _$CourseModelCopyWith<_CourseModel> get copyWith =>
      __$CourseModelCopyWithImpl<_CourseModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CourseModelToJson(this);
  }
}

abstract class _CourseModel extends CourseModel {
  factory _CourseModel(
      {required String courseName,
      required String courseCode,
      required String? dueDate,
      String? attended,
      required String teacher,
      List<dynamic>? students}) = _$_CourseModel;
  _CourseModel._() : super._();

  factory _CourseModel.fromJson(Map<String, dynamic> json) =
      _$_CourseModel.fromJson;

  @override
  String get courseName => throw _privateConstructorUsedError;
  @override
  String get courseCode => throw _privateConstructorUsedError;
  @override
  String? get dueDate => throw _privateConstructorUsedError;
  @override
  String? get attended => throw _privateConstructorUsedError;
  @override
  String get teacher => throw _privateConstructorUsedError;
  @override
  List<dynamic>? get students => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$CourseModelCopyWith<_CourseModel> get copyWith =>
      throw _privateConstructorUsedError;
}
