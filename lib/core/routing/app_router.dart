import 'package:car_consultant/app/screens/add_new_card_screen.dart';
import 'package:car_consultant/app/screens/admin/admin_application_setting_screen.dart';
import 'package:car_consultant/app/screens/admin/admin_appointments_info_screen.dart';
import 'package:car_consultant/app/screens/admin/admin_appointments_screen.dart';
import 'package:car_consultant/app/screens/admin/admin_consultant_info_screen.dart';
import 'package:car_consultant/app/screens/admin/admin_home_screen.dart';
import 'package:car_consultant/app/screens/admin/admin_navbar_screen.dart';
import 'package:car_consultant/app/screens/admin/admin_notification_settings_screen.dart';
import 'package:car_consultant/app/screens/admin/admin_profile_screen.dart';
import 'package:car_consultant/app/screens/admin/admin_provider_info_screen.dart';
import 'package:car_consultant/app/screens/admin/admin_user_info_screen.dart';
import 'package:car_consultant/app/screens/admin/admin_user_registration_screen.dart';
import 'package:car_consultant/app/screens/admin/admin_users_screen.dart';
import 'package:car_consultant/app/screens/admin/admin_rquests_screen.dart';
import 'package:car_consultant/app/screens/admin/admin_payment_setting_screen.dart';
import 'package:car_consultant/app/screens/admin/admin_request_info_screen.dart';
import 'package:car_consultant/app/screens/become_consultant_screen.dart';
import 'package:car_consultant/app/screens/become_service_provider_screen.dart';
import 'package:car_consultant/app/screens/change_password_screen.dart';
import 'package:car_consultant/app/screens/chat_screen.dart';
import 'package:car_consultant/app/screens/check_inbox_screen.dart';
import 'package:car_consultant/app/screens/consult/consult_control_panel_screen.dart';
import 'package:car_consultant/app/screens/consult/consult_manage_profile_screen.dart';
import 'package:car_consultant/app/screens/consult/consult_manage_request_screen.dart';
import 'package:car_consultant/app/screens/consult_ai_bot_screen.dart';
import 'package:car_consultant/app/screens/consultant_service_screen.dart';
import 'package:car_consultant/app/screens/details_consultant_service_screen.dart';
import 'package:car_consultant/app/screens/educational_resources_screen.dart';
import 'package:car_consultant/app/screens/emergency_services_screen.dart';
import 'package:car_consultant/app/screens/forgot_password_screen.dart';
import 'package:car_consultant/app/screens/form_submitted_successfull_screen.dart';
import 'package:car_consultant/app/screens/opportunities_screen.dart';
import 'package:car_consultant/app/screens/language_screen.dart';
import 'package:car_consultant/app/screens/login_screen.dart';
import 'package:car_consultant/app/screens/navbar/appointments_screen.dart';
import 'package:car_consultant/app/screens/navbar/home_screen.dart';
import 'package:car_consultant/app/screens/navbar/messages_screen.dart';
import 'package:car_consultant/app/screens/navbar/navbar_screen.dart';
import 'package:car_consultant/app/screens/navbar/profile_screen.dart';
import 'package:car_consultant/app/screens/order_details_screen.dart';
import 'package:car_consultant/app/screens/payment_invoice_screen.dart';
import 'package:car_consultant/app/screens/payment_option_screen.dart';
import 'package:car_consultant/app/screens/payment_successful_screen.dart';
import 'package:car_consultant/app/screens/personal_information_screen.dart';
import 'package:car_consultant/app/screens/privacy_policy_screen.dart';
import 'package:car_consultant/app/screens/refund_and_cancellation_policy_screen.dart';
import 'package:car_consultant/app/screens/review_screen.dart';
import 'package:car_consultant/app/screens/service_provider/service_provider_control_panel_screen.dart';
import 'package:car_consultant/app/screens/service_provider/service_provider_manage_profile_screen.dart';
import 'package:car_consultant/app/screens/service_provider/service_provider_manage_request_screen.dart';
import 'package:car_consultant/app/screens/service_provider_screen.dart';
import 'package:car_consultant/app/screens/setting_screen.dart';
import 'package:car_consultant/app/screens/sign_up_screen.dart';
import 'package:car_consultant/app/screens/splash_screen.dart';
import 'package:car_consultant/app/screens/terms_and_conditions_screen.dart';
import 'package:car_consultant/core/routing/routes.dart';
import 'package:flutter/material.dart';

import '../../app/screens/about_us_screen.dart';
import '../../app/screens/contact_us_screen.dart';

class AppRouter {
  Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.initialRoute:
        return MaterialPageRoute(
          builder: (_) => SplashScreen(),
        );

      case Routes.loginRoute:
        return MaterialPageRoute(
          builder: (_) => LoginScreen(),
        );
      case Routes.signUpRoute:
        return MaterialPageRoute(
          builder: (_) => SignUpScreen(),
        );
      case Routes.forgotPasswordRoute:
        return MaterialPageRoute(
          builder: (_) => ForgotPasswordScreen(),
        );
      case Routes.checkYourInboxRoute:
        return MaterialPageRoute(
          builder: (_) => CheckInboxScreen(),
        );

      /// Nav Bar Screens
      case Routes.navbarRoute:
        return MaterialPageRoute(
          builder: (_) => NavbarScreen(),
        );

      case Routes.homeRoute:
        return MaterialPageRoute(
          builder: (_) => HomeScreen(),
        );

      case Routes.messagesRoute:
        return MaterialPageRoute(
          builder: (_) => MessagesScreen(),
        );

      case Routes.appointmentsRoute:
        return MaterialPageRoute(
          builder: (_) => AppointmentsScreen(),
        );

      case Routes.profileRoute:
        return MaterialPageRoute(
          builder: (_) => ProfileScreen(),
        );
      case Routes.consultantServiceRoute:
        return MaterialPageRoute(
          builder: (_) => ConsultantServiceScreen(),
        );
      case Routes.serviceProviderRoute:
        return MaterialPageRoute(
          builder: (_) => ServiceProviderScreen(),
        );
      case Routes.detailsConsultantServiceRoute:
        return MaterialPageRoute(
          builder: (_) => DetailsConsultantServiceScreen(),
        );
      case Routes.orderDetailsRoute:
        return MaterialPageRoute(
          builder: (_) => OrderDetailsScreen(),
        );
      case Routes.paymentOptionRoute:
        return MaterialPageRoute(
          builder: (_) => PaymentOptionScreen(),
        );
      case Routes.paymentInvoiceRoute:
        return MaterialPageRoute(
          builder: (_) => PaymentInvoiceScreen(),
        );
      case Routes.addNewCardRoute:
        return MaterialPageRoute(
          builder: (_) => AddNewCarScreen(),
        );
      case Routes.paymentSuccessfulRoute:
        return MaterialPageRoute(
          builder: (_) => PaymentSuccessfulScreen(),
        );
      case Routes.educationalResourcesRoute:
        return MaterialPageRoute(
          builder: (_) => EducationalResourcesScreen(),
        );
      case Routes.emergencyServicesRoute:
        return MaterialPageRoute(
          builder: (_) => EmergencyServicesScreen(),
        );
      case Routes.opportunitiesRoute:
        return MaterialPageRoute(
          builder: (_) => OpportunitiesScreen(),
        );
      case Routes.becomeConsultRouts:
        return MaterialPageRoute(
          builder: (_) => BecomeConsultScreen(),
        );
      case Routes.becomeServiceProviderRouts:
        return MaterialPageRoute(
          builder: (_) => BecomeServiceProviderScreen(),
        );
      case Routes.aboutUsRoute:
        return MaterialPageRoute(
          builder: (_) => AboutUsScreen(),
        );
      case Routes.contactUsRoute:
        return MaterialPageRoute(
          builder: (_) => ContactUsScreen(),
        );
      case Routes.formSubmitRoute:
        return MaterialPageRoute(
          builder: (_) => FormSubmittedSuccessFullScreen(),
        );
      case Routes.privacyPolicyRoute:
        return MaterialPageRoute(
          builder: (_) => PrivacyPolicyScreen(),
        );
      case Routes.refundAndCancellationPolicyRoute:
        return MaterialPageRoute(
          builder: (_) => RefundAndCancellationPolicyScreen(),
        );
      case Routes.termsAndConditionsRoute:
        return MaterialPageRoute(
          builder: (_) => TermsAndConditionsScreen(),
        );
      case Routes.personalInformationRoute:
        return MaterialPageRoute(
          builder: (_) => PersonalInformationScreen(),
        );
      case Routes.settingRoute:
        return MaterialPageRoute(
          builder: (_) => SettingScreen(),
        );
      case Routes.changePasswordRoute:
        return MaterialPageRoute(
          builder: (_) => ChangePasswordScreen(),
        );
      case Routes.languageRoute:
        return MaterialPageRoute(
          builder: (_) => LanguageScreen(),
        );
      case Routes.aiBotRoute:
        return MaterialPageRoute(
          builder: (_) => ConsultAiBotScreen(),
        );
      case Routes.chatRoute:
        return MaterialPageRoute(
          builder: (_) => ChatScreen(),
        );
      case Routes.reviewRoute:
        return MaterialPageRoute(
          builder: (_) => ReviewScreen(),
        );
      case Routes.adminNavbarRoute:
        return MaterialPageRoute(
          builder: (_) => AdminNavBarScreen(),
        );
      case Routes.adminHomeRoute:
        return MaterialPageRoute(
          builder: (_) => AdminHomeScreen(),
        );
      case Routes.adminUsersRoute:
        return MaterialPageRoute(
          builder: (_) => AdminUsersScreen(),
        );
      case Routes.adminAppointmentsRoute:
        return MaterialPageRoute(
          builder: (_) => AdminAppointmentsScreen(),
        );
      case Routes.adminRequestsRoute:
        return MaterialPageRoute(
          builder: (_) => AdminRequestsScreen(),
        );
      case Routes.adminProfileRoute:
        return MaterialPageRoute(
          builder: (_) => AdminProfileScreen(),
        );
      case Routes.adminUserInfoRoute:
        return MaterialPageRoute(
          builder: (_) => AdminUserInfoScreen(),
        );
      case Routes.adminConsultantInfoRoute:
        return MaterialPageRoute(
          builder: (_) => AdminConsultantInfoScreen(),
        );
      case Routes.adminProviderInfoRoute:
        return MaterialPageRoute(
          builder: (_) => AdminProviderInfoScreen(),
        );
      case Routes.adminRequestInfoRoute:
        return MaterialPageRoute(
          builder: (_) => RequestInfoScreen(),
        );
      case Routes.paymentSettingRoute:
        return MaterialPageRoute(
          builder: (_) => AdminPaymentSettingScreen(),
        );
      case Routes.notificationSettingsRoute:
        return MaterialPageRoute(
          builder: (_) => AdminNotificationSettingsScreen(),
        );
      case Routes.userRegistrationRoute:
        return MaterialPageRoute(
          builder: (_) => AdminUserRegistrationScreen(),
        );
      case Routes.applicationSettingRoute:
        return MaterialPageRoute(
          builder: (_) => AdminApplicationSettingScreen(),
        );
      case Routes.adminAppointmentsInfoRoute:
        return MaterialPageRoute(
          builder: (_) => AdminAppointmentsInfoScreen(),
        );

      ///Consult
      case Routes.consultControlPanelRoute:
        return MaterialPageRoute(
          builder: (_) => ConsultControlPanelScreen(),
        );
      case Routes.consultManageRequestRoute:
        return MaterialPageRoute(
          builder: (_) => ConsultManageRequestScreen(),
        );
        case Routes.consultManageProfileRoute:
        return MaterialPageRoute(
          builder: (_) => ConsultManageProfile(),
        );
      ///Service Provider
      case Routes.serviceProviderControlPanelRoute:
        return MaterialPageRoute(
          builder: (_) => ServiceProviderControlPanelScreen(),
        );
      case Routes.serviceProviderManageRequestRoute:
        return MaterialPageRoute(
          builder: (_) => ServiceProviderManageRequestScreen(),
        );
        case Routes.serviceProviderManageProfileRoute:
        return MaterialPageRoute(
          builder: (_) => ServiceProviderManageProfile(),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('NO DATA')),
          ),
        );
    }
  }
}
