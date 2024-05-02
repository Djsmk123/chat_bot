// Package imports:

import 'package:chat_with_us/core/utils/error/error_code.dart';
import 'package:chat_with_us/core/utils/error/error_utils.dart';
import 'package:logger/logger.dart';

sealed class Result<S> {
  const Result();
}

// Subclass representing a successful result with associated data
final class Success<S> extends Result<S> {
  const Success({required this.data});
  final S data;
}

// Subclass representing a failed result with an error code and optional details
class Failure<S> extends Result<S> {
  const Failure({
    required this.errorType,
    this.details,
  });
  final ClientSideException errorType;
  final String? details;
  // Get the user-friendly error message from the associated error code
  String get message {
    final String errorMessage = errorType.getErrorMessage();
    final Logger logger = Logger();
    logger.log(Level.error, errorMessage, error: '$details');
    return errorMessage;
  }
}
