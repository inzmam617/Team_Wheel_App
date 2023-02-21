
import 'package:flutter/painting.dart';

class L10n{

static final all = [
  const Locale('en'),
  const Locale('ar')
];

static String getCode(String code) {
  switch (code) {
    case 'ar':
      return 'عربى';
    case 'en':
    default:
      return 'English';
  }
}
}