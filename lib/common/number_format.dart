import 'package:intl/intl.dart';

String toBalanceFormat(String date) {
  return NumberFormat("0,000", "id_ID").format(int.parse(date));
}