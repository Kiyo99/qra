
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qra/constants.dart';
import 'package:qra/core/preference_manager.dart';

class AuthLocalDataSource {
  final PreferenceManager _preferenceManager;
  static final provider = Provider<AuthLocalDataSource>(
    (ref) => AuthLocalDataSource(ref.watch(preferenceManagerProvider)),
  );

  const AuthLocalDataSource(this._preferenceManager);

  void cacheUser(Map<String, dynamic> user) {
    _preferenceManager.saveJsonMap(Constants.prefsUserKey, user);
  }

  Map<String, dynamic> getCachedUser() {
    return _preferenceManager.getJsonMap(Constants.prefsUserKey);
  }

  void clearUserData() {
    // _preferenceManager.prefs.clear();
    _preferenceManager.prefs.remove(Constants.prefsUserKey);
  }

}
