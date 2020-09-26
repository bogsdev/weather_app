import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:weather_app/io/storage/secure_storage.dart';

class SecureStorageImpl implements SecureStorage {
  final FlutterSecureStorage storage;

  SecureStorageImpl(this.storage);

  @override
  Future<void> delete(String key) async {
    await storage.delete(key: key);
  }

  @override
  Future<void> write(String key, String val) async {
    await storage.write(key: key, value: val);
  }

  @override
  Future<String> read(String key) async {
    return await storage.read(key: key);
  }

  @override
  Future<void> deleteAll() {
    // TODO: implement deleteAll
    throw UnimplementedError();
  }
}
