import 'package:intl/intl.dart';

String formatTime(DateTime date) {
  final DateFormat formatter = DateFormat('dd/MM/yyyy HH:mm a');
  return formatter.format(date);
}
