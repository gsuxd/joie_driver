import 'dart:io';
class RegisterUser {
  final String name;
  final String lastName;
  final String email;
  final String address;
  final String referenceCode;
  final String code;
  final String phone;
  final String placa;
  final String marca;
  final String date;
  final String password;
  final String genero;
  File? documentVehicle;
  File? documentTarjetaPropiedad;
  File? documentAntecedentes ;
  File? photoPerfil;

  RegisterUser( {
    required this.name,
    required this.lastName,
    required this.email,
    required this.address,
    required this.referenceCode,
    required this.code,
    required this.phone,
    required this.placa,
    required this.marca,
    required this.date,
    required this.password,
    required this.genero,
    required this.documentVehicle,
    required this.documentTarjetaPropiedad,
    required this.documentAntecedentes,
    required this.photoPerfil,
  });


}