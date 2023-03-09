import 'package:joiedriver/blocs/user/user_enums.dart';
import 'package:joiedriver/singletons/carro_data.dart';

class UserData {
  String profilePicture;
  final String name;
  final String lastName;
  final String referralsCode;
  final String birthDate;
  final String email;
  final String genero;
  final UserType type;
  final bool verified;
  final CarroData? carroData;
  UserData(
      {required this.type,
      required this.email,
      required this.genero,
      required this.verified,
      required this.profilePicture,
      required this.name,
      required this.birthDate,
      required this.referralsCode,
      required this.lastName,
      this.carroData});

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        profilePicture: json["profilePicture"],
        name: json["name"],
        lastName: json["lastName"],
        referralsCode: json["code"],
        verified: json['verified'],
        birthDate: json["datebirth"],
        email: json["email"],
        genero: json["gender"],
        type: UserType.values
            .firstWhere((element) => element.name == json["type"]),
        carroData: CarroData.fromJson(json["carroData"]),
      );

  Map<String, dynamic> toJson() => {
        "profilePicture": profilePicture,
        "name": name,
        "lastName": lastName,
        "code": referralsCode,
        "datebirth": birthDate,
        "email": email,
        "gender": genero,
        "verified": verified,
        "type": type.name,
        "carroData": carroData ??
            CarroData(
                    brand: "none",
                    year: "2006",
                    type: VehicleType.particular,
                    plate: "plate",
                    color: "color",
                    capacity: "capacity",
                    picture: "picture")
                .toJson()
      };
}
