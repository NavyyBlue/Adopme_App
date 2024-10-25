class FirebaseAuthErrorMessages {
  static const Map<String, String> messages = {
    'invalid-email': 'La dirección de correo electrónico no es válida.',
    'user-disabled': 'El usuario correspondiente al correo electrónico ha sido deshabilitado.',
    'user-not-found': 'No se encontró un usuario correspondiente al correo electrónico.',
    'wrong-password': 'La contraseña es incorrecta para el correo electrónico proporcionado.',
    'too-many-requests': 'Demasiadas solicitudes. Por seguridad, espere un momento antes de intentarlo nuevamente.',
    'user-token-expired': 'El usuario ya no está autenticado porque su token de actualización ha expirado.',
    'network-request-failed': 'Error de red. Verifique su conexión a internet.',
    'invalid-credential': 'La contraseña o el correo electrónico proporcionado son incorrectos.',
    'operation-not-allowed': 'Las cuentas de correo electrónico/contraseña no están habilitadas. Habilítelas en la consola de Firebase, en la pestaña de Autenticación.',
  };

  static String getMessage(String code) {
    return messages[code] ?? 'Ocurrió un error desconocido';
  }
}