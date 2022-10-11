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
  File? documentVehicle;
  File? documentTarjetaPropiedad;
  File? documentAntecedentes;
  File? photoPerfil;
  File? cedula;
  File? cedulaR;
  File? licencia;
  File? licenciaR;

  RegisterUser({
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
    required this.documentVehicle,
    required this.documentTarjetaPropiedad,
    required this.documentAntecedentes,
    required this.photoPerfil,
    required this.cedula,
    required this.cedulaR,
    required this.licencia,
    required this.licenciaR,
    required this.nameComplete,
    required this.numberCi,
    required this.dateCi,
    required this.bank,
    required this.typeBank,
    required this.numberBank,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'lastName': lastName,
      'email': email,
      'address': address,
      'city': city,
      'referenceCode': referenceCode,
      'code': code,
      'phone': phone,
      'placa': placa,
      'marca': marca,
      'date': date,
      'password': password,
      'genero': genero,
      'nameComplete': nameComplete,
      'numberCi': numberCi,
      'dateCi': dateCi,
      'bank': bank,
      'typeBank': typeBank,
      'numberBank': numberBank,
      'documentVehicle': documentVehicle?.path,
      'documentTarjetaPropiedad': documentTarjetaPropiedad?.path,
      'documentAntecedentes': documentAntecedentes?.path,
      'photoPerfil': photoPerfil?.path,
      'cedula': cedula?.path,
      'cedulaR': cedulaR?.path,
      'licencia': licencia?.path,
      'licenciaR': licenciaR?.path,
    };
  }

  factory RegisterUser.fromJson(Map<String, dynamic> data) {
    return RegisterUser(
      name: data['name'],
      lastName: data['lastName'],
      email: data['email'],
      address: data['address'],
      city: data['city'],
      referenceCode: data['referenceCode'],
      code: data['code'],
      phone: data['phone'],
      placa: data['placa'],
      marca: data['marca'],
      date: data['date'],
      password: data['password'],
      genero: data['genero'],
      nameComplete: data['nameComplete'],
      numberCi: data['numberCi'],
      dateCi: data['dateCi'],
      bank: data['bank'],
      typeBank: data['typeBank'],
      numberBank: data['numberBank'],
      documentVehicle: data['documentVehicle'] != null
          ? File(data['documentVehicle'])
          : null,
      documentTarjetaPropiedad: data['documentTarjetaPropiedad'] != null
          ? File(data['documentTarjetaPropiedad'])
          : null,
      documentAntecedentes: data['documentAntecedentes'] != null
          ? File(data['documentAntecedentes'])
          : null,
      photoPerfil:
          data['photoPerfil'] != null ? File(data['photoPerfil']) : null,
      cedula: data['cedula'] != null ? File(data['cedula']) : null,
      cedulaR: data['cedulaR'] != null ? File(data['cedulaR']) : null,
      licencia: data['licencia'] != null ? File(data['licencia']) : null,
      licenciaR: data['licenciaR'] != null ? File(data['licenciaR']) : null,
    );
  }
}
