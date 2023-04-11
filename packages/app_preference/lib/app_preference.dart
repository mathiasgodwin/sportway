library app_preference;

import 'package:hive/hive.dart';

abstract class IAppPreference {
  String? getString({required String key});
  void setString({required String key, required String value});
  bool? getBool({required String key});
  void setBool({required String key, required bool value});
  bool get isFirstLaunch;
  void get setFirstLaunch;
}

class AppPreference implements IAppPreference {
  Future<void> initDb() async {
    await Hive.openBox('app_preference');
  }

  @override
  bool? getBool({required String key}) {
    final box = Hive.box('app_preference');
    final value = box.get(key);
    return value;
  }

  @override
  String? getString({required String key}) {
    final box = Hive.box('app_preference');
    final value = box.get(key);
    return value;
  }

  @override
  void setBool({required String key, required bool value}) {
    final box = Hive.box('app_preference');
    box.put(key, value);
  }

  @override
  void setString({required String key, required String value}) async {
    final box = Hive.box('app_preference');
    await box.put(key, value);
  }

  @override
  bool get isFirstLaunch {
    final box = Hive.box('app_preference');

    return box.get('isFirstLaunch', defaultValue: true);
  }

  @override
  void get setFirstLaunch {
    Hive.box('app_preference').put('isFirstLaunch', false);
  }
}
