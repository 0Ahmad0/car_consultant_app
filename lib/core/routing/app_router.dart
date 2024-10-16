import 'package:car_consultant/app/screens/add_new_card_screen.dart';
import 'package:car_consultant/app/screens/change_password_screen.dart';
import 'package:car_consultant/app/screens/check_inbox_screen.dart';
import 'package:car_consultant/app/screens/consultant_service_screen.dart';
import 'package:car_consultant/app/screens/details_consultant_service_screen.dart';
import 'package:car_consultant/app/screens/educational_resources_screen.dart';
import 'package:car_consultant/app/screens/emergency_services_screen.dart';
import 'package:car_consultant/app/screens/forgot_password_screen.dart';
import 'package:car_consultant/app/screens/form_submitted_successfull_screen.dart';
import 'package:car_consultant/app/screens/freelance_opportunities_screen.dart';
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
      case Routes.freelanceOpportunitiesRoute:
        return MaterialPageRoute(
          builder: (_) => FreelanceOpportunitiesScreen(),
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
        );case Routes.personalInformationRoute:
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
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('NO DATA')),
          ),
        );
    }
  }
}
