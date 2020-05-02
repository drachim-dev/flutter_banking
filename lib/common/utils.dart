import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class Utils {
  static String getFormattedDate(DateTime dateTime) {
    var formatter = DateFormat('dd.MM.yyyy');
    return formatter.format(dateTime);
  }

  static String getFormattedCurrency(double amount) {
    var formatter = NumberFormat.simpleCurrency(locale: 'DE');
    return formatter.format(amount);
  }

  static String getFormattedNumber(String number) {
    return number.replaceAllMapped(
        RegExp(r'.{4}'), (match) => '${match.group(0)} ');
  }

  static void unfocus() {
    WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
  }
}
