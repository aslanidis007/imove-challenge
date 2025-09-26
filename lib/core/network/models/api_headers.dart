import 'dart:collection';

Map<String, V> caseInsensitiveKeyMap<V>([Map<String, V>? value]) {
  final map = LinkedHashMap<String, V>(
    equals: (key1, key2) => key1.toLowerCase() == key2.toLowerCase(),
    hashCode: (key) => key.toLowerCase().hashCode,
  );
  if (value != null && value.isNotEmpty) {
    map.addAll(value);
  }
  return map;
}

class ApiHeaders {
  ApiHeaders({Map<String, List<String>>? headers})
    : headers = caseInsensitiveKeyMap<List<String>>(headers);

  final Map<String, List<String>> headers;
}
