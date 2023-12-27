// screen names
abstract class AnalyticsScreenNames {
  static const String splashScreen                  = 'screen_splash';
}


// user identity
abstract class UserIdentity {
  static const String userName         = 'userName';
  static const String userPhone        = 'userPhone';
  static const String userWhats        = 'userWhats';
  static const String userEmail        = 'userEmail';
}

// user actions
const String createPickGoOrderAction       = 'createPickGoOrderAction';
const String scanCartSuccessfulAction      = 'scanCartAction';
const String scannedCartQr                 = 'scannedCartQrCode';
const String scanCartFailedAction          = 'scanCartAction';
const String scanCartError                 = 'scanCartError';
const String scanProductSuccessfulAction   = 'scanProductAction';
const String scanProductFailedAction       = 'scanProductAction';
const String scanProductError              = 'scanProductError';
const String scanPinSuccessfullyAction     = 'scanPinAction';
const String scanPinFailedAction           = 'scanPinAction';
const String notFoundAction                = 'notFoundAction';
const String printAwbAction                = 'printAwb';
const String printReceiptAction            = 'printReceipt';



// debug events
const String debugBaseControllerOnFailed      = 'debug_base_controller_on_failed';
const String debugErrorMessage                = 'debug_error_msg';