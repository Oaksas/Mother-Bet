class AppExc implements Exception {
  final String _message;
  AppExc(this._message);

  @override
  String toString() {
    return _message;
  }
}
