import 'dart:io';

import 'package:app_preference/app_preference.dart';
import 'package:app_storage/app_storage.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sportway/src/app.dart';
import 'package:sportway/src/bloc_observer.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
    DeviceOrientation.landscapeRight,
    DeviceOrientation.landscapeLeft,
  ]);

  if (!kIsWeb) {
    final Directory directory = await getApplicationDocumentsDirectory();

    /// Initialize [Hive]
    Hive.init(directory.path);
  }
  await Firebase.initializeApp();

  /// Initialize app databases
  await AppPreference().initDb();
  await AppStorage().initDb();

  /// Add an observer to bloc events
  Bloc.observer = MyBlocObserver();
  runApp(const App());
}
