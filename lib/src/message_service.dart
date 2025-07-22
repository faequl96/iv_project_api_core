import 'package:iv_project_api_core/iv_project_api_core.dart';

class MessageService {
  MessageService._();

  static String getFromException(Exception exception) {
    String message = 'Terjadi kesalahan';

    switch (exception) {
      case ApiException(message: var msg):
        message = msg;
      case GeneralException(message: var msg):
        message = msg;
      default:
        message = exception.toString().replaceAll('Exception: ', '');
    }

    return message;
  }
}
