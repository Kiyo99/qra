import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_user.freezed.dart';
part 'app_user.g.dart';

@freezed
class AppUser with _$AppUser {
  const AppUser._();

  factory AppUser({
    dynamic fullName,
    dynamic iD,
    dynamic isEligible,
    dynamic major,
    dynamic email,
    dynamic phoneNumber,
    dynamic firstName,
    dynamic lastName,
    dynamic gender,
    dynamic status,
  }) = _AppUser;

  factory AppUser.fromJson(Map<String, dynamic> map) => _$AppUserFromJson(map);
}
