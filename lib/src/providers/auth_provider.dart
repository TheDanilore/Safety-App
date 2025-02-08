import 'package:app_seguridad/src/pages/inicio_page.dart';
import 'package:app_seguridad/src/utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
enum AuthStatus { chaeking, authenticated, notAuthenticated }
class AuthProviderP extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  // final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

  AuthStatus _authStatus = AuthStatus.chaeking;

  final formKeyL = GlobalKey<FormState>();
  final formKeyR = GlobalKey<FormState>();
  final recoveryForm = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController recoveryEmailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  bool _isObscure = true;
  bool _checkbox = false;
  bool _isLoading = false;
  bool _isLoadingGoogle = false;

  bool get isObscure => _isObscure;
  bool get checkbox => _checkbox;
  bool get isLoading => _isLoading;
  bool get isLoadingGoogle => _isLoadingGoogle;

  void setIsObscure(bool value) {
    _isObscure = value;
    notifyListeners();
  }

  void setCheckbox(bool value) {
    _checkbox = value;
    notifyListeners();
  }

  void setIsLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void setIsLoadingGoogle(bool value) {
    _isLoadingGoogle = value;
    notifyListeners();
  }

  Future<void> subscribeUserToTopic() async {
     await _firebaseMessaging.subscribeToTopic('all');
   }
  Future<void> registerUser({
    required String email,
    required String password,
    required bool checkbox,
    // required String token,
    required BuildContext context,
  }) async {
    setIsLoading(true);
    //cerrar el teclado
    FocusScope.of(context).unfocus();

    //validar formulario
    if (!formKeyR.currentState!.validate()) {
      setIsLoading(false);
      showSnackBar(context, "Complete los campos");
      return;
    }

    try {
      //obtener el nombre de usuario basado en su email hasta antes del @
      final username = email.split('@').first;

      //verificar si el usuario existe en la colección users
      final userExists = await checkEmail(email);
      if (userExists) {
        showSnackBar(context, "El email ya está registrado");
        setIsLoading(false);
        return;
      }

      //verificar las credenciales
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      //guardar el usuario en la colección users
      if (userCredential.user != null) {
        await _firestore.collection('users').doc(userCredential.user!.uid).set({
          'id': userCredential.user!.uid,
          'email': email.toLowerCase(),
          'password': password,
          'checkboxPassword': checkbox,
          'createdAt': DateTime.now(),
          'username': username,
          'rol': 'user',
          'estadoA': "NoRegistrado",
          'imageUser': '',
          // 'token': token,
          'nombre': "",
          'apellido': "",
          'fechaNacimiento': "",
          'telefono': "",
          'sexo': "",
        });

        //enviar email de verificación
        await userCredential.user!.sendEmailVerification();
        // Suscribir al usuario al tema "all"
        await subscribeUserToTopic();
        //mostrar mensaje de éxito
        showSnackBar(context, 'Usuario registrado con éxito');
        setIsLoading(false);
        //limpiar los campos
        emailController.clear();
        passwordController.clear();
        formKeyR.currentState!.reset();
        //redirigir a la página de login
        Navigator.pushNamed(context, '/login');
      }
    } catch (e) {
      print("error: $e");
    }
  }
    //METODO PARA VERIFICAR SI EL EMAIL EXISTE EN LA COLECCION USERS
  Future<bool> checkEmail(String email) async {
    //llamar a la colección users
    final snapshot = await _firestore
        .collection('users')
        .where('email', isEqualTo: email)
        .limit(1)
        .get();
    return snapshot.docs.isNotEmpty;
  }
   //METODO PARA INICIAR SESIÓN
  Future<void> loginUser({
    required String email,
    required String password,
    // required String token,
    required BuildContext context,
  }) async {
    _authStatus;
    notifyListeners();
    //empieza la animación de carga
    setIsLoading(true);
    //cerrar el teclado
    FocusScope.of(context).unfocus();
    try {
      final emailLower = email.toLowerCase();

      //verificar si el email está registrado
      final userExists = await checkEmail(emailLower);
      if (!userExists) {
        showSnackBar(context, 'El email no está registrado');
        setIsLoading(false);
        return;
      }

      //verificar las credenciales
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: emailLower,
        password: password,
      );

      //verificar si el email está verificado
      if (userCredential.user != null && !userCredential.user!.emailVerified) {
        showSnackBar(context, 'Verifica tu email');
        setIsLoading(false);
        return;
      }

      //limpiar los campos
      emailController.clear();
      passwordController.clear();
      formKeyL.currentState!.reset();
      //obtener los datos del usuario basados en su email
      final user = await getUserData(emailLower);
      //actualizar el token
      // if (user['token'] != token) {
      //   updateToken(token, user['id']);
      // }
      //cambiar el estado de la autenticación
      _checkAuthStatus();
      setIsLoading(false);
      //redirigir a la página de inicio
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => InicioPage(userData: user)));
      //mostrar mensaje de éxito
      showSnackBar(context, 'Inicio de sesión exitoso');
    } catch (e) {
      if (e is FirebaseAuthException) {
        switch (e.code) {
          case 'invalid-email':
            setIsLoading(false);
            showSnackBar(context, 'El email proporcionado no es válido.');
            break;
          case 'user-disabled':
            setIsLoading(false);
            showSnackBar(context, 'El usuario ha sido deshabilitado.');
            break;
          case 'user-not-found':
            setIsLoading(false);
            showSnackBar(
                context, 'No se encontró ningún usuario con ese email.');
            break;
          case 'wrong-password':
            setIsLoading(false);
            showSnackBar(context, 'La contraseña es incorrecta.');
            break;
          default:
            setIsLoading(false);
            showSnackBar(context, 'Error de autenticación: ${e.message}');
        }
      } else {
        showSnackBar(context, 'Error de autenticación: $e');
        setIsLoading(false);
      }
    }
  }
  //verificar el estado de la autenticación
  void _checkAuthStatus() async {
    _auth.authStateChanges().listen((User? user) {
      if (user != null) {
        _authStatus = AuthStatus.authenticated;
      } else {
        _authStatus = AuthStatus.notAuthenticated;
      }
      notifyListeners();
    });
  }
   //ACTUALIZAR TOKEN DEL USUARIO BASADO EN SU ID
  Future<void> updateToken(String token, String userId) async {
    //ref a la coleccion
    final ref = _firestore.collection('users');
    try {
      ref.doc(userId).update({'token': token});
    } catch (e) {
      print("ERROR $e");
    }
  }
  //METODO PARA OBTENER DATOS DEL USUARIO BASADOS EN SU EMAIL
  Future<dynamic> getUserData(String email) async {
    final QuerySnapshot<Map<String, dynamic>> result = await _firestore
        .collection('users')
        .where('email', isEqualTo: email)
        .limit(1)
        .get();

    if (result.docs.isNotEmpty) {
      final userData = result.docs[0].data();
      return userData;
    }
    return null;
  }
}
