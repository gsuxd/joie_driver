import 'package:joiedriver/pedidos.dart';
import 'package:joiedriver/perfil_usuario.dart';
import 'package:joiedriver/reporte_dao_chofer.dart';
import 'package:joiedriver/reporte_usuario.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:flutter_svg/svg.dart';
import 'colors.dart';
import 'main.dart';
import 'mapa_principal_usuario.dart';

class ReportarChofer extends StatefulWidget {

  @override
  createState() =>  _PedidosState();

}

class _PedidosState extends State<ReportarChofer> {
  int n_elementos = 0;
  List nodes = [];
  bool isSwitched = false;
  Color color_icon_inicio = blue;
  Color color_icon_historial = blue;
  Color color_icon_perfil = blue;
  Color color_icon_ingresos = blue_dark;
  String state = "Calificar";
  TextEditingController _controllerText = TextEditingController();
  int solicitudPedido = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: blue,
          leading:
          Container(
            padding: EdgeInsets.all(5.0),
            child: GestureDetector(
                onTap: (){
                  Navigator.pop(context);
                },
                child: Icon(Icons.arrow_back_ios, color: Colors.white, size: 40,)
            ),
          ),
          title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(state, style: TextStyle(fontFamily: "Monserrat", fontWeight: FontWeight.bold, fontSize: 25.0), textAlign: TextAlign.center,),]
          ),
          actions: [GestureDetector(
            onTap: (){},
            child: SvgPicture.asset(
              "assets/images/share.svg",
              height: 40,
              color: Colors.white,

            ),
          ), Container(
            width: 10.0,
          ),],

        ),
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            ListView(
              children: [
                Container(
                  height: 20,
                ),
                Row(
                  children: [
                    Container(
                      width: 20,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width-40,
                      child: Text("Reportar mal comportamiento del conductor", style: TextStyle(color: Colors.black87, fontFamily: "Monserrat", fontSize: 16.0),),
                    )
                  ],
                ),
                Container(
                  height: 20,
                ),
                item("Acoso sexual", 0),
                Container(height: 15.0,),
                item("Retraso de llegada", 1),
                Container(height: 15.0,),
                item("Lenguaje Ofensivo", 2),
                Container(height: 15.0,),
                item("Conduce de forma peligrosa",3),
                Container(height: 15.0,),
                item("Recargo extra a la carrera",4 ),
                Container(height: 15.0,),
                item("Vehiculo en mal estado",5),
                Container(height: 15.0,),
                item("Uso de sustancia psicoactiva",6),
                Container(height: 15.0,),
                item("Malos olores en el auto",7),
                Container(height: 15.0,),
                item("No coinciden los datos con el auto",8),
                Container(height: 15.0,),
                item("Llevaba un acompanante",9),
                Container(height: 15.0,),
                item("Otros",10),
                Container(height: 65.0,),

              ],
            ),
            Positioned(
                bottom: 10,
                left: 0.0,
                child: bottomNavBar(context))
          ],
        )
    ) ;

  }
  Widget ConectSwitch(BuildContext context) {
    return

      Switch(

        value: isSwitched,
        onChanged: (value) {
          setState(() {
            isSwitched = value;
            if(state == "Desconectado"){
              state = "Conectado";
            }else{
              state = "Desconectado";
            }
          });
        },
        activeTrackColor: Colors.green,
        activeColor: Colors.white,
        inactiveThumbColor: Colors.white,
        inactiveTrackColor: Colors.grey,
      );
  }
  Widget alert(String title, int category){
    return Container(
      height: 200,
      child:
      Column(
        children: [
          itemA(title,),
          Container(
            height: 20.0,
          ),
          Text("Puedes describirnos la falla", style: TextStyle(color: Colors.black87, fontFamily: "Monserrat", fontSize: 14.0),)
          ,Container(
            height: 90.0,
            margin: EdgeInsets.only(top:10.0, bottom: 10.0),
            padding: EdgeInsets.only(left: 5.0, right: 5.0, top: 10.0, bottom: 5.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              border: Border.all(width: 1, color: blue),
            ),
            child: Align(
              alignment: Alignment.topCenter,
              child:
              TextField(

                controller: _controllerText,
                maxLines: 7,
                keyboardType: TextInputType.multiline,
                textInputAction: TextInputAction.newline,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(0),
                  enabledBorder: OutlineInputBorder(
                    gapPadding: 0.01,
                    borderRadius: BorderRadius.all(Radius.circular(0.0)),
                    borderSide: BorderSide(color: Colors.white, width: 0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    gapPadding: 0.01,
                    borderRadius: BorderRadius.all(Radius.circular(0.0)),
                    borderSide: BorderSide(color: Colors.white, width: 0),
                  ),
                ),
              ),),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 10.0,
              ),
              Container(
                height: 22,
                child:
                ElevatedButton(onPressed: (){Navigator.pop(context); _controllerText.clear();
                setState(() {

                });
                },
                  style: ElevatedButton.styleFrom(
                      primary: Colors.grey,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0))
                      )
                  ),
                  child: Center(
                      child: Text("cancelar", style: TextStyle(color: Colors.white, fontFamily: "Monserrat", fontSize: 12.0, fontWeight: FontWeight.bold),)),
                ),),
              Container(
                width: 10.0,
              ),
              Container(
                height: 22,
                child: ElevatedButton(onPressed: (){
                  Query n_reportes = ReporteDaoChofer.obtenerReporteIndividual("usuarioPruebaNuevo");
                  n_reportes.get().then((value) => nodes.add(value.value));

                  //n_reportes.onValue.forEach((v) => nodes.add(v));
                  fetchUserOrder(context, category, );
                },
                    style: ElevatedButton.styleFrom(
                        primary: blue,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0))
                        )
                    ),
                    child: Center(
                      child: Text("reportar", style: TextStyle(color: Colors.white, fontFamily: "Monserrat", fontSize: 12.0, fontWeight: FontWeight.bold),)
                      ,
                    ) ),

              )
              ,
              Container(
                width: 10.0,
              ),


            ],
          )
        ],
      ),);
  }
  Future<void> fetchUserOrder(context, int category,) {
    // Imagine that this function is fetching user info from another service or database.
    return Future.delayed(
        const Duration(milliseconds: 1000),
            () => agregar(category,));
  }

  agregar(int category,){
   print("aqui1");
   print(nodes[0]);
   if(nodes[0] != null){
     final json = nodes[0] as Map<dynamic, dynamic>;
     n_elementos = json.length;
   }

    final _reporte = ReporteUsuario(category: category, descripcion: _controllerText.text, calificacionn: 3.5, n_reportes: n_elementos+1, usuario_emisor: 'usuarioPrueba4', fecha: DateTime.now(), nombre_apellido: 'Carlos Ortiz', usuario_receptor: 'usuarioPruebaNuevo');
    ReporteDaoChofer reporteDao = ReporteDaoChofer();
    reporteDao.guardarReporte(_reporte,);
    Navigator.pop(context);
    _controllerText.clear();
    solicitudPedido = 1;

    print(n_elementos+1);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => MapaMenuUsuario(latitude: 0.0, longitude: 0.0,)));


  }
  GestureDetector item(String title, int category) {
    return GestureDetector(
      onTap: ()=> showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(

          content: alert(title, category),
          contentPadding: EdgeInsets.all(10.0),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))
          ),
          elevation: 48,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 20.0,
          ),
          Text(title, style: TextStyle(color: Colors.black54, fontFamily: "Monserrat", fontSize: 16.0),)
        ],
      ),
    );
  }




  GestureDetector itemA(String title,) {
    return GestureDetector(
      onTap: (){},
      child: Row(
        children: [

          Container(
            width: 10.0,
          ),
          Text(title, style: TextStyle(color: Colors.black54, fontFamily: "Monserrat", fontSize: 12.0),)
        ],
      ),
    );
  }

  Widget bottomNavBar(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Row(

        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MyApp()));
          },
            style: ElevatedButton.styleFrom(
              elevation: 0,
              padding: EdgeInsets.only(top: 2.0, bottom: 2.0, left: 2.0, right: 2.0),
              shadowColor: Colors.grey,
              primary: color_icon_inicio,
              shape: CircleBorder(),
            ),
            child: SvgPicture.asset(
              "assets/images/inicio.svg",
              width: 40,
              color: Colors.white,

            ),

          ),

          Container(
            width: 10,
          ),
          ElevatedButton(onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Pedidos()));
          },
            style: ElevatedButton.styleFrom(
              elevation: 0,
              padding: EdgeInsets.only(top: 2.0, bottom: 2.0, left: 2.0, right: 2.0),
              shadowColor: Colors.grey,
              primary: color_icon_historial,
              shape: CircleBorder(),
            ),
            child: SvgPicture.asset(
              "assets/images/historial2.svg",
              width: 40,
              color: Colors.white,
            ),

          ),
          Container(
            width: 10,
          ),
          ElevatedButton(onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ReportarChofer()));
          },
            style: ElevatedButton.styleFrom(
              elevation: 0,
              padding: EdgeInsets.only(top: 2.0, bottom: 2.0, left: 2.0, right: 2.0),
              shadowColor: Colors.grey,
              primary: color_icon_ingresos,
              shape: CircleBorder(),
            ),
            child: SvgPicture.asset(
              "assets/images/asistencia_tecnica.svg",
              width: 40,
              color: Colors.white,
            ),

          ),
          Container(
            width: 10,
          ),
          ElevatedButton(onPressed: () {
            setState(() {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PerfilUsuario()));
            });

          },
            style: ElevatedButton.styleFrom(
              elevation: 0,
              padding: EdgeInsets.only(top: 2.0, bottom: 2.0, left: 2.0, right: 2.0),
              shadowColor: Colors.grey,
              primary: color_icon_perfil,
              shape: CircleBorder(),
            ),
            child: SvgPicture.asset(
              "assets/images/perfil.svg",
              width: 40,
              color: Colors.white,
            ),

          ),
        ],
      ),
    );
  }

}