import 'package:get/get.dart';
import 'package:six_cash/data/model/response/language_model.dart';
import 'package:six_cash/data/model/response/on_boarding_model.dart';

import 'images.dart';

class AppConstants {
  static const String APP_NAME = '6Cash';
  //demo

  // static const String BASE_URL = 'YOUR_BASE_URL_HERE';
  // //fun
  static const String BASE_URL = 'https://bankjazeera.com';
  static const bool DEMO = false;
  static const double APP_VERSION = 2.0;

  static const String CUSTOMER_PHONE_CHECK_URI =
      '/api/v1/customer/auth/check-phone';
  static const String CUSTOMER_PHONE_RESEND_OTP_URI =
      '/api/v1/customer/auth/resend-otp';
  static const String CUSTOMER_PHONE_VERIFY_URI =
      '/api/v1/customer/auth/verify-phone';
  static const String CUSTOMER_REGISTRATION_URI =
      '/api/v1/customer/auth/register';
  static const String CUSTOMER_UPDATE_PROFILE =
      '/api/v1/customer/update-profile';
  static const String CUSTOMER_LOGIN_URI = '/api/v1/customer/auth/login';
  static const String CUSTOMER_LOGOUT_URI = '/api/v1/customer/logout';
  static const String CUSTOMER_FORGET_PASS_OTP_URI =
      '/api/v1/customer/auth/forgot-password';
  static const String CUSTOMER_FORGET_PASS_VERIFICATION =
      '/api/v1/customer/auth/verify-token';
  static const String CUSTOMER_FORGET_PASS_RESET =
      '/api/v1/customer/auth/reset-password';
  static const String CUSTOMER_LINKED_WEBSITE =
      '/api/v1/customer/linked-website';
  static const String CUSTOMER_BANNER = '/api/v1/customer/get-banner';
  static const String CUSTOMER_TRANSACTION_HISTORY =
      '/api/v1/customer/transaction-history';
  static const String CUSTOMER_PURPOSE_URL = '/api/v1/customer/get-purpose';
  static const String CONFIG_URI = '/api/v1/config';
  static const String IMAGE_CONFIG_URL_API_NEED =
      '/storage/app/public/purpose/';
  static const String CUSTOMER_PROFILE_INFO = '/api/v1/customer/get-customer';
  static const String CUSTOMER_CHECK_OTP = '/api/v1/customer/check-otp';
  static const String CUSTOMER_VERIFY_OTP = '/api/v1/customer/verify-otp';
  static const String CUSTOMER_CHANGE_PIN = '/api/v1/customer/change-pin';
  static const String CUSTOMER_UPDATE_TWO_FACTOR =
      '/api/v1/customer/update-two-factor';
  static const String CUSTOMER_SEND_MONEY = '/api/v1/customer/send-money';
  static const String CUSTOMER_REQUEST_MONEY = '/api/v1/customer/request-money';
  static const String CUSTOMER_CASH_OUT = '/api/v1/customer/cash-out';
  static const String CUSTOMER_PIN_VERIFY = '/api/v1/customer/verify-pin';
  static const String CUSTOMER_ADD_MONEY = '/api/v1/customer/add-money';
  static const String FAQ_URI = '/api/v1/faq';
  static const String NOTIFICATION_URI = '/api/v1/customer/get-notification';
  static const String TRANSACTION_HISTORY_URI =
      '/api/v1/customer/transaction-history';
  static const String REQUESTED_MONEY_URI =
      '/api/v1/customer/get-requested-money';
  static const String ACCEPTED_REQUESTED_MONEY_URI =
      '/api/v1/customer/request-money/approve';
  static const String DENIED_REQUESTED_MONEY_URI =
      '/api/v1/customer/request-money/deny';
  static const String TOKEN_URI = '/api/v1/customer/update-fcm-token';
  static const String CHECK_CUSTOMER_URI = '/api/v1/check-customer';
  static const String CHECK_AGENT_URI = '/api/v1/check-agent';
  static const String WON_REQUESTED_MONEY =
      '/api/v1/customer/get-own-requested-money';
  static const String CUSTOMER_REMOVE = '/api/v1/customer/remove-account';
  static const String UPDATE_KYC_INFORMATION =
      '/api/v1/customer/update-kyc-information';
  static const String WITHDRAW_METHOD_LIST =
      '/api/v1/customer/withdrawal-methods';
  static const String WITHDRAW_REQUEST = '/api/v1/customer/withdraw';

  // Shared Key
  static const String THEME = 'theme';
  static const String TOKEN = 'token';
  static const String CUSTOMER_COUNTRY_CODE =
      'customer_country_code'; //not in project
  static const String LANGUAGE_CODE = 'language_code';
  static const String CART_LIST = 'cart_list';
  static const String USER_PASSWORD = 'user_password';
  static const String USER_ADDRESS = 'user_address';
  static const String USER_NUMBER = 'user_number';
  static const String SEARCH_ADDRESS = 'search_address';
  static const String TOPIC = 'notify';
  static const String CONFIG = 'config';
  static const String CUSTOMER_NAME = 'customer_name';
  static const String COUNTRY_CODE = 'country_code';
  static const String CUSTOMER_NUMBER = 'customer_number';
  static const String CUSTOMER_QR_CODE = 'customer_qr_code';
  static const String SEND_MONEY_SUGGEST_LIST = 'send_money_suggest';
  static const String REQUEST_MONEY_SUGGEST_LIST = 'request_money_suggest';
  static const String RECENT_AGENT_LIST = 'recent_agent_list';

  static const String PENDING = 'pending';
  static const String APPROVED = 'approved';
  static const String DENIED = 'denied';
  static const String CASH_IN = 'cash_in';
  static const String CASH_OUT = 'cash_out';
  static const String SEND_MONEY = 'send_money';
  static const String RECEIVED_MONEY = 'received_money';
  static const String ADMIN_CHARGE = 'admin_charge';
  static const String ADD_MONEY = 'add_money';
  static const String WITHDRAW = 'withdraw';

  static const String BIOMETRIC_AUTH = 'biometric_auth';
  static const String BIOMETRIC_PIN = 'biometric';

  //topic
  static const String ALL = 'all';
  static const String USERS = 'customers';

  // App Theme
  static const String THEME_1 = 'theme_1';
  static const String THEME_2 = 'theme_2';
  static const String THEME_3 = 'theme_3';

  //input balance digit length
  static const int BALANCE_INPUT_LEN = 10;

  static List<LanguageModel> languages = [
    LanguageModel(
        imageUrl: Images.english,
        languageName: 'English',
        countryCode: 'US',
        languageCode: 'en'),
    LanguageModel(
        imageUrl: Images.saudi,
        languageName: 'Arabic',
        countryCode: 'SA',
        languageCode: 'ar'),
  ];

  static List<OnboardModel> onboardList = [
    OnboardModel(Images.onboard_image_1, Images.onboard_background_1,
        'on_boarding_title_1'.tr, 'on_boarding_sub_title_1'.tr),
    OnboardModel(Images.onboard_image_2, Images.onboard_background_2,
        'on_boarding_title_2'.tr, 'on_boarding_sub_title_2'.tr),
    OnboardModel(Images.onboard_image_3, Images.onboard_background_3,
        'on_boarding_title_3'.tr, 'on_boarding_sub_title_3'.tr),
  ];
}
