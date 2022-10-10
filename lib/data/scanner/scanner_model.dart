import 'package:freezed_annotation/freezed_annotation.dart';

part 'scanner_model.freezed.dart';
part 'scanner_model.g.dart';

@freezed
class ScannerModel with _$ScannerModel {
  const ScannerModel._();

  factory ScannerModel({
    required String name,
    required String iD,
    required String eligible,
  }) = _ScannerModel;

  factory ScannerModel.fromJson(Map<String, dynamic> map) =>
      _$ScannerModelFromJson(map);
}
