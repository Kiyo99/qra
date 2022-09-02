import 'package:freezed_annotation/freezed_annotation.dart';

part 'fb_model.freezed.dart';
part 'fb_model.g.dart';

@freezed
class FbModel with _$FbModel{
  const FbModel._();

  factory FbModel({
    required String name,
    required String iD,
    required String eligible,
  }) = _FbModel;

  factory FbModel.fromJson(Map<String, dynamic> map) =>
      _$FbModelFromJson(map);
}
