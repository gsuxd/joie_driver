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

  RegisterUser({
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

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'lastName': lastName,
      'email': email,
      'address': address,
      'code': code,
      'phone': phone,
      'date': date,
      'password': password,
      'genero': genero,
      'documentAntecedentes': documentAntecedentes?.path,
      'photoPerfil': photoPerfil?.path,
      'cedulaR': cedulaR?.path,
      'documentId': documentId?.path,
    };
  }

  factory RegisterUser.fromJson(Map<String, dynamic> data) {
    return RegisterUser(
      documentId: data['documentId'] != null ? File(data['documentId']) : null,
      name: data['name'],
      lastName: data['lastName'],
      email: data['email'],
      address: data['address'],
      code: data['code'],
      phone: data['phone'],
      date: data['date'],
      password: data['password'],
      genero: data['genero'],
      documentAntecedentes: data['documentAntecedentes'] != null
          ? File(data['documentAntecedentes'])
          : null,
      photoPerfil:
          data['photoPerfil'] != null ? File(data['photoPerfil']) : null,
      cedulaR: data['cedulaR'] != null ? File(data['cedulaR']) : null,
    );
  }
}
