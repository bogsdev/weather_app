bool isNotEmpty(dynamic obj) {
  if (obj != null) {
    if (obj is String && obj.length > 0) {
      return true;
    } else if (obj is List && obj.length > 0) {
      return true;
    } else if (obj is Map && obj.length > 0) {
      return true;
    } else if (obj is Set && obj.length > 0) {
      return true;
    }
  }
  return false;
}

bool isEmpty(dynamic obj) {
  return !isNotEmpty(obj);
}
