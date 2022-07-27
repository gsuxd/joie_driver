import 'dart:io';
class RegisterUser {
  final String name;
  final String lastName;
  final String email;
  final String address;
  final String code;
  final String phone;
  final String date;
  final String password;
  final String genero;
  File? documentId;
  File? photoPerfil;
  File? documentAntecedentes;
  File? cedulaR;

  RegisterUser( {
    required this.name,
    required this.lastName,
    required this.email,
    required this.address,
    required this.code,
    required this.phone,
    required this.date,
    required this.password,
    required this.genero,
    required this.documentId,
    required this.photoPerfil,
    required this.documentAntecedentes,
    required this.cedulaR,
  });


}