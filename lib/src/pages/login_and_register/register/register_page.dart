// ignore_for_file: library_private_types_in_public_api

import 'package:app_seguridad/src/providers/auth_provider.dart';
import 'package:app_seguridad/src/utils/app_colors.dart';
import 'package:app_seguridad/src/utils/utils.dart';
import 'package:app_seguridad/src/validators/validators.dart';
import 'package:app_seguridad/src/widgets/circular_progress_widget.dart';
import 'package:app_seguridad/src/widgets/imput_decoration.dart';
import 'package:app_seguridad/src/widgets/materialbuttom_widget.dart';
import 'package:app_seguridad/src/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  static String? token;
@override
  void initState() {
    super.initState();
    // token = PushNotificationService.token;
  }
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProviderP>(context);
    final isLoading = authProvider.isLoading;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
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
                          'Safety',
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
            SingleChildScrollView(
              child: Form(
                key: authProvider.formKeyR,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Card(
                    child: Column(
                      children: [
                        const TextWidget(text: "Crea tu cuenta", fontSize: 24),
                                   
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
                          labelText: "Crea tu contraseña",
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
                            ? const CircularProgressWidget(text: "Registrando...")
                            : MaterialbuttomWidget(
                              textColor: AppColors.white,
                              color: AppColors.primary,
                              isImage: false,
                              text: 'Registrarse',
                              onPressed: () {
                                authProvider.registerUser(
                                  email: authProvider.emailController.text,
                                  password: authProvider.passwordController.text,
                                  checkbox: authProvider.checkbox,
                                  // token: token!,
                                  context: context,
                                );
                              },
                            ),
                        const SizedBox(height: 20),
                        // MaterialbuttomWidget(
                        //   assetImage: 'assets/icons/google.png',
                        //   text: 'Registrar con Google',
                        //   onPressed: () {},
                        // ),
                        const SizedBox(height: 20),
                        // Align(
                        //   alignment: Alignment.bottomCenter,
                        //   child: RichText(
                        //     text: TextSpan(
                        //       text: '¿Ya tienes una cuenta?',
                        //       style: const TextStyle(
                        //         color: AppColors.primary,
                        //         fontSize: 18,
                        //         fontFamily: "AR",
                        //       ),
                        //       children: [
                        //         WidgetSpan(
                        //           alignment: PlaceholderAlignment.middle,
                        //           child: TextButton(
                        //             onPressed: () {
                        //               Navigator.pop(context);
                        //             },
                        //             child: const Text(
                        //               'Inicia sesión',
                        //               style: TextStyle(
                        //                 color: AppColors.brown,
                        //                 fontSize: 18,
                        //                 fontFamily: "ADB",
                        //               ),
                        //             ),
                        //           ),
                        //         ),
                        //       ],
                        //     ),
                        //   ),
                        // ),
                      
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
