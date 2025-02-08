import 'package:app_seguridad/firebase_options.dart';
import 'package:app_seguridad/src/providers/auth_provider.dart';
import 'package:app_seguridad/src/routers/app_routers.dart';
import 'package:app_seguridad/src/routers/routers.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProviderP()),
      ],
      child: MaterialApp(
       debugShowCheckedModeBanner: false,
       localizationsDelegates: const {
        DefaultMaterialLocalizations.delegate,
        DefaultWidgetsLocalizations.delegate,
       },
        locale: const Locale('es'),
        initialRoute: Routes.onboarding,
        routes: appRoutes,
      ),
    );
  }
}
