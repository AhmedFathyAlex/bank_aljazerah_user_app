
import 'package:country_code_picker/country_code.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:phone_number/phone_number.dart';
import 'package:six_cash/controller/auth_controller.dart';
import 'package:six_cash/controller/menu_controller.dart';
import 'package:six_cash/controller/profile_screen_controller.dart';
import 'package:six_cash/helper/route_helper.dart';
import 'package:six_cash/util/color_resources.dart';
import 'package:six_cash/util/dimensions.dart';
import 'package:six_cash/util/styles.dart';
import 'package:six_cash/view/base/custom_country_code_picker.dart';
import 'package:six_cash/view/base/custom_password_field.dart';
import 'package:six_cash/view/base/custom_snackbar.dart';
import 'package:six_cash/view/screens/auth/login/widget/login_qr_popup_card.dart';
import 'package:six_cash/view/screens/auth/pin_set/widget/appbar_view.dart';
import 'package:six_cash/view/screens/home/widget/animated_card/custom_rect_tween.dart';
import 'package:six_cash/view/screens/home/widget/animated_card/hero_dialogue_route.dart';


class LoginScreen extends StatefulWidget {
  final String phoneNumber;
  final String countryCode;

  const LoginScreen({Key key, this.phoneNumber, this.countryCode}) : super(key: key);
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with WidgetsBindingObserver {
  TextEditingController phoneController = TextEditingController();
  TextEditingController  passwordController = TextEditingController();
  FocusNode phoneFocus = FocusNode();
  FocusNode passFocus = FocusNode();
  String _heroQrTag = 'hero-qr-tag';
  String _countryCode;

  void setCountryCode(CountryCode code){
    _countryCode = code.toString();
  }
  void setInitialCountryCode(String code){
    _countryCode = code;
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    Get.find<AuthController>().authenticateWithBiometric(true,  null);
  }
  @override
  void initState() {
    super.initState();
    Get.find<AuthController>().authenticateWithBiometric(true, null);
    WidgetsBinding.instance.addObserver(this);
    setInitialCountryCode(widget.countryCode);
    phoneController.text = widget.phoneNumber;
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Theme.of(context).primaryColor,
          body: GetBuilder<AuthController>(builder: (authController) => AbsorbPointer(
            absorbing: authController.isLoading,
            child: Stack(
              children: [
                Column(
                  children: [
                    Expanded(
                      flex: 5,
                      child: Container(color: Theme.of(context).primaryColor,
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: SizedBox(),
                    )
                  ],
                ),
                Positioned(
                  top: Dimensions.PADDING_SIZE_EXTRA_EXTRA_LARGE,
                  left: 0,
                  right: 0,
                  child: AppbarView(isLogin: true,),
                ),
                Positioned(
                  top: 135,
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    padding: const EdgeInsets.only(left: Dimensions.PADDING_SIZE_EXTRA_EXTRA_LARGE, right: Dimensions.PADDING_SIZE_LARGE, top: Dimensions.PADDING_SIZE_EXTRA_EXTRA_LARGE,),
                    width: double.infinity,
                    decoration: BoxDecoration(color: Theme.of(context).cardColor, borderRadius: BorderRadius.only(topLeft: Radius.circular(Dimensions.RADIUS_SIZE_EXTRA_EXTRA_LARGE), topRight: Radius.circular(Dimensions.RADIUS_SIZE_EXTRA_EXTRA_LARGE),),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          GetBuilder<AuthController>(builder: (controller){
                            return Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text('welcome_back'.tr, textAlign: TextAlign.center,
                                      style: rubikLight.copyWith(color: Theme.of(context).textTheme.titleLarge.color,
                                        fontSize: Dimensions.FONT_SIZE_LARGE,),),

                                    controller.getCustomerName().isNotEmpty ?
                                    Container(width: MediaQuery.of(context).size.width * 0.6,
                                      child: Text(
                                        controller.getCustomerName(),
                                        textAlign: TextAlign.start, maxLines: 1, overflow: TextOverflow.ellipsis,
                                        style: rubikMedium.copyWith(color: Theme.of(context).textTheme.titleLarge.color, fontSize: Dimensions.FONT_SIZE_EXTRA_OVER_LARGE,),

                                      ),
                                    ) : Text('user'.tr,
                                      overflow: TextOverflow.clip, textAlign: TextAlign.center,
                                      style: rubikMedium.copyWith(color: Theme.of(context).textTheme.titleLarge.color, fontSize: Dimensions.FONT_SIZE_EXTRA_OVER_LARGE,
                                      ),
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                SizedBox(height: 50, width: 50,
                                  child: Stack(
                                    children: [
                                      GetBuilder<AuthController>(builder: (controller){
                                        return controller.getCustomerQrCode().isNotEmpty ?
                                        InkWell(onTap: (){Navigator.of(context).push(HeroDialogRoute(builder: (context){
                                          return LoginQrPopupCard();}));},
                                          child: Hero(tag: _heroQrTag, createRectTween: (begin, end){
                                            return CustomRectTween(begin: begin,end: end);},
                                              child: Container(
                                                  padding: const EdgeInsets.all(2), color: Colors.white,
                                                  child: SvgPicture.string(controller.getCustomerQrCode(),))),) : Container();}),

                                    ],
                                  ),
                                )
                              ],
                            );
                          }),
                          const SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT,),
                          Row(
                            children: [
                              Text('Account'.tr, style: rubikLight.copyWith(color: Theme.of(context).textTheme.bodyText1.color.withOpacity(0.9), fontSize: Dimensions.FONT_SIZE_LARGE)),
                              Expanded(
                                child: TextField(
                                  controller: phoneController,
                                  focusNode: phoneFocus,
                                  onSubmitted: (value) {
                                    FocusScope.of(context).requestFocus(passFocus);
                                  },
                                  keyboardType: TextInputType.phone,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      contentPadding: const EdgeInsets.only(top: 14),
                                      prefixIcon: CustomCountryCodePiker(
                                        onInit: (code){},
                                        initSelect: widget.countryCode,
                                        onChanged: (code){
                                          print(code);
                                          setCountryCode(code);
                                        },
                                      )
                                  ),
                                ),
                              )
                            ],
                          ),
                          Divider(
                            color: Theme.of(context).textTheme.titleLarge.color.withOpacity(0.4),
                            height: 0.5,
                          ),
                          Container(
                            padding: const EdgeInsets.only(
                                top: Dimensions.PADDING_SIZE_EXTRA_EXTRA_LARGE,
                                right: Dimensions.PADDING_SIZE_SMALL),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('4_digit_pin'.tr, style: rubikMedium.copyWith(color: Theme.of(context).textTheme.titleLarge.color, fontSize: Dimensions.FONT_SIZE_LARGE,),),
                                const SizedBox(height: Dimensions.PADDING_SIZE_LARGE,),
                                CustomPasswordField(
                                  hint: '＊＊＊＊',
                                  controller: passwordController,
                                  focusNode: passFocus,
                                  isShowSuffixIcon: true,
                                  isPassword: true,
                                  isIcon: false,
                                  textAlign: TextAlign.center,

                                ),
                                InkWell(
                                  onTap: (){
                                    Get.toNamed(RouteHelper.getForgetPassRoute(countryCode: _countryCode,phoneNumber: phoneController.text.trim()));
                                  },
                                  child: Text('forget_password'.tr, style: rubikRegular.copyWith(color: ColorResources.getRedColor(), fontSize: Dimensions.FONT_SIZE_LARGE,),),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_OVER_LARGE),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )),
          floatingActionButton: Padding(
              padding: const EdgeInsets.only(bottom: 20, right: 10),
              child: GetBuilder<AuthController>(
                builder: (controller) {
                  return FloatingActionButton(
                    onPressed: () {
                      _login(context);
                    },
                    elevation: 0, backgroundColor: Theme.of(context).secondaryHeaderColor,
                    child: controller.isLoading
                        ? SizedBox(height: Dimensions.PADDING_SIZE_LARGE, width:  Dimensions.PADDING_SIZE_LARGE, child: CircularProgressIndicator(color: Theme.of(context).textTheme.bodyText1.color,),)
                        : SizedBox(child: Icon(Icons.arrow_forward,color: ColorResources.blackColor,size: 28,),),
                  );
                },
              )),
        ),
      ),
    );
  }

  Future<void> _login( BuildContext context) async {
    Get.find<MenuController>().resetNavBar();
    String _code = _countryCode;
    String _phone = phoneController.text.trim();
    String _password = passwordController.text.trim();
    if (_phone.isEmpty) {
      showCustomSnackBar('please_give_your_phone_number'.tr,  isError: true);
    } else if (_password.isEmpty) {
      showCustomSnackBar('please_enter_your_valid_pin'.tr,  isError: true);
    } else if (_password.length != 4) {
      showCustomSnackBar('pin_should_be_4_digit'.tr, isError: true);
    } else {
      String _phoneNumber = _code + _phone;

      try{
        PhoneNumber num = await PhoneNumberUtil().parse(_phoneNumber);
        print('+${num.countryCode}');
        print(num.nationalNumber);
        Get.find<AuthController>().login(code: _code,phone: _phone,password: _password).then((value) async{
          if(value.isOk){
            await Get.find<ProfileController>().profileData(reload: true);
          }
        });
      }catch(e){
        print(e);
        showCustomSnackBar('please_input_your_valid_number'.tr,isError: true);
      }
    }
  }
}
