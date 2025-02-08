import 'package:app_seguridad/src/pages/login_and_register/login/login_page.dart';
import 'package:app_seguridad/src/pages/login_and_register/register/register_page.dart';
import 'package:app_seguridad/src/pages/onboarding_page.dart';
import 'package:app_seguridad/src/routers/routers.dart';
import 'package:flutter/material.dart';
// import 'package:megataxi_app/src/api_y_pruebas/prueba_page.dart';
// import 'package:megataxi_app/src/pages/firtsh_page.dart';
// import 'package:megataxi_app/src/pages/login_and_register/login/login_email.dart';
// import 'package:megataxi_app/src/pages/login_and_register/register/register_page.dart';
// import 'package:megataxi_app/src/pages/onboarding_page.dart';
// import 'package:megataxi_app/src/pages/account/recovery_password.dart';
// import 'package:megataxi_app/src/routes/routes.dart';

Map<String, Widget Function(BuildContext)> get appRoutes {
  return {
    Routes.login: (context) => const LoginPage(),
    // Routes.loginEmail: (context) => const LoginEmail(),
    Routes.onboarding: (context) => const OnboardingPage(),
    Routes.register: (context) => const RegisterPage(),
    // Routes.recovery: (context) => const RecoveryPassword(),
    // Routes.firtsh: (context) => const FirtshPage(),
    // Routes.prueba: (context) => const PruebaPage(),
   
  };
}
