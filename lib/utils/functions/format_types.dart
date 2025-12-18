import 'package:intl/intl.dart';

String formatDecimalNumber(dynamic number) {
  dynamic formattedNumber = number;
  if (number is String) {
    formattedNumber = num.tryParse(number) ?? 0;
  }

  return NumberFormat.decimalPattern('pt-BR').format(formattedNumber);
}

String formatStringDate(String date) {
  final formatter = DateFormat('dd/MM/yyyy');
  final dateTime = DateTime.parse(date);

  return formatter.format(dateTime);
}

List<String> formatStringDatesToYMD(List<String> dates) {
  final List<String> parsedDateList = [];

  for (var i = 0; i < dates.length; i++) {
    final item = dates[i];
    if (item.isEmpty) {
      parsedDateList.add(item);
      continue;
    }

    parsedDateList.add(item.split('/').reversed.join('-'));
  }

  return parsedDateList;
}
