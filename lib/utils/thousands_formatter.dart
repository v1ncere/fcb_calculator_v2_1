import 'dart:math';

import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class ThousandsFormatter extends TextInputFormatter {
  final bool allowFraction;
  final int decimalPlaces;
  final bool allowNegative;
  final NumberFormat _formatter;
  ThousandsFormatter({
    this.allowFraction = false,
    this.decimalPlaces = 2,
    this.allowNegative = false,
  }) : _formatter = NumberFormat('#,##0.${'#' * decimalPlaces}');

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    final String decimalSeparator = _formatter.symbols.DECIMAL_SEP;
    return textManipulation(
      oldValue,
      newValue,
      textInputFormatter: allowFraction
        ? (allowNegative ? FilteringTextInputFormatter.allow(RegExp('[0-9-]+([$decimalSeparator])?'))
            : FilteringTextInputFormatter.allow(RegExp('[0-9]+([$decimalSeparator])?')))
        : (allowNegative ? FilteringTextInputFormatter.allow(RegExp('[0-9-]+'))
            : FilteringTextInputFormatter.digitsOnly),
      formatPattern: (String filteredString) {
        if (allowNegative) {
          if ('-'.allMatches(filteredString).isNotEmpty) {
            filteredString = (filteredString.startsWith('-') ? '-' : '') + filteredString.replaceAll('-', '');
          }
        }
        if (filteredString.isEmpty) return '';
        num number;
        if (allowFraction) {
          String decimalDigits = filteredString;
          if (decimalSeparator != '.') {
            decimalDigits = filteredString.replaceFirst(RegExp(decimalSeparator), '.');
          }
          number = double.tryParse(decimalDigits) ?? 0.0;
        } else {
          number = int.tryParse(filteredString) ?? 0;
        }
        final result = _formatter.format(number);
        if (allowFraction && filteredString.endsWith(decimalSeparator)) {
          return '$result$decimalSeparator';
        }
        if (allowNegative) {
          if (allowFraction) {
            if (filteredString == '-' || filteredString == '-0' || filteredString == '-0.') {
              return filteredString;
            }
          }
          if (filteredString == '-') {
            return filteredString;
          }
        }
        if (allowFraction && filteredString.contains('.')) {
          List<String> decimalPlacesValue = filteredString.split(".");
          String decimalOnly = decimalPlacesValue[1];
          String decimalTruncated = decimalOnly.substring(0, min(decimalPlaces, decimalOnly.length));
          double digitsOnly = double.tryParse(decimalPlacesValue[0]) ?? 0.0;
          String result = _formatter.format(digitsOnly);
          result = '$result.$decimalTruncated';
          return result;
        }
        return result;
      },
    );
  }
}

TextEditingValue textManipulation(
  TextEditingValue oldValue,
  TextEditingValue newValue, {
    TextInputFormatter? textInputFormatter,
    String Function(String filteredString)? formatPattern,
}) {
  final originalUserInput = newValue.text;
  newValue = textInputFormatter != null ? textInputFormatter.formatEditUpdate(oldValue, newValue) : newValue;
  int selectionIndex = newValue.selection.end;
  final newText = formatPattern != null ? formatPattern(newValue.text) : newValue.text;
  if (newText == newValue.text) {
    return newValue;
  }
  int insertCount = 0;
  int inputCount = 0;
  bool _isUserInput(String s) {
    if (textInputFormatter == null) return originalUserInput.contains(s);
    return newValue.text.contains(s);
  }
  for (int i = 0; i < newText.length && inputCount < selectionIndex; i++) {
    final character = newText[i];
    if (_isUserInput(character)) {
      inputCount++;
    } else {
      insertCount++;
    }
  }
  selectionIndex += insertCount;
  selectionIndex = min(selectionIndex, newText.length);
  if (selectionIndex - 1 >= 0 && selectionIndex - 1 < newText.length && !_isUserInput(newText[selectionIndex - 1])) {
    selectionIndex--;
  }
  return newValue.copyWith(text: newText, selection: TextSelection.collapsed(offset: selectionIndex), composing: TextRange.empty);
}