import 'dart:io';

import 'package:intl/intl.dart';

class Currency {
  
  static String php = NumberFormat.simpleCurrency(locale: Platform.localeName, name: 'PHP').currencySymbol;
  
  static RegExp reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
  
  static String Function(Match) mathFunc = (Match match) => '${match[1]},';

  static NumberFormat f = NumberFormat("###,###.0#", "en_US");
}