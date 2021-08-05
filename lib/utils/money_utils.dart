import 'package:intl/intl.dart';

class MoneyUtils {
  static String formatMoney(double value) {
    if (value == 0) return 'R\$ 0,00';

    NumberFormat format = NumberFormat('R\$ #,###,###.00', 'pt_BR');
    return format.format(value);
  }
}
