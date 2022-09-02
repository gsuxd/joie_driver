import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:joie_driver/components/default_button.dart';

//nameAndPrice (widget) contiene el nombre del usuario y el precio del auto 
Row nameAndPrice(String nombreUsuario, int price) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Container(
        margin: const EdgeInsets.only(right: 10.0),
        child: Text(
          nombreUsuario,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.grey[700]),
        ),
      ),
      Text(
        "$price\$",
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
      )
    ],
  );
}


//califAndCar (widget) contiene las estrellas y la marca del auto
Row califAndCar(int estrellas, String car) {
  //Creamos una lista stars cuya cantidad de items sera determinada por el parametro estrella (es un int porque se refiere a la cantidad de estrellas que tendra cada oferta por separado) 
  List<Widget> stars = [];
  //Aca hacemos un ciclo en el cual se le añadira un nuevo elemento a stars. La cantidad de elementos sera determinada por el parametro estrella
  for (var i = 0; i < estrellas; i++) {
    //añade un sizedBox que contiene una estrella individual por cada iteracion
    stars.add(
      SizedBox(
        width: 15,
        height: 15,
        child: SvgPicture.asset("icons/estrella.svg"),
      ),
    );
  }
  //Aun seguimos dentro de un widget asique tenemos que retornarlo
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Row(
        //como hijos del Row seran todos los elementos de stars para ver una estrella al lado de la otra
        children: stars,
      ),
      Text(
        car,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 17.0,
          color: Colors.blue[500],
        ),
      ),
    ],
  );
}

//Ahora Crearemos oferta en donde agruparemos nameAndPrice() y califAndCar() que tendra los siguientes parametros
Container oferta({
  required BuildContext context,
  required String nombreUsuario,
  required int price,
  required int stars,
  required String image,
  required String car,
  required int year,
  required String imageCar,
}) {
  //Una vez detallados los parametros retornaremos un Container que tendra, entre otras cosas, los widgets que hemos creado anteriormente
  return Container(
    width: 300,
    height: 270,
    margin: const EdgeInsets.only(bottom: 20),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: Colors.white,
    ),
    child: Column(
      children: [
        SizedBox(
          width: 300,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: const EdgeInsets.only(right: 15.0, top: 5.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  image:  DecorationImage(
                    image: AssetImage("images/$image"), //llamamos a la imagen del usuario que hace la oferta y le pasamos la carpeta images/ junto con el nombre del archivo el cual sera determinado por el parametro image
                  ),
                ),
                width: 50.0,
                height: 50.0,
              ),
              Container(
                margin: const EdgeInsets.only(right: 5.0),
                child: Column(
                  children: [
                    SizedBox(
                      width: 230,
                      child: nameAndPrice(nombreUsuario, price), //Aca llamamos a nameAndPrice y le pasamos como parametros nombreUsuario (nombre del usuario de la oferta) y price (precio del auto)
                    ),
                    SizedBox(
                      width: 230,
                      child: califAndCar(stars, car),//Aca llamamos a califAndCar y le pasamos como parametros stars (el numero de estrellas que tiene la oferta) y car (la marca del auto)
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            image: DecorationImage(
              image: AssetImage("images/$imageCar"), //llamamos a la imagen del auto respectivamente y le pasamos la carpeta images/ junto con el nombre del archivo el cual sera determinado por el parametro imageCar
            ),
          ),
          width: 300,
          height: 200,
          child: Column(
            children: [
              Container(
                  alignment: Alignment.topRight,
                  margin: const EdgeInsets.only(top: 10.0, right: 5),
                  child: Text(
                    "Year $year",
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0),
                  )),
              Container(
                margin: const EdgeInsets.only(top: 120, left: 190),
                width: 100,
                height: 25,
                child: ButtonDef(text: "Rentar", press: () {}),
              ),
            ],
          ),
        )
      ],
    ),
  );
}
