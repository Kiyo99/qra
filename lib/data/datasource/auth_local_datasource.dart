import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qra/constants.dart';
import 'package:qra/core/preference_manager.dart';
import 'package:qra/data/app_user/app_user.dart';

class AuthLocalDataSource {
  final PreferenceManager _preferenceManager;
  static final provider = Provider<AuthLocalDataSource>(
    (ref) => AuthLocalDataSource(ref.watch(preferenceManagerProvider)),
  );

  const AuthLocalDataSource(this._preferenceManager);

  void cacheUser(AppUser user) {
    _preferenceManager.saveJsonMap(Constants.prefsUserKey, user.toJson());
  }

  bool? viewedIntro() {
    return _preferenceManager.prefs.getBool(Constants.prefsViewedKey);
  }

  void setViewedIntro() {
    _preferenceManager.prefs.setBool(Constants.prefsViewedKey, true);
  }

  bool? appInstalled() {
    return _preferenceManager.prefs.getBool(Constants.prefsViewedKey);
  }

  void setAppInstalled() {
    _preferenceManager.prefs.setBool(Constants.prefsViewedKey, true);
  }

  AppUser? getCachedUser() {
    final user = _preferenceManager.getJsonMap(Constants.prefsUserKey);
    return AppUser.fromJson(user);
  }

  void clearUserData() {
    // _preferenceManager.prefs.clear();
    _preferenceManager.prefs.remove(Constants.prefsUserKey);
  }
}
