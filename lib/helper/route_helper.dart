import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:six_cash/controller/splash_controller.dart';
import 'package:six_cash/data/model/response/contact_model.dart';
import 'package:six_cash/view/screens/add_money/web_screen.dart';
import 'package:six_cash/view/screens/auth/create_account/create_account_screen.dart';
import 'package:six_cash/view/screens/auth/login/login_screen.dart';
import 'package:six_cash/view/screens/auth/other_info/other_info_screen.dart';
import 'package:six_cash/view/screens/auth/pin_set/pin_set_screen.dart';
import 'package:six_cash/view/screens/auth/selfie_capture/camera_screen.dart';
import 'package:six_cash/view/screens/auth/varification/varification_screen.dart';
import 'package:six_cash/view/screens/deshboard/nav_bar_screen.dart';
import 'package:six_cash/view/screens/forget_password/widget/forget_password.dart';
import 'package:six_cash/view/screens/forget_password/widget/phone_verification.dart';
import 'package:six_cash/view/screens/history/history_screen.dart';
import 'package:six_cash/view/screens/home/home_screen.dart';
import 'package:six_cash/view/screens/more/change_language_screen.dart';
import 'package:six_cash/view/screens/onboarding/chose_login_registration/choice_screen.dart';
import 'package:six_cash/view/screens/notification/notification_screen.dart';
import 'package:six_cash/view/screens/profile/widget/change_pin_screen.dart';
import 'package:six_cash/view/screens/profile/widget/edit_profile_screen.dart';
import 'package:six_cash/view/screens/profile/profile_screen.dart';
import 'package:six_cash/view/screens/profile/widget/faq_screen.dart';
import 'package:six_cash/view/screens/profile/widget/html_view_Screen.dart';
import 'package:six_cash/view/screens/profile/widget/qr_code_download_or_share.dart';
import 'package:six_cash/view/screens/profile/widget/support_screen.dart';
import 'package:six_cash/view/screens/requested_money/requested_money_list_screen.dart';
import 'package:six_cash/view/screens/forget_password/widget/reset_password_screen.dart';
import 'package:six_cash/view/screens/splash/splash_screen.dart';
import 'package:six_cash/view/screens/transaction_money/transaction_money_screen.dart';
import 'package:six_cash/view/screens/transaction_money/transaction_money_balance_input.dart';
import 'package:six_cash/view/screens/transaction_money/transaction_money_confirmation.dart';
import 'package:six_cash/view/screens/transaction_money/widget/share_statement_widget.dart';
import 'package:six_cash/view/screens/welcome_screen/welcome_screen.dart';
import 'package:get/get.dart';

class RouteHelper {
  static const String splash = '/splash';
  static const String home = '/home';
  static const String navbar = '/navbar';
  static const String history = '/history';
  static const String notification = '/notification';
  static const String themeAndLanguage = '/themeAndLanguage';
  static const String profile = '/profile';
  static const String change_pin_screen = '/change_pin_screen';
  static const String verify_otp_screen = '/verify_otp_screen';
  static const String no_internet_screen = '/no_internet_screen';
  static const String send_money = '/send_money';
  static const String chose_login_or_reg_screen = '/chose_login_or_reg';
  static const String create_account_screen = '/create_account';
  static const String verify_screen = '/verify_account';
  static const String selfie_screen = '/selfie_screen';
  static const String other_info_screen = '/other_info_screen';
  static const String pin_set_screen = '/pin_set_screen';
  static const String welcome_screen = '/welcome_screen';
  static const String login_screen = '/login_screen';
  static const String f_phone_number_screen = '/f_phone_number';
  static const String f_verification_screen = '/f_verification_screen';
  static const String f_reset_pass_screen = '/f_reset_pass_screen';

  static const String qr_code_scanner_screen = '/qr_code_scanner_screen';
  static const String show_web_view_screen = '/show_web_view_screen';


  static const String send_money_balance_input = '/send_money_balance_inputsend_money_balance_input';
  static const String send_money_confirmation = '/transaction_money_confirmation.dart';

  static const String requestMoney = '/request_money';
  static const String requestMoney_balance_input = '/requestMoney_balance_input';
  static const String requestMoney_confirmation = '/requestMoney_confirmation';

  static const String cash_out = '/cash_out';
  static const String cash_out_balance_input = '/cash_out_balance_input';
  static const String cash_out_confirmation = '/cash_out_confirmation';

  static const String add_money = '/add_money';
  static const String add_money_input = '/add_money_input';
  static const String bank_select = '/bank_select';
  static const String bank_list = '/bank_listbank_list';
  static const String add_money_successful = '/add_money_successful';
  static const String add_money_web = '/add_money_web';
  static const String edit_profile_screen = '/edit_profile_screen';
  static const String faq = '/faq';
  static const String about_us = '/about_us';
  static const String terms = '/terms';
  static const String privacy = '/privacy_policy';
  static const String requested_money = '/requested_money';
  static const String share_statement = '/share_statement';
  static const String support = '/support';
  static const String chose_language_screen = '/chose_language_screen';
  static const String qr_code_download_or_share = '/qr_code_download_or_share';

  static getSplashRoute() => '$splash';
  static String getHomeRoute(String name) => '$home?name=$name';

  static  getLoginRoute({@required String countryCode, @required String phoneNumber}) {
    return '$login_screen?country-code=$countryCode&phone-number=$phoneNumber';
  }
  static  getRegistrationRoute() => '$create_account_screen';
  static  getVerifyRoute() => '$verify_screen';

  static  getWelcomeRoute({String countryCode,String phoneNumber, String password}) {
    return '$welcome_screen?country-code=$countryCode&phone-number=$phoneNumber&password=$password';
  }
  static  getSelfieRoute({@required bool fromEditProfile}) => '$selfie_screen?page=${fromEditProfile?'edit-profile':'verify'}';
  static  getNavBarRoute() => '$navbar';
  static  getOtherInformationRoute() => '$other_info_screen';
  static  getPinSetRoute({@required String occupation, @required String fName,@required String lName, String email}) => '$pin_set_screen?occupation=$occupation&f-name=$fName&l-name=$lName&email=$email';
  static  getRequestMoneyRoute({String phoneNumber,@required bool fromEdit}) => '$requestMoney?phone-number=$phoneNumber&from-edit=${fromEdit?'edit-number':'home'}';
  static  getForgetPassRoute({@required String countryCode,@required String phoneNumber}) => '$f_phone_number_screen?country-code=$countryCode&phone-number=$phoneNumber';
  static  getRequestMoneyBalanceInputRoute() => '$requestMoney_balance_input';
  static  getRequestMoneyConfirmationRoute({@required String inputBalanceText}) => '$requestMoney_confirmation?input-balance=$inputBalanceText';
  static  getNoInternetRoute() => '$no_internet_screen';
  static  getChoseLoginRegRoute() => '$chose_login_or_reg_screen';
  static  getSendMoneyRoute({String phoneNumber,@required bool fromEdit}) => '$send_money?phone-number=$phoneNumber&from-edit=${fromEdit?'edit-number':'home'}';
  static  getSendMoneyInputRoute({@required String transactionType}) => '$send_money_balance_input?transaction-type=$transactionType';
  static  getSendMoneyConfirmationRoute({@required String inputBalanceText,@required String transactionType}) => '$send_money_confirmation?input-balance=$inputBalanceText&transaction-type=$transactionType';
  static  getChoseLanguageRoute() => '$chose_language_screen';
  static  getCashOutScreenRoute({String phoneNumber,@required bool fromEdit}) => '$cash_out?phone-number=$phoneNumber&from-edit=${fromEdit?'edit-number':'home'}';
  static  getCashOutBalanceInputRoute() => '$cash_out_balance_input';
  static  getFResetPassRoute({@required String phoneNumber}) => '$f_reset_pass_screen?phone-number=$phoneNumber';
  static  getEditProfileRoute() => '$edit_profile_screen';
  static  getRequestedMoneyRoute({String from}) => '$requested_money?from=$from';
  static  getChangePinRoute() => '$change_pin_screen';
  static  getAddMoneyInputRoute() => '$add_money_input';
  static  getFVeryficationRoute({@required String phoneNumber}) => '$f_verification_screen?phone-number=$phoneNumber';

  static getSupportRoute() => '$support';
  static getCashOutConfirmationRoute({@required String inputBalanceText}) => '$cash_out_confirmation?input-balance=$inputBalanceText';
  static  getShareStatementRoute({ @required String amount,  @required String transactionType, @required ContactModel contactModel}) {
    String _data =  base64Url.encode(utf8.encode(jsonEncode(contactModel.toJson())));
    String _transactionType = base64Url.encode(utf8.encode(transactionType));
    return '$share_statement?amount=$amount&transaction-type=$_transactionType&contact=$_data';
  }
  static getQrCodeDownloadOrShareRoute({@required String qrCode, @required String phoneNumber}) {
    String _qrCode = base64Url.encode(utf8.encode(qrCode));
    String _phoneNumber = base64Url.encode(utf8.encode(phoneNumber));

    return '$qr_code_download_or_share?qr-code=$_qrCode&phone-number=$_phoneNumber';
  }


  static List<GetPage> routes = [
    GetPage(name: splash, page: () => SplashScreen()),
    GetPage(name: home, page: () => HomeScreen()),
    GetPage(name: navbar, page: () => NavBarScreen()),
    GetPage(name: share_statement, page: () => ShareStatementWidget(amount: Get.parameters['amount'], charge: null, trxId: null,
            transactionType: utf8.decode(base64Url.decode(Get.parameters['transaction-type'].replaceAll(' ', '+'))), contactModel: ContactModel.fromJson(jsonDecode(utf8.decode(base64Url.decode(Get.parameters['contact'])))))),

    GetPage(name: history, page: () => HistoryScreen()),
    GetPage(name: notification, page: () => NotificationScreen()),
    // GetPage(name: themeAndLanguage, page: () => ThemeAndLanguage()),
    GetPage(name: profile, page: () => ProfileScreen()),
    GetPage(name: change_pin_screen, page: () => ChangePinScreen()),
    GetPage(name: send_money, page: () => TransactionMoneyScreen(phoneNumber: Get.parameters['phone-number'],fromEdit: Get.parameters['from-edit']== 'edit-number')),
    GetPage(name: send_money_balance_input, page: () => TransactionMoneyBalanceInput(transactionType: Get.parameters['transaction-type'])),
    GetPage(name: send_money_confirmation, page: () => TransactionMoneyConfirmation(inputBalance:double.tryParse(Get.parameters['input-balance']),transactionType: Get.parameters['transaction-type'])),
    GetPage(name: add_money_web, page: () => WebScreen()),

    GetPage(name: chose_login_or_reg_screen, page: () => ChoiceScreen()),
    GetPage(name: create_account_screen, page: () => CreateAccountScreen()),
    GetPage(name: verify_screen, page: () => VerificationScreen()),
    GetPage(name: selfie_screen, page: () => CameraScreen(fromEditProfile: Get.parameters['page'] == 'edit-profile')),
    GetPage(name: other_info_screen, page: () => OtherInfoScreen()),
    GetPage(name: pin_set_screen, page: () => PinSetScreen(occupation: Get.parameters['occupation'], fName: Get.parameters['f-name'],lName: Get.parameters['l-name'],email: Get.parameters['email'],)),
    GetPage(name: welcome_screen, page: () => WelcomeScreen(
      countryCode: Get.parameters['country-code'].replaceAll(' ', '+'),
      phoneNumber: Get.parameters['phone-number'],
      password: Get.parameters['password'],
    )),
    GetPage(name: login_screen, page: () => LoginScreen(
        countryCode: Get.parameters['country-code'].replaceAll(' ', '+'),
        phoneNumber: Get.parameters['phone-number']),
    ),
    GetPage(name: f_phone_number_screen, page: () => ForgetPassword(countryCode: Get.parameters['country-code'].replaceAll(' ', '+'),phoneNumber: Get.parameters['phone-number'],)),
    GetPage(name: f_verification_screen, page: () => PhoneVerification(phoneNumber: Get.parameters['phone-number'].replaceAll(' ', '+'),)),
    GetPage(name: f_reset_pass_screen, page: () => ResetPasswordScreen(phoneNumber: Get.parameters['phone-number'].replaceAll(' ', '+'),)),
    GetPage(name: chose_language_screen, page: () => ChooseLanguageScreen()),
    GetPage(name: edit_profile_screen, page: () => EditProfileScreen()),
    GetPage(name: requested_money, page: () => RequestedMoneyListScreen(isOwn: Get.parameters['from'] == 'won' ? true : false)),
    // GetPage(name: faq, page: () => FaqScreen(title: 'FAQ')),
    // GetPage(name: terms, page: () => HtmlViewScreen(title: 'Terms & Condition', url: Get.find<SplashController>().configModel.termsAndConditions)),
    // GetPage(name: privacy, page: () => HtmlViewScreen(title: 'Privacy Policy', url: Get.find<SplashController>().configModel.privacyPolicy)),
    GetPage(name: faq, page: () => FaqScreen(title: 'faq'.tr)),
    GetPage(name: terms, page: () => HtmlViewScreen(title: 'terms'.tr, url: Get.find<SplashController>().configModel.termsAndConditions)),
    GetPage(name: about_us, page: () => HtmlViewScreen(title: 'about_us'.tr, url: Get.find<SplashController>().configModel.aboutUs)),
    GetPage(name: privacy, page: () => HtmlViewScreen(title: 'privacy_policy'.tr, url: Get.find<SplashController>().configModel.privacyPolicy)),
    GetPage(name: support, page: () => SupportScreen()),
    GetPage(name: qr_code_download_or_share, page: () => QrCodeDownloadOrShareScreen(qrCode:  utf8.decode(base64Url.decode(Get.parameters['qr-code'].replaceAll(' ', '+'))),
        phoneNumber: utf8.decode(base64Url.decode(Get.parameters['phone-number'].replaceAll(' ', '+'))),)),

    ];

}