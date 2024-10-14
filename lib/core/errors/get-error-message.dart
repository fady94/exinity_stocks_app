
import 'package:exinity_app/core/errors/failures.dart';

class GetErrorMessage {
  static String json(dynamic response) {
    try {
      var message = response['message'];
      if (message.runtimeType == String) {
        return message;
      } else {
        return message[0];
      }
    } catch (e) {
      throw ServerFailure();
    }
  }
}
