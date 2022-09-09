// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'fb_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

FbModel _$FbModelFromJson(Map<String, dynamic> json) {
  return _FbModel.fromJson(json);
}

/// @nodoc
class _$FbModelTearOff {
  const _$FbModelTearOff();

  _FbModel call(
      {required String name, required String iD, required String eligible}) {
    return _FbModel(
      name: name,
      iD: iD,
      eligible: eligible,
    );
  }

  FbModel fromJson(Map<String, Object> json) {
    return FbModel.fromJson(json);
  }
}

/// @nodoc
const $FbModel = _$FbModelTearOff();

/// @nodoc
mixin _$FbModel {
  String get name => throw _privateConstructorUsedError;
  String get iD => throw _privateConstructorUsedError;
  String get eligible => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FbModelCopyWith<FbModel> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FbModelCopyWith<$Res> {
  factory $FbModelCopyWith(FbModel value, $Res Function(FbModel) then) =
      _$FbModelCopyWithImpl<$Res>;
  $Res call({String name, String iD, String eligible});
}

/// @nodoc
class _$FbModelCopyWithImpl<$Res> implements $FbModelCopyWith<$Res> {
  _$FbModelCopyWithImpl(this._value, this._then);

  final FbModel _value;
  // ignore: unused_field
  final $Res Function(FbModel) _then;

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
abstract class _$FbModelCopyWith<$Res> implements $FbModelCopyWith<$Res> {
  factory _$FbModelCopyWith(_FbModel value, $Res Function(_FbModel) then) =
      __$FbModelCopyWithImpl<$Res>;
  @override
  $Res call({String name, String iD, String eligible});
}

/// @nodoc
class __$FbModelCopyWithImpl<$Res> extends _$FbModelCopyWithImpl<$Res>
    implements _$FbModelCopyWith<$Res> {
  __$FbModelCopyWithImpl(_FbModel _value, $Res Function(_FbModel) _then)
      : super(_value, (v) => _then(v as _FbModel));

  @override
  _FbModel get _value => super._value as _FbModel;

  @override
  $Res call({
    Object? name = freezed,
    Object? iD = freezed,
    Object? eligible = freezed,
  }) {
    return _then(_FbModel(
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
class _$_FbModel extends _FbModel {
  _$_FbModel({required this.name, required this.iD, required this.eligible})
      : super._();

  factory _$_FbModel.fromJson(Map<String, dynamic> json) =>
      _$$_FbModelFromJson(json);

  @override
  final String name;
  @override
  final String iD;
  @override
  final String eligible;

  @override
  String toString() {
    return 'FbModel(name: $name, iD: $iD, eligible: $eligible)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _FbModel &&
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
  _$FbModelCopyWith<_FbModel> get copyWith =>
      __$FbModelCopyWithImpl<_FbModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_FbModelToJson(this);
  }
}

abstract class _FbModel extends FbModel {
  factory _FbModel(
      {required String name,
      required String iD,
      required String eligible}) = _$_FbModel;
  _FbModel._() : super._();

  factory _FbModel.fromJson(Map<String, dynamic> json) = _$_FbModel.fromJson;

  @override
  String get name => throw _privateConstructorUsedError;
  @override
  String get iD => throw _privateConstructorUsedError;
  @override
  String get eligible => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$FbModelCopyWith<_FbModel> get copyWith =>
      throw _privateConstructorUsedError;
}
