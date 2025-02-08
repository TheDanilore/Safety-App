import 'package:app_seguridad/src/utils/app_colors.dart';
import 'package:app_seguridad/src/widgets/shimer_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class InicioPage extends StatefulWidget {
  final dynamic userData;
  const InicioPage({super.key, required this.userData});

  @override
  State<InicioPage> createState() => _InicioPageState();
}

class _InicioPageState extends State<InicioPage> {
  int _currentPage = 0;
  dynamic userDatos;

  @override
  void initState() {
    super.initState();
    //print("DATOS DE USUARIO: ${widget.userData}");
    _getUserData();
  }

  void _getUserData() {
    final user = widget.userData['id'];
    final userRef = FirebaseFirestore.instance.collection('users').doc(user);
    userRef.snapshots().listen((event) {
      setState(() {
        userDatos = event.data();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (userDatos == null) {
      return const ShimerWidget();
    } else {
      final pages = [
        // HomePage(userData: userDatos),
        // ViajesPage( userData: userDatos),
        // FavoritosPage( userData: userDatos),
        // ProfilePage(userData: userDatos),
      ];

      return Scaffold(
        body: pages[_currentPage],
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: AppColors.primary,
          unselectedItemColor: AppColors.black,
          currentIndex: _currentPage,
          onTap: (index) {
            setState(() {
              _currentPage = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Inicio',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.local_taxi_rounded),
              label: 'Viajes',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'Favoritos',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Perfil',
            ),
          ],
        ),
      );
    }
  }
}
