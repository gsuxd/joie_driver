import 'package:joiedriver/reporte_usuario.dart';
import 'package:firebase_database/firebase_database.dart';

class ReporteDaoChofer {
  void guardarReporte(ReporteUsuario reporte,) {
    final  String usuario_receptor = reporte.usuario_receptor;
    final DatabaseReference _reporteRefGeneral = FirebaseDatabase.instance.reference().child(
        "reportes/choferes/$usuario_receptor");
    final DatabaseReference _reporteRef = FirebaseDatabase.instance.reference().child(
        "reportes/choferes/$usuario_receptor/reportes");
    _reporteRefGeneral.update(reporte.toJson());
    _reporteRef.push().set(reporte.sms_ini);
  }

  static Query obtenerReporte(int orden) {
    if (orden == 0) {
      print("fecha");
      final Query _reporteRef = FirebaseDatabase.instance.reference().child(
          "reportes/choferes").orderByChild("fecha");
      return _reporteRef;
    }

    if (orden == 1) {
      print("nombre apellido");
      final Query _reporteRef = FirebaseDatabase.instance.reference().child(
          "reportes/choferes").orderByChild("nombre_apellido");
      return _reporteRef;
    }
    if (orden == 2) {
      print("n reportes");
      final Query _reporteRef = FirebaseDatabase.instance.reference().child(
          "reportes/choferes").orderByChild("n_reportes");
      return _reporteRef;
    }

    print("calificacion");
    final Query _reporteRef = FirebaseDatabase.instance.reference().child(
        "reportes/choferes").orderByChild("calificacion");
    return _reporteRef;
  }

  static Query obtenerReporteIndividual(String usuario) {

    print("individual");
    final Query _reporteRef = FirebaseDatabase.instance.reference().child(
        "reportes/choferes/$usuario/reportes");
    return _reporteRef;
  }

}