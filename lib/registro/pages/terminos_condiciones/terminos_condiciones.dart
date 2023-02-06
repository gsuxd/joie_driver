import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:joiedriver/registro/bloc/registro_data.dart';
import 'package:joiedriver/registro/bloc/registro_enums.dart';
import 'package:joiedriver/registro/pages/registro/registro.dart';
import '../../bloc/registro_bloc.dart';
import 'textos/pasajero.dart';
import 'textos/chofer.dart';

class TerminosCondiciones extends StatefulWidget {
  const TerminosCondiciones({Key? key}) : super(key: key);

  @override
  State<TerminosCondiciones> createState() => _TerminosCondicionesState();
}

class _TerminosCondicionesState extends State<TerminosCondiciones> {
  bool checked = false;
  @override
  void initState() {
    super.initState();
    data = (context.read<RegistroBloc>().state as UpdateRegistroState).userData;
  }

  RegistroData? data;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Terminos y Condiciones"),
        leading: Container(
          padding: const EdgeInsets.all(5.0),
          child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
                size: 18,
              )),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            //Llamamos al texto que contiene todos los terminos y condiciones
            if (data?.type == UserType.chofer) const TerminosChofer(),
            if (data?.type == UserType.pasajero) const TerminosPasajero(),
            if (data?.type == UserType.emprendedor) const TerminosPasajero(),
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
                        checked = newValue!;
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
                onPressed: (checked == true
                    ? () {
                        context.read<RegistroBloc>().add(
                            NextScreenRegistroEvent(
                                context, const RegistroPage(), data!));
                      }
                    : null),
                child: const Text("continuar"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
