import 'package:flutter/foundation.dart';

class DateConverter {
  static String convert(int days, bool numbersBased) {
    if (numbersBased) {
      return switch (days) {
        == 0 => "Today",
        == 1 => "Tomorrow",
        > 1 => "$days days",
        _ => kDebugMode ? "error" : "",
      };
    }
    return switch (days) {
      == 0 => "Today",
      == 1 => "Tomorrow",
      < 14 && > 1 => "$days days",
      > 7 => "> 1 week",
      > 30 => "> 1 month",
      _ => kDebugMode ? "error" : "",
    };
  }
}
