import 'package:cloud_functions/cloud_functions.dart';

class FunctionsService {
  static FirebaseFunctions get instance => FirebaseFunctions.instance;

  static Future<HttpsCallableResult<dynamic>> callFunction(
      String function, Map<String, dynamic> parameter) {
    return instance.httpsCallable(function).call(parameter);
  }
}
