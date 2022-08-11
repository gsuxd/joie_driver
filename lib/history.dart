import 'package:joiedriver/pedido.dart';
import 'package:flutter/material.dart';
import 'colors.dart';

class Historial extends StatelessWidget {
  const Historial({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          //BARRA DE ARRIBA
          TabBar(
              labelColor: blue,
              unselectedLabelColor: Colors.grey[60],
              indicatorColor: blue,
              tabs: [
                Tab(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: const [
                      Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: blue,
                        size: 35,
                      ),
                      Text(
                        'Activas',
                        style: TextStyle(
                          color: blue,
                          fontSize: 15,
                          fontFamily: "Monserrat",
                        ),
                      ),
                    ],
                  ),
                ),

                //BARRA DE ARRIBA
                //CONTENIDO DE LAS BARRAS
                Tab(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: const [
                      Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: blue,
                        size: 35,
                      ),
                      Text(
                        'Historial',
                        style: TextStyle(
                          color: blue,
                          fontSize: 15,
                          fontFamily: "Monserrat",
                        ),
                      ),
                    ],
                  ),
                ),
              ]),
          //PANTALLAS
          const Expanded(
              child: TabBarView(children: [
            NoResults(),
            Activos(),
          ]))
        ],
      ),
    );
  }
}

//PANTALLA 01
class Activos extends StatelessWidget {
  const Activos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            //Nuevo Elemento
            item(
              context,
              12.33,
              "02/12/2021",
              "Andres Guzman",
              'Viaje Completado',
              blue,
              'https://picsum.photos/seed/913/400',
            ),
            item(
              context,
              20.40,
              "02/12/2021",
              "Sofia Lanus",
              "Viaje Cancelado",
              red,
              'https://i.pinimg.com/originals/cf/c1/d8/cfc1d8b69811d4bacb1377e39d5a74c9.jpg',
            ),
            item(
              context,
              55.12,
              "01/12/2021",
              "Ester Piscore",
              "Viaje Cancelado",
              red,
              'https://cdnb.20m.es/sites/112/2019/04/cara47-620x620.jpg',
            ),
            item(
              context,
              100.50,
              "28/11/2021",
              "Cash Luna",
              "Viaje Completado",
              blue,
              'https://media.biobiochile.cl/wp-content/uploads/2019/02/captura-realizada-el-2019-02-25-15-37-02.png',
            ),
            item(
              context,
              7.66,
              "25/11/2021",
              "Guillermo Maldonado",
              'Viaje Completado',
              blue,
              'https://picsum.photos/seed/913/400',
            ),
            Container(
              height: 60,
            ),
          ],
        )
      ],
    );
  }

  Container item(BuildContext context, double price, String fecha, String title,
      String state, Color color, String url_img) {
    return Container(
      width: MediaQuery.of(context).size.width - 20,
      height: 94,
      margin: const EdgeInsets.only(top: 10.0, bottom: 5.0),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(40)),
        border: Border.all(width: 1.0, color: blue),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 15.0,
              ),
              Container(
                width: 40,
                height: 40,
                clipBehavior: Clip.antiAlias,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: Image.network(
                  url_img,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                height: 52,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 10,
                    ),
                    Text(
                      title,
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          fontFamily: "Monserrat"),
                    ),
                    Text(
                      fecha,
                      style: const TextStyle(
                          fontSize: 10,
                          color: Colors.black87,
                          fontWeight: FontWeight.w500,
                          fontFamily: "Monserrat"),
                    ),
                    Text(
                      state,
                      style: TextStyle(
                          fontSize: 10,
                          color: color,
                          fontWeight: FontWeight.w500,
                          fontFamily: "Monserrat"),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Text(
                    '$price\$',
                    style: const TextStyle(
                        fontSize: 13,
                        color: Colors.black87,
                        fontFamily: "Monserrat"),
                  ),
                ],
              ),
              Container(
                width: 10.0,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              Center(
                child: Text(
                  'Detalles',
                  style: TextStyle(
                    color: blue,
                    fontFamily: "Monserrat",
                    fontSize: 13,
                  ),
                ),
              ),
              VerticalDivider(),
              SizedBox(
                width: 50,
                height: 40,
                child: Center(
                  child: Text(
                    'Borrar',
                    style: TextStyle(
                        color: Colors.black54,
                        fontSize: 13,
                        fontFamily: "Monserrat"),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

// PANTALLA 02
class NoResults extends StatelessWidget {
  const NoResults({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            //Nuevo Elemento
            item(
                context,
                12.33,
                "02/12/2021",
                "Andres Guzman",
                'Viaje Completado',
                blue,
                'https://picsum.photos/seed/913/400',
                "assets/images/estrella5.png"),
            item(
                context,
                20.40,
                "02/12/2021",
                "Sofia Lanus",
                "Viaje Cancelado",
                red,
                'https://hips.hearstapps.com/ellees.h-cdn.co/assets/15/37/1024x1332/1024x1332-por-ti-rostros-activos-personas-luchadoras-12718597-1-esl-es-rostros-activos-personas-luchadoras-jpg.jpg?resize=480:*',
                "assets/images/estrella5.png"),
            item(
                context,
                55.12,
                "01/12/2021",
                "Ester Piscore",
                "Viaje Cancelado",
                red,
                'https://cambiardeimagen.files.wordpress.com/2013/03/moda-masculina-lentes-cara-hombre-carametria-caramorfoligia-consultoria-de-imagen.jpg',
                "assets/images/estrella5.png"),
            item(
                context,
                100.50,
                "28/11/2021",
                "Cash Luna",
                "Viaje Completado",
                blue,
                'https://zhapro.com/profile_photo_banner.php?id=23',
                "assets/images/estrella5.png"),
            item(
                context,
                7.66,
                "25/11/2021",
                "Guillermo Maldonado",
                'Viaje Completado',
                blue,
                'https://picsum.photos/seed/913/400',
                "assets/images/estrella5.png"),
            Container(
              height: 60,
            ),
          ],
        )
      ],
    );
  }

  Container item(BuildContext context, double price, String fecha, String title,
      String state, Color color, String url_img, String rate) {
    return Container(
      width: MediaQuery.of(context).size.width - 20,
      height: 92,
      margin: const EdgeInsets.only(top: 10.0, bottom: 5.0),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(40)),
        border: Border.all(width: 1.0, color: blue),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 15.0,
              ),
              Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    clipBehavior: Clip.antiAlias,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: Image.network(
                      url_img,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    width: 5.0,
                  ),
                  SizedBox(
                    height: 52,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 10,
                        ),
                        Text(
                          title,
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              fontFamily: "Monserrat"),
                        ),
                        Image.asset(
                          rate,
                          height: 15,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    '$price\$',
                    style: const TextStyle(
                        fontSize: 13,
                        color: Colors.black87,
                        fontFamily: "Monserrat"),
                  ),
                ],
              ),
              Container(
                width: 10.0,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                height: 25,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Pedido()));
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    padding: const EdgeInsets.only(
                        top: 0.0, bottom: 0.0, left: 30.0, right: 30.0),
                    shadowColor: Colors.grey,
                    primary: blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                  ),
                  child: const Text(
                    "Ver",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: "Monserrat",
                        fontSize: 12),
                  ),
                ),
              ),
              SizedBox(
                height: 25.0,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    padding: const EdgeInsets.only(
                        top: 0.0, bottom: 0.0, left: 20.0, right: 20.0),
                    shadowColor: Colors.grey,
                    primary: Colors.black38,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                  ),
                  child: const Text(
                    "Ignorar",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: "Monserrat",
                        fontSize: 12),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
