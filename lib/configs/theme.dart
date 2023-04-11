import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sportway/configs/color_schemes.g.dart';

final lightTheme = ThemeData(
  useMaterial3: true,
  primaryColor: lightColorScheme.primary,
  colorScheme: lightColorScheme,
).copyWith(
  appBarTheme: AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle(
    statusBarColor: lightColorScheme.surface,
    statusBarIconBrightness: Brightness.dark,
  )),
  elevatedButtonTheme: const ElevatedButtonThemeData(
    style: ButtonStyle(
      minimumSize: MaterialStatePropertyAll(Size(300, 46)),
    ),
  ),
  filledButtonTheme: const FilledButtonThemeData(
    style: ButtonStyle(
      minimumSize: MaterialStatePropertyAll(Size(300, 46)),
    ),
  ),
);
final darkTheme =
    ThemeData(useMaterial3: true, 
    primaryColor: darkColorScheme.primary,
    colorScheme: darkColorScheme).copyWith(
        appBarTheme: AppBarTheme(
            systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: darkColorScheme.surface,
          statusBarIconBrightness: Brightness.light,
        )),
        elevatedButtonTheme: const ElevatedButtonThemeData(
          style: ButtonStyle(
            minimumSize: MaterialStatePropertyAll(Size(300, 46)),
          ),
        ),
        filledButtonTheme: const FilledButtonThemeData(
          style: ButtonStyle(
            minimumSize: MaterialStatePropertyAll(Size(300, 46)),
          ),
        ));
