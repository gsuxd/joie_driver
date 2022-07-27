import 'package:firebase_database/firebase_database.dart';
import 'mensaje.dart';
import 'mensaje_dao.dart';
import 'reporte.dart';
import 'package:flutter/material.dart';
class ReporteDao{




    void guardarReporte(Reporte reporte, String usuario){
      final DatabaseReference _reporteRef = FirebaseDatabase.instance.reference().child("quejas/pasajero/$usuario");
      _reporteRef.push().set(reporte.toJson());
    }

    DatabaseReference obtenerReporte(String usuario) {
      final DatabaseReference _reporteRef = FirebaseDatabase.instance.reference().child("quejas/pasajero/$usuario");
      return _reporteRef;
    }
}