import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';

/// Returns the HMAC-SHA256 hash of [input] using the provided [secretKey].
String hmacSha256(String input, String secretKey) {
  final bytes = utf8.encode(input);
  final key = utf8.encode(secretKey);
  final hmac256 = Hmac(sha256, key);
  final digest = hmac256.convert(bytes);
  return digest.toString();
}

String generateRandomKey([int length = 32]) {
  final rand = Random.secure();
  final values = List<int>.generate(length, (i) => rand.nextInt(256));
  return base64Url.encode(values);
}