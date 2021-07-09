import 'package:mafia/app/di.dart';
import 'package:mafia/data/dio/dio_interceptor.dart';
import 'package:mafia/data/prefs/app_shared_prefs.dart';
import 'package:mafia/data/prefs/app_shared_prefs_impl.dart';
import 'package:shared_preferences/shared_preferences.dart';

void registerApiModule() {
  SharedPreferences.getInstance().then(
    (value) => serviceLocator.registerSingleton<AppSharedPreferences>(
      AppSharedPreferencesImpl(value),
    ),
  );

  serviceLocator.registerSingleton(DioInterceptor());
}
