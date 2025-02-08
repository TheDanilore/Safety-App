// ignore_for_file: library_private_types_in_public_api

import 'package:app_seguridad/src/pages/login_and_register/register/register_page.dart';
import 'package:app_seguridad/src/providers/auth_provider.dart';
import 'package:app_seguridad/src/utils/app_colors.dart';
import 'package:app_seguridad/src/validators/validators.dart';
import 'package:app_seguridad/src/widgets/circular_progress_widget.dart';
import 'package:app_seguridad/src/widgets/imput_decoration.dart';
import 'package:app_seguridad/src/widgets/materialbuttom_widget.dart';
import 'package:app_seguridad/src/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:megataxi_app/src/screen.dart';
// import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //  static String? token;


  @override
  void initState() {
    super.initState();
//  token = PushNotificationService.token;
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProviderP>(context);
    final isLoading = authProvider.isLoading;
    // final isLoadingGoogle = authProvider.isLoadingGoogle;
    return Scaffold(
      body: Column(
        children: [
          // Header with logo and app name
          ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(150),
              bottomRight: Radius.circular(150),
            ),
            child: SizedBox(
              width: double.infinity,
              child: Container(
                color: Colors.blue[900],
                child: const Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 30),
                      child: Text(
                        'PasaPiola',
                        style: TextStyle(
                          fontSize: 32,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    // SizedBox(height: 5),
                    Image(
                      image: AssetImage(
                        'assets/images/logo.png',
                      ),
                      height: 300,
                      width: 300,
                    ),
                    // SizedBox(height: 1),
                  ],
                ),
              ),
            ),
          ),
          // Expanded section
          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Card(
                  child: Form(
                    key: authProvider.formKeyL,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Column(
                      children: [
                                             Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                              onPressed: () {},
                              style: TextButton.styleFrom(
                                backgroundColor: Colors.grey[400],
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    bottomLeft: Radius.circular(20),
                                  ),
                                ),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                                child: Text(
                                  'INICIO',
                                  style: TextStyle(color: Colors.white, fontSize: 16),
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const RegisterPage(),
                                  ),
                                );
                              },
                              style: TextButton.styleFrom(
                                backgroundColor: Colors.teal,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(20),
                                    bottomRight: Radius.circular(20),
                                  ),
                                ),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                                child: Text(
                                  'Registrarse',
                                  style: TextStyle(color: Colors.white, fontSize: 16),
                                ),
                              ),
                            ),
                          ],
                        ),
                        
                        const SizedBox(height: 20),
                        ImputDecorationWidget(
                          hintText: "usuario@gmail.com",
                          labelText: "Ingresa tu email",
                          controller: authProvider.emailController,
                          keyboardType: TextInputType.emailAddress,
                          prefixIcon: const Icon(Icons.email),
                          suffixIcon: const Icon(Icons.edit),
                          validator: Validators.validateEmail,
                        ),
                        const SizedBox(height: 20),
                        ImputDecorationWidget(
                          hintText: "******",
                          labelText: "Ingresa tu contraseña",
                          obscureText: authProvider.isObscure,
                          maxLines: 1,
                          controller: authProvider.passwordController,
                          keyboardType: TextInputType.text,
                          prefixIcon: const Icon(Icons.lock),
                          suffixIcon: IconButton(
                            onPressed: () {
                              authProvider.setIsObscure(!authProvider.isObscure);
                            },
                            icon: Icon(authProvider.isObscure
                                ? Icons.visibility_off
                                : Icons.visibility),
                          ),
                          validator: Validators.validatePassword,
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Checkbox(
                              activeColor: AppColors.primary,
                              checkColor: AppColors.white,
                              value: authProvider.checkbox,
                              onChanged: (value) {
                                authProvider.setCheckbox(!authProvider.checkbox);
                              },
                            ),
                            const TextWidget(
                              text: "Recordar contraseña",
                              fontSize: 15,
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        isLoading
                            ? const CircularProgressWidget(text: "Validando...")
                            : MaterialbuttomWidget(
                                textColor: AppColors.white,
                                color: AppColors.primary,
                                isImage: false,
                                text: 'Iniciar sesión',
                                onPressed: () {
                                  //validar el formulario
                                  final isValid = authProvider
                                      .formKeyL.currentState!
                                      .validate();
                                  if (!isValid) return;
                                  //cerrar el teclado
                                  FocusScope.of(context).unfocus();
                                  //llamar al metodo de login
                                  authProvider.loginUser(
                                    email: authProvider.emailController.text,
                                    password:
                                        authProvider.passwordController.text,
                                    // token: token!,
                                    context: context,
                                  );
                                },
                              ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
