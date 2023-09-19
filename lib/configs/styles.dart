import 'package:flutter/material.dart';

class HSpace {
  const HSpace();

  static Widget get s5 => const SizedBox(width: 5);
  static Widget get s10 => const SizedBox(width: 10);
  static Widget get s15 => const SizedBox(width: 15);
  static Widget get s20 => const SizedBox(width: 20);
  static Widget get s25 => const SizedBox(width: 25);
  static Widget get s30 => const SizedBox(width: 30);
  static Widget get s40 => const SizedBox(width: 40);
  static Widget get s60 => const SizedBox(width: 60);
}

class VSpace {
  const VSpace();
  static Widget get s5 => const SizedBox(height: 5);
  static Widget get s10 => const SizedBox(height: 10);
  static Widget get s15 => const SizedBox(height: 15);
  static Widget get s20 => const SizedBox(height: 20);
  static Widget get s25 => const SizedBox(height: 25);
  static Widget get s30 => const SizedBox(height: 30);
  static Widget get s35 => const SizedBox(height: 35);
  static Widget get s40 => const SizedBox(height: 40);
  static Widget get s60 => const SizedBox(height: 60);
}

class Insets {
  static double scale = 1;
  static double offsetScale = 1;
  // Regular paddings
  static double get xs => 4 * scale;
  static double get sm => 8 * scale;
  static double get med => 12 * scale;
  static double get lg => 16 * scale;
  static double get xl => 32 * scale;
  static double get xxl => 60 * scale;
  // Offset, used for the edge of the window, or to separate large sections in the app
  static double get offset => 40 * offsetScale;
}

class IconSizes {
  static double scale = 1;
  static double xs = 8;
  static double sm = 16;
  static double med = 24;
  static double lg = 30;
  static double xl = 40;
}

class FontSizes {
  /// Provides the ability to nudge the app-wide font scale in either direction
  static double get scale => 1;
  static double get s10 => 10 * scale;
  static double get s15 => 15 * scale;
  static double get s11 => 11 * scale;
  static double get s12 => 12 * scale;
  static double get s14 => 14 * scale;
  static double get s16 => 16 * scale;
  static double get s24 => 24 * scale;
  static double get s48 => 48 * scale;
}
