import 'package:cloud_firestore/cloud_firestore.dart';

CollectionReference<Map<String, dynamic>> getUserCollection(String type) {
  switch (type) {
    case "chofer":
      {
        return FirebaseFirestore.instance.collection("users");
      }
    case "emprendedor":
      return FirebaseFirestore.instance.collection("usersEmprendedores");
    default:
      return FirebaseFirestore.instance.collection("usersPasajeros");
  }
}
