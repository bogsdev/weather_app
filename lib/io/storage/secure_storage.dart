abstract class SecureStorage {
  Future<void> write(String key, String val);

  Future<String> read(String key);

  Future<void> delete(String key);

  Future<void> deleteAll();
}
