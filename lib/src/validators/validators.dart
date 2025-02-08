class Validators {
  //validar el email
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Ingrese un email';
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'El email debe contener un @ y un dominio.';
    }
    return null;
  }

  //validar la contraseña
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Ingrese una contraseña';
    }
    if (value.length < 8) {
      return 'La contraseña debe tener al menos 8 caracteres';
    }
    return null;
  }

//FECHA DE NACIMIENTO
  static String? birthValidator(value) {
    if (value == null || value.isEmpty) {
      return 'Ingrese tu fecha de nacimiento';
    }

    final dateRegex = RegExp(r'^\d{2}/\d{2}/\d{4}$');
    if (!dateRegex.hasMatch(value)) {
      return 'Ingrese una fecha válida en formato DD/MM/AAAA';
    }

    final parts = value.split('/');
    final day = int.tryParse(parts[0]);
    final month = int.tryParse(parts[1]);
    final year = int.tryParse(parts[2]);

    if (day == null || month == null || year == null) {
      return 'Ingrese una fecha válida en formato DD/MM/AAAA';
    }

    if (day < 1 || day > 31) {
      return 'El día debe estar entre 1 y 31';
    }

    if (month < 1 || month > 12) {
      return 'El mes debe estar entre 1 y 12';
    }

    if (year < 1900 || year > DateTime.now().year) {
      return 'Ingrese un año válido';
    }

    //debe ser mayor de edad
    final birthDate = DateTime(year, month, day);
    final now = DateTime.now();
    final difference = now.difference(birthDate).inDays;
    if (difference < 6570) {
      return 'Debes ser mayor de edad';
    }

    return null;
  }
}
