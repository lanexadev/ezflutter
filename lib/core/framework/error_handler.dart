import 'dart:developer';

class ErrorHandler {
  static void handleError(dynamic error, StackTrace stackTrace) {
    log('[ERROR] ${error.toString()}', error: error, stackTrace: stackTrace);
    
    // Envoyer les erreurs à un serveur distant (ex: Firebase, Sentry)
    // sendErrorToServer(error, stackTrace);
  }
}
