// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'scanner_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ScannerModel _$ScannerModelFromJson(Map<String, dynamic> json) {
  return _ScannerModel.fromJson(json);
}

/// @nodoc
class _$ScannerModelTearOff {
  const _$ScannerModelTearOff();

  _ScannerModel call(
      {required String name, required String iD, required String eligible}) {
    return _ScannerModel(
      name: name,
      iD: iD,
      eligible: eligible,
    );
  }

  ScannerModel fromJson(Map<String, Object> json) {
    return ScannerModel.fromJson(json);
  }
}

/// @nodoc
const $ScannerModel = _$ScannerModelTearOff();

/// @nodoc
mixin _$ScannerModel {
  String get name => throw _privateConstructorUsedError;
  String get iD => throw _privateConstructorUsedError;
  String get eligible => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ScannerModelCopyWith<ScannerModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ScannerModelCopyWith<$Res> {
  factory $ScannerModelCopyWith(
          ScannerModel value, $Res Function(ScannerModel) then) =
      _$ScannerModelCopyWithImpl<$Res>;
  $Res call({String name, String iD, String eligible});
}

/// @nodoc
class _$ScannerModelCopyWithImpl<$Res> implements $ScannerModelCopyWith<$Res> {
  _$ScannerModelCopyWithImpl(this._value, this._then);

  final ScannerModel _value;
  // ignore: unused_field
  final $Res Function(ScannerModel) _then;

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
abstract class _$ScannerModelCopyWith<$Res>
    implements $ScannerModelCopyWith<$Res> {
  factory _$ScannerModelCopyWith(
          _ScannerModel value, $Res Function(_ScannerModel) then) =
      __$ScannerModelCopyWithImpl<$Res>;
  @override
  $Res call({String name, String iD, String eligible});
}

/// @nodoc
class __$ScannerModelCopyWithImpl<$Res> extends _$ScannerModelCopyWithImpl<$Res>
    implements _$ScannerModelCopyWith<$Res> {
  __$ScannerModelCopyWithImpl(
      _ScannerModel _value, $Res Function(_ScannerModel) _then)
      : super(_value, (v) => _then(v as _ScannerModel));

  @override
  _ScannerModel get _value => super._value as _ScannerModel;

  @override
  $Res call({
    Object? name = freezed,
    Object? iD = freezed,
    Object? eligible = freezed,
  }) {
    return _then(_ScannerModel(
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
class _$_ScannerModel extends _ScannerModel {
  _$_ScannerModel(
      {required this.name, required this.iD, required this.eligible})
      : super._();

  factory _$_ScannerModel.fromJson(Map<String, dynamic> json) =>
      _$$_ScannerModelFromJson(json);

  @override
  final String name;
  @override
  final String iD;
  @override
  final String eligible;

  @override
  String toString() {
    return 'ScannerModel(name: $name, iD: $iD, eligible: $eligible)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _ScannerModel &&
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
  _$ScannerModelCopyWith<_ScannerModel> get copyWith =>
      __$ScannerModelCopyWithImpl<_ScannerModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ScannerModelToJson(this);
  }
}

abstract class _ScannerModel extends ScannerModel {
  factory _ScannerModel(
      {required String name,
      required String iD,
      required String eligible}) = _$_ScannerModel;
  _ScannerModel._() : super._();

  factory _ScannerModel.fromJson(Map<String, dynamic> json) =
      _$_ScannerModel.fromJson;

  @override
  String get name => throw _privateConstructorUsedError;
  @override
  String get iD => throw _privateConstructorUsedError;
  @override
  String get eligible => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$ScannerModelCopyWith<_ScannerModel> get copyWith =>
      throw _privateConstructorUsedError;
}
