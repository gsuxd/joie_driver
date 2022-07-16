//Importamos las librerias y archivos necesarios
import 'package:flutter/material.dart';
import '../registro/registro.dart';
import 'components/body_terminos.dart';


//Aca empieza todo
class TerminosCondiciones extends StatefulWidget {
  const TerminosCondiciones({Key? key}) : super(key: key);

  @override
  State<TerminosCondiciones> createState() => _TerminosCondicionesState();
}

//Aca colocaremos el Sccafold
class _TerminosCondicionesState extends State<TerminosCondiciones> {
  bool? checked = false;
  bool checkBoxValue = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Terminos y Condiciones"),
        leading:
        Container(
          padding: const EdgeInsets.all(5.0),
          child: GestureDetector(
              onTap: (){
                Navigator.pop(context);
              },
              child: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 18,)
          ),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            //Llamamos al texto que contiene todos los terminos y condiciones
            texto(),
            //Creamos un Checkbox que indica que el usuario ha aceptado los terminos y condiciones
            Container(
              margin: const EdgeInsets.only(top: 5),
              height: 70,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Checkbox(
                    //como valor del checkbox tendremos la variable checked que sera de tipo bool
                    value: checked,
                    //Cada vez que el usuario presione, el valor de checked cambiará a true o false
                    onChanged: (bool? newValue) {
                      setState(() {
                        checked = newValue;
                      });
                    },
                  ),
                  //Texto de complemento
                  const Text("He leido y aceptado los terminos y condiciones"),
                ],
              ),
            ),
            //Aca contendremos el boton de continuar que solo funcionara si el usuario le da al checkbox
            Container(
              width: 150,
              margin: const EdgeInsets.only(bottom: 20),
              child: ElevatedButton(
                //Esta linea es importante: si checked es cierto (si el usuario a presionado el checkbox), entonces el boton tendrá funcionalidad, si no, el boton no servirá
                onPressed: (checked == true ? () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Registro()));
                } : null),
                child: const Text("continuar"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
