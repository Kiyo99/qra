import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_user.freezed.dart';
part 'app_user.g.dart';

@freezed
class AppUser with _$AppUser{
  const AppUser._();

  factory AppUser({
    required String fullName,
    required String iD,
    dynamic isEligible,
    dynamic major,
    required String email,
    required String phoneNumber,
    required String firstName,
    required String lastName,
    required String gender,
    required String status,
  }) = _AppUser;

  factory AppUser.fromJson(Map<String, dynamic> map) =>
      _$AppUserFromJson(map);
}
