import 'package:intl/intl.dart';

class MoneyUtils {
  static String formatMoney(double value) {
    NumberFormat format = NumberFormat('#,###,###.00', 'pt_BR');
    return format.format(value);
  }
}
