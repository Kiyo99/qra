// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'fb_student_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

FbStudentModel _$FbStudentModelFromJson(Map<String, dynamic> json) {
  return _FbStudentModel.fromJson(json);
}

/// @nodoc
class _$FbStudentModelTearOff {
  const _$FbStudentModelTearOff();

  _FbStudentModel call(
      {required String name, required String iD, required String eligible}) {
    return _FbStudentModel(
      name: name,
      iD: iD,
      eligible: eligible,
    );
  }

  FbStudentModel fromJson(Map<String, Object> json) {
    return FbStudentModel.fromJson(json);
  }
}

/// @nodoc
const $FbStudentModel = _$FbStudentModelTearOff();

/// @nodoc
mixin _$FbStudentModel {
  String get name => throw _privateConstructorUsedError;
  String get iD => throw _privateConstructorUsedError;
  String get eligible => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FbStudentModelCopyWith<FbStudentModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FbStudentModelCopyWith<$Res> {
  factory $FbStudentModelCopyWith(
          FbStudentModel value, $Res Function(FbStudentModel) then) =
      _$FbStudentModelCopyWithImpl<$Res>;
  $Res call({String name, String iD, String eligible});
}

/// @nodoc
class _$FbStudentModelCopyWithImpl<$Res>
    implements $FbStudentModelCopyWith<$Res> {
  _$FbStudentModelCopyWithImpl(this._value, this._then);

  final FbStudentModel _value;
  // ignore: unused_field
  final $Res Function(FbStudentModel) _then;

  @override
  $Res call({
    Object? name = freezed,
    Object? iD = freezed,
    Object? eligible = freezed,
  }) {
    return _then(_value.copyWith(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      iD: iD == freezed
          ? _value.iD
          : iD // ignore: cast_nullable_to_non_nullable
              as String,
      eligible: eligible == freezed
          ? _value.eligible
          : eligible // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$FbStudentModelCopyWith<$Res>
    implements $FbStudentModelCopyWith<$Res> {
  factory _$FbStudentModelCopyWith(
          _FbStudentModel value, $Res Function(_FbStudentModel) then) =
      __$FbStudentModelCopyWithImpl<$Res>;
  @override
  $Res call({String name, String iD, String eligible});
}

/// @nodoc
class __$FbStudentModelCopyWithImpl<$Res>
    extends _$FbStudentModelCopyWithImpl<$Res>
    implements _$FbStudentModelCopyWith<$Res> {
  __$FbStudentModelCopyWithImpl(
      _FbStudentModel _value, $Res Function(_FbStudentModel) _then)
      : super(_value, (v) => _then(v as _FbStudentModel));

  @override
  _FbStudentModel get _value => super._value as _FbStudentModel;

  @override
  $Res call({
    Object? name = freezed,
    Object? iD = freezed,
    Object? eligible = freezed,
  }) {
    return _then(_FbStudentModel(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      iD: iD == freezed
          ? _value.iD
          : iD // ignore: cast_nullable_to_non_nullable
              as String,
      eligible: eligible == freezed
          ? _value.eligible
          : eligible // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_FbStudentModel extends _FbStudentModel {
  _$_FbStudentModel(
      {required this.name, required this.iD, required this.eligible})
      : super._();

  factory _$_FbStudentModel.fromJson(Map<String, dynamic> json) =>
      _$$_FbStudentModelFromJson(json);

  @override
  final String name;
  @override
  final String iD;
  @override
  final String eligible;

  @override
  String toString() {
    return 'FbStudentModel(name: $name, iD: $iD, eligible: $eligible)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _FbStudentModel &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.iD, iD) ||
                const DeepCollectionEquality().equals(other.iD, iD)) &&
            (identical(other.eligible, eligible) ||
                const DeepCollectionEquality()
                    .equals(other.eligible, eligible)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(iD) ^
      const DeepCollectionEquality().hash(eligible);

  @JsonKey(ignore: true)
  @override
  _$FbStudentModelCopyWith<_FbStudentModel> get copyWith =>
      __$FbStudentModelCopyWithImpl<_FbStudentModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_FbStudentModelToJson(this);
  }
}

abstract class _FbStudentModel extends FbStudentModel {
  factory _FbStudentModel(
      {required String name,
      required String iD,
      required String eligible}) = _$_FbStudentModel;
  _FbStudentModel._() : super._();

  factory _FbStudentModel.fromJson(Map<String, dynamic> json) =
      _$_FbStudentModel.fromJson;

  @override
  String get name => throw _privateConstructorUsedError;
  @override
  String get iD => throw _privateConstructorUsedError;
  @override
  String get eligible => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$FbStudentModelCopyWith<_FbStudentModel> get copyWith =>
      throw _privateConstructorUsedError;
}
