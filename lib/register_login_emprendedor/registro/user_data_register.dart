import 'dart:io';
class RegisterUser {
  final String name;
  final String lastName;
  final String email;
  final String address;
  final String city;
  final String referenceCode;
  final String code;
  final String phone;
  final String placa;
  final String marca;
  final String date;
  final String password;
  final String genero;
  String? nameComplete;
  String? numberCi;
  String? dateCi;
  String? bank;
  String? typeBank;
  String? numberBank;
  File? documentAntecedentes;
  File? photoPerfil;
  File? cedula;
  File? cedulaR;


  RegisterUser( {
    required this.name,
    required this.lastName,
    required this.email,
    required this.address,
    required this.city,
    required this.referenceCode,
    required this.code,
    required this.phone,
    required this.placa,
    required this.marca,
    required this.date,
    required this.password,
    required this.genero,
    required this.documentAntecedentes,
    required this.photoPerfil,
    required this.cedula,
    required this.cedulaR,
    required this.nameComplete,
    required this.numberCi,
    required this.dateCi,
    required this.bank,
    required this.typeBank,
    required this.numberBank,
  });


}
