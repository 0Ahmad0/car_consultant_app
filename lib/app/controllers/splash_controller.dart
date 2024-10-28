
import 'package:car_consultant/core/helpers/extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../core/local/storage.dart';
import '../../core/routing/routes.dart';
import '../../core/utils/app_constant.dart';
import '../../core/widgets/constants_widgets.dart';
import '../screens/login_screen.dart';
import '../screens/navbar/navbar_screen.dart';
import 'auth_controller.dart';
import 'profile_controller.dart';


class SplashController extends GetxController with GetSingleTickerProviderStateMixin   {
  // static SplashController  get instance => Get.find();
   int delaySplash=1;

  
  @override
  Future<void> onInit() async {
    // await initSplash();
    super.onInit();
  }

  Future<void> _loadSplash(BuildContext context)  async {
    await Future.delayed( Duration(seconds: delaySplash), () {
      // Get.offAll(page);
    });



   if((await AppStorage.storageRead(key: AppConstants.rememberMe) as bool?) ??false){
      // ConstantsWidgets.showLoading(context);

      ProfileController profileController=Get.put(ProfileController());

      if((await AppStorage.storageRead(key: AppConstants.rememberMe) as bool?) ??false){
        await profileController.getUser(context);
        // await ProfileController.instance.getUser();

        if(profileController.currentUser.value==null)
          context.pushAndRemoveUntil(Routes.loginRoute, predicate: (Route<dynamic> route) =>false);

        if(profileController.currentUser.value?.isAdmin??false)
          context.pushAndRemoveUntil(Routes.navbarRoute, predicate: (Route<dynamic> route) =>false);

        // Get.offAll(NavbarScreen());
        // Get.offAll(NavBarAdminScreen());
        else
          context.pushAndRemoveUntil(Routes.navbarRoute, predicate: (Route<dynamic> route) =>false);

        // Get.offAll(NavbarScreen());
      }else
        context.pushAndRemoveUntil(Routes.loginRoute, predicate: (Route<dynamic> route) =>false);

     // Get.offAll(LoginScreen());
      }else{
     context.pushAndRemoveUntil(Routes.loginRoute, predicate: (Route<dynamic> route) =>false);

   }


  }
  Future<void> _initSplash(BuildContext context) async {
    await AppStorage.init();
    // Get.put(ProfileController());
    // Get.lazyPut(() => ProfileController());
    Get.lazyPut(() => AuthController());
  }
  Future<void> initSplash(BuildContext context) async {
    await _initSplash(context);
    await _loadSplash(context);
  }

}
