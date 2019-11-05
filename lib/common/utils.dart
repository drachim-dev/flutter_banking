import 'package:intl/intl.dart';

class Utils {

  static String getFormattedDate(DateTime dateTime) {
    var formatter = DateFormat('dd.MM.yyyy');
    return formatter.format(dateTime);
  }

  static getFormattedCurrency(double amount) {
    var formatter = NumberFormat.simpleCurrency(locale: 'DE');
    return formatter.format(amount);
  }

  static getFormattedNumber(String number) {
    return number.replaceAllMapped(RegExp(r'.{4}'), (match) => '${match.group(0)} ');
  }
}