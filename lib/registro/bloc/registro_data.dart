import 'dart:io';

import 'package:joiedriver/registro/bloc/registro_enums.dart';
import 'package:joiedriver/singletons/carro_data.dart';

class RegistroData {
  String name;
  String lastName;
  String email;
  String address;
  String lastStep;
  String referenceCode;
  String code;
  String phone;
  String date;
  String password;
  String genero;
  UserType type;
  File? documentAntecedentes;
  File? photoPerfil;
  RegistroDataVehiculo? registroDataVehiculo;
  RegistroDataBank? registroDataBank;
  File? cedula;
  File? cedulaR;

  RegistroData(
      {required this.name,
      required this.lastStep,
      required this.lastName,
      required this.email,
      required this.address,
      required this.referenceCode,
      required this.code,
      required this.phone,
      required this.date,
      required this.password,
      required this.type,
      required this.genero,
      this.documentAntecedentes,
      this.photoPerfil,
      this.cedula,
      this.cedulaR,
      this.registroDataBank,
      this.registroDataVehiculo});

  ///Metodos para serializacion
  factory RegistroData.fromJson(dynamic data) => RegistroData(
      name: data["name"],
      lastStep: data["lastStep"],
      type:
          UserType.values.firstWhere((element) => element.name == data["type"]),
      lastName: data["lastName"],
      email: data["email"],
      address: data["address"],
      referenceCode: data["referenceCode"],
      code: data["code"],
      phone: data["phone"],
      cedula: File(data["cedula"] ?? ""),
      cedulaR: File(data["cedulaR"] ?? ""),
      date: data["date"],
      password: data["password"],
      genero: data["genero"],
      documentAntecedentes: File(data["documentAntecedentes"] ?? ""),
      photoPerfil: File(data["photoPerfil"] ?? ""),
      registroDataBank: RegistroDataBank.fromJson(data["registroDataBank"]),
      registroDataVehiculo:
          RegistroDataVehiculo.fromJson(data["registroDataVehiculo"]));

  toJson() => {
        "name": name,
        "lastName": lastName,
        "email": email,
        "address": address,
        "lastStep": lastStep,
        "type": type.name,
        "referenceCode": referenceCode,
        "code": referenceCode,
        "phone": phone,
        "date": date,
        "cedula": cedula?.path,
        "cedulaR": cedulaR?.path,
        "password": password,
        "genero": genero,
        "documentAntecedentes": documentAntecedentes?.path,
        "photoPerfil": photoPerfil?.path,
        "registroDataBank": registroDataBank?.toJson(),
        "registroDataVehiculo": registroDataVehiculo?.toJson()
      };
}

class RegistroDataBank {
  String? bank;
  String? typeBank;
  String? numberBank;
  String? nameComplete;
  String? numberCi;
  String? dateCi;

  RegistroDataBank(
      {this.bank,
      this.numberBank,
      this.typeBank,
      this.dateCi,
      this.nameComplete,
      this.numberCi});

  ///Metodos para serializacion
  factory RegistroDataBank.fromJson(dynamic data) => RegistroDataBank(
      bank: data["bank"],
      numberBank: data["numberBank"],
      typeBank: data["typeBank"],
      dateCi: data["dateCi"],
      nameComplete: data["nameComplete"],
      numberCi: data["numberCi"]);
  toJson() => {
        "bank": bank,
        "numberBank": numberBank,
        "typeBank": typeBank,
        "dateCi": dateCi,
        "nameComplete": nameComplete,
        "numberCi": numberCi
      };
}

class RegistroDataVehiculo {
  File? documentVehicle;
  File? documentTarjetaPropiedad;
  File? licencia;
  File? licenciaR;
  String placa;
  String marca;
  String year;
  VehicleType type;
  String color;
  int capacidad;
  RegistroDataVehiculo(
      {required this.marca,
      required this.placa,
      this.documentTarjetaPropiedad,
      this.documentVehicle,
      this.licencia,
      this.licenciaR,
      this.capacidad = 1,
      this.color = '',
      this.type = VehicleType.particular,
      this.year = ''});

  ///Metodos para serializacion
  toJson() => {
        "documentVehicle": documentVehicle?.path,
        "documentTarjetaPropiedad": documentTarjetaPropiedad?.path,
        "licencia": licencia?.path,
        "licenciaR": licenciaR?.path,
        "placa": placa,
        "marca": marca,
        "year": year,
        "type": type.name,
        "color": color,
        "capacidad": capacidad,
      };

  factory RegistroDataVehiculo.fromJson(dynamic data) => RegistroDataVehiculo(
      marca: data["marca"],
      placa: data["placa"],
      documentTarjetaPropiedad: File(data["documentTarjetaPropiedad"] ?? ""),
      documentVehicle: File(data["documentVehicle"] ?? ""),
      licencia: File(data["licencia"] ?? ""),
      licenciaR: File(
        data["licenciaR"] ?? "",
      ),
      capacidad: data["capacidad"] ?? 1,
      color: data["color"],
      type: VehicleType.values
          .firstWhere((element) => element.name == data["type"]),
      year: data["year"]);
}
