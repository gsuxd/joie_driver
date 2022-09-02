import 'package:flutter/material.dart';
import 'package:joie_driver/screens/ofertas_autos/components/ofertas.dart';
import 'package:joie_driver/screens/ofertas_autos/components/ofertas_class.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Creamos la lista conjuntoOfertas que contendra todas las ofertas en una clase Oferta() dandole valores a sus respectivos parametros
    List conjuntoOfertas = [
      Oferta("Elma Ricón", 14, 3, "images/perfil_ofertas.jpg", "toyota", 2020, "auto1.png"),
      Oferta("Elsa Bio", 13, 4, "images/perfil_ofertas.jpg", "Honda", 2020, "auto1.png"),
      Oferta("Elsa Capunta", 156, 5, "images/perfil_ofertas.jpg", "Corsa", 2020, "auto1.png")
    ];
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.all(15.0),
          child: const Text(
            "Oferta de autos en renta",
            style: TextStyle(
                color: Colors.white,
                fontSize: 25.0,
                fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(5),
            itemCount: conjuntoOfertas.length,
            itemBuilder: (context, index) {
              //creamos la variable conjunto que contendra todos los elementos de conjuntoOfertas
              var conjunto = conjuntoOfertas[index];
              return Container(
                //Llamamos a oferta() le pasamos sus respectivos parametros (los valores que tenemos en conjunto para poder simplificar el codigo)
                child: oferta(
                  context: context,
                  nombreUsuario: conjunto.name,
                  price: conjunto.price,
                  stars: conjunto.stars,
                  image: conjunto.img,
                  car: conjunto.car,
                  year: conjunto.year,
                  imageCar: conjunto.imageCar,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
