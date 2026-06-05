import 'package:flutter/material.dart';

class AppPadding {
  // Common padding values
  static const double p4 = 4.0;
  static const double p8 = 8.0;
  static const double p12 = 12.0;
  static const double p16 = 16.0;
  static const double p20 = 20.0;
  static const double p24 = 24.0;
  static const double p32 = 32.0;
  static const double p40 = 40.0;
  static const double p48 = 48.0;

  // EdgeInsets specific shortcuts
  static EdgeInsets all8 = EdgeInsets.all(p8);
  static EdgeInsets all12 = EdgeInsets.all(p12);
  static EdgeInsets all16 = EdgeInsets.all(p16);
  static EdgeInsets all24 = EdgeInsets.all(p24);

  static EdgeInsets horizontal16 = EdgeInsets.symmetric(horizontal: p16);
  static EdgeInsets horizontal24 = EdgeInsets.symmetric(horizontal: p24);

  static EdgeInsets vertical8 = EdgeInsets.symmetric(vertical: p8);
  static EdgeInsets vertical16 = EdgeInsets.symmetric(vertical: p16);
  static EdgeInsets vertical24 = EdgeInsets.symmetric(vertical: p24);
}
