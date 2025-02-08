// ignore_for_file: use_build_context_synchronously

// import 'dart:io';

import 'package:app_seguridad/src/utils/app_colors.dart';
import 'package:flutter/material.dart';


void showSnackBar(
  BuildContext context,
  String message,
) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: const TextStyle(color: Colors.white),
      ),
      backgroundColor: AppColors.black,
    ),
  );
}

// //Elegir imagen de Galería
// Future<File?> selectedImageFromGallery(BuildContext context) async {
//   File? image;
//   final picker = ImagePicker();
//   final pickedFile = await picker.pickImage(
//     source: ImageSource.gallery,
//     imageQuality: 80,
//   );
//   if (pickedFile != null) {
//     image = File(pickedFile.path);
//   } else {
//     //showSnackBar(context: context, message: 'No seleccionaste una imagen');
//   }
//   return image;
// }

// //Elegir imagen de Cámara
// Future<File?> selectedImageFromCamera(BuildContext context) async {
//   File? image;
//   final picker = ImagePicker();
//   final pickedFile = await picker.pickImage(
//     source: ImageSource.camera,
//     imageQuality: 80,
//   );
//   if (pickedFile != null) {
//     image = File(pickedFile.path);
//   } else {
//     //showSnackBar(context: context, message: 'No seleccionaste una imagen');
//   }
//   return image;
// }

//Mostrar dialogo para seleccionar imagen
// Future<File?> showImagePickerDialog({
//   required BuildContext context,
//   required Function(File) onImageSelected,
// }) async {
//   final image = await showDialog<File>(
//     context: context,
//     builder: (context) {
//       return AlertDialog(
//         backgroundColor: AppColors.blue,
//         title: const Text('Selecciona una imagen'),
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             ListTile(
//               title: const Text('Galería'),
//               onTap: () async {
//                 final image = await selectedImageFromGallery(context);
//                 if (image != null) {
//                   Navigator.of(context).pop(image);
//                 }
//               },
//               trailing: const Icon(Icons.image),
//             ),
//             ListTile(
//               title: const Text('Cámara'),
//               onTap: () async {
//                 final image = await selectedImageFromCamera(context);
//                 if (image != null) {
//                   Navigator.of(context).pop(image);
//                 }
//               },
//               trailing: const Icon(Icons.camera_alt),
//             ),
//           ],
//         ),
//       );
//     },
//   );
//   if (image != null) {
//     onImageSelected(image);
//   }
//   return image;
// }
