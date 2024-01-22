import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:jiffy/jiffy.dart';

/// LOGIC ***
final List<String> letters = [
  'a', 'S', 'w', ')', 'q', 'D', '\$', 'f', ';', 'J', 'g', 'H', 'm', 'U', 'Z', 'o', 'l', 'P', 'c', 'R', 'B', 't', '5', '?',
  'v', 'E', 'k', 'X', 'N', 'y', '0', '!', '1', '%', '2', '*', 'A', '/', '9', '@', 'I', '6', '>', '7', 'K', '{', '4', ' ',
  '-', '"', '#', '(', ',', '.', '[', '\\', ']', '_', '`', '}', '~', '+', '<', '=', '\'', 'C', '3', 'n', ':', 'd', 's',
  'F', 'h', 'L', 'i', 'x', 'Q', 'r', '&', 'G', 'M', 'b', 'O', 'u', '|', 'z', 'T', 'e', '8', 'V', 'p', 'W', 'j', 'Y',
];

/// ENCRYPTING A STRING
String encryption(String name) {
  List<String> date = ("${Jiffy().dayOfYear + 2557}").split('');
  List<String> input = name.split('');
  String encryptedKey = '';
  int keyIndex = 0;
  int counter = 0;

  for (var element in input) {
    counter = (counter < date.length) ? counter : 0;
    keyIndex = letters.indexWhere((index) => index.contains(element)) + int.parse(date[counter]);
    keyIndex = (letters.asMap().containsKey(keyIndex)) ? keyIndex : (letters.length - keyIndex).abs();
    encryptedKey += letters[keyIndex];
    counter++;
  }
  return encryptedKey;
}

/// DECRYPTING AN ENCRYPTED STRING
String decryption(String name) {
  List<String> date = ("${Jiffy().dayOfYear + 2557}").split('');
  List<String> input = name.split('');
  String decryptedKey = '';
  int keyIndex = 0;
  int counter = 0;
  
  for (var element in input) {
    counter = (counter < date.length) ? counter : 0;
    keyIndex = letters.length + letters.indexWhere((index) => index.contains(element)) - int.parse(date[counter]);
    keyIndex = (letters.asMap().containsKey(keyIndex)) ? keyIndex : (letters.length - keyIndex).abs();
    decryptedKey += letters[keyIndex];
    counter++;
  }
  return decryptedKey;
}

/// HASH SHA-1
String hasher(String input) {
  List<int> bytes = utf8.encode(input);
  Digest digest = sha1.convert(bytes);
  return digest.toString();
}