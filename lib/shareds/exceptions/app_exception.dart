import 'dart:convert';

class AppException implements Exception {
  final _message;
  final _statusCode;

  AppException([
    this._message,
    this._statusCode,
  ]);

  String toString() {
    String message = _message;
    return "{\"statusCode\":$_statusCode ,\"stack\": \"" + message + "\"}";
  }

  String toJson() {
    if (_message != "") {
      return jsonDecode(_message);
    }
    return "";
  }

  int getStatusCode() {
    return _statusCode;
  }

  String getMessage() {
    return _message;
  }
}
