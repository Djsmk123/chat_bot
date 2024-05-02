/// errors.dart
///
/// This file contains an enumeration of error codes and a class representing a client-side exception.
///
/// The [ErrorCode] enum defines various error codes related to network, parsing, storage, API, authentication, and general errors.
///
/// The [ClientSideException] class represents a client-side exception and includes a code of type [ErrorCode] and an optional message.
///
library;

enum ErrorCode {
  // Network related
  noInternetConnection,
  // Parsing related
  jsonDecodeError,
  jsonEncodeError,
  fromJsonError,
  toJsonError,
  // Storage related
  storageError,
  //API related errors
  endPointError,
  //authentication related error
  notAuthenticated,
  //general error
  genericError,
  //imagePickerError
  imagePickerError,
  //cacheExpiredError,
  cacheExpiredError
}

class ClientSideException {
  ClientSideException({
    required this.code,
    this.message,
  });
  final ErrorCode code;
  final String? message;
}
