import 'package:firebase_database/firebase_database.dart';
import 'reporte.dart';

class ReporteDao {
  void guardarReporte(Reporte reporte, String usuario) {
    final DatabaseReference _reporteRef =
        FirebaseDatabase.instance.ref().child("quejas/pasajero/$usuario");
    _reporteRef.push().set(reporte.toJson());
  }

  DatabaseReference obtenerReporte(String usuario) {
    final DatabaseReference _reporteRef =
        FirebaseDatabase.instance.ref().child("quejas/pasajero/$usuario");
    return _reporteRef;
  }

  const ReporteDao();
}
