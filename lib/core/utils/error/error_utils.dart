// Extension to provide user-friendly error messages for ClientSideException
import 'package:chat_with_us/core/utils/error/error_code.dart';

extension ErrorCodeExtensions on ClientSideException {
  // Get a user-friendly error message
  String getErrorMessage() {
    // If a custom message is provided, use it; otherwise, get the default message based on the error code
    return message ?? _getErrorDescription(code);
  }

  // Private method to get the error message based on the error code,for end-user.
  String _getErrorDescription(ErrorCode code) {
    switch (code) {
      case ErrorCode.noInternetConnection:
        return 'No internet connection. Please check your network.';

      case ErrorCode.jsonDecodeError:
        return 'Error decoding data. Please try again later.';

      case ErrorCode.jsonEncodeError:
        return 'Error encoding data. Please try again later.';

      case ErrorCode.fromJsonError:
        return 'Error processing data. Please try again later.';

      case ErrorCode.toJsonError:
        return 'Error preparing data. Please try again later.';

      case ErrorCode.storageError:
        return 'Error accessing storage. Please try again later.';

      case ErrorCode.endPointError:
        return 'Error connecting to the server. Please try again later.';
      case ErrorCode.genericError:
        return 'Something went wrong wrong with us.Please try again later.';
      case ErrorCode.notAuthenticated:
        return 'You are not authenticated,Please try to Login again';
      case ErrorCode.imagePickerError:
        return 'Unable to load file. Please try again later';
      case ErrorCode.cacheExpiredError:
        return 'Cache has been expired';
    }
  }
}
