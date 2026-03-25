import 'package:encrypt/encrypt.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';
import 'dart:typed_data';

class EncryptionService {
  static const _storage = FlutterSecureStorage();
  static const _keyAlias = 'encryption_key';

  static Future<String> encrypt(String plainText) async {
    final keyString = await _getOrCreateKey();
    final key = Key.fromBase64(keyString);
    final iv = IV.fromLength(16);
    final encrypter = Encrypter(AES(key));

    final encrypted = encrypter.encrypt(plainText, iv: iv);
    return '${iv.base64}:${encrypted.base64}';
  }

  static Future<String> decrypt(String encryptedData) async {
    final parts = encryptedData.split(':');
    if (parts.length != 2) throw Exception('Invalid encrypted data format');

    final iv = IV.fromBase64(parts[0]);
    final encryptedValue = parts[1];

    final keyString = await _getOrCreateKey();
    final key = Key.fromBase64(keyString);
    final encrypter = Encrypter(AES(key));

    return encrypter.decrypt64(encryptedValue, iv: iv);
  }

  static Future<String> _getOrCreateKey() async {
    String? keyString = await _storage.read(key: _keyAlias);
    if (keyString == null) {
      final key = Key.fromSecureRandom(32);
      keyString = key.base64;
      await _storage.write(key: _keyAlias, value: keyString);
    }
    return keyString;
  }
}
