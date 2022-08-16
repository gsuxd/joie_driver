import 'package:cloud_firestore/cloud_firestore.dart';

class ItemGanancia {

  final String nameReferer;
   final String codeReferer;
   final Timestamp date;
   final double mount;
   final String description;

   ItemGanancia({required this.nameReferer, required this.codeReferer, required this.date, required this.mount, required this.description });
}