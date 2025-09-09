import 'dart:convert';
import 'package:crypto/crypto.dart';

class TPasswordHelper {
  static String hashPassword(String password) {
    final bytes = utf8.encode(password); // Convert password to bytes
    final digest = sha256.convert(bytes); // Hash using SHA-256
    return digest.toString(); // Convert hash to string
  }
}
