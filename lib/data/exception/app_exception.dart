class AppException implements Exception{

  final _message;
  final _prefix;
  AppException([this._message, this._prefix]);

  @override
  String toString() {
    // TODO: implement toString
    return '$_message$_prefix';
  }
}

class NoInternetException extends AppException{

  NoInternetException([String? message]) : super(message, 'No Internet Connection');
}

class UnauthorizedException extends AppException{

  UnauthorizedException([String? message]) : super(message, 'You dont have access to this');
}

class RequestTimeOutException extends AppException{
  RequestTimeOutException([String? message]) : super(message, 'Request Time out');
}

class FetchDataException extends AppException{
  FetchDataException([String? message]) : super(message, '');
}