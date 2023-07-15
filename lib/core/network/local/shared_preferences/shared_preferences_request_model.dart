class SharedPreferencesRequest<T> {
  SharedPreferencesRequest({required this.key, required this.value});
  final String key;
  final T value;
}
