import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:intl/intl.dart';
import 'package:marriage_catalog/utils/routes.dart';
import 'dart:js' as js;

class InitialPage extends StatefulWidget {
  const InitialPage({super.key});

  @override
  State<InitialPage> createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  int endTime = DateFormat("yyyy-MM-dd hh:mm:ss")
      .parse("2023-06-09 17:15:00")
      .millisecondsSinceEpoch;

  @override
  Widget build(BuildContext context) {
    return MediaQuery.of(context).size.width > 800
        ? Scaffold(
            backgroundColor: const Color.fromRGBO(237, 255, 213, 100),
            body: SingleChildScrollView(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 1,
                      height: 800,
                      child: Image.asset(
                        "assets/images/capa2.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                    Column(
                      children: [
                        const Divider(color: Colors.transparent),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () {},
                              child: const Text("Inicio",
                                  style: TextStyle(
                                      color: Color.fromRGBO(237, 255, 213, 50),
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      decoration: TextDecoration.underline)),
                            ),
                            const VerticalDivider(),
                            TextButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, MyRoutes.giftCatalogRoute);
                              },
                              child: const Text("Lista de presentes",
                                  style: TextStyle(
                                      color: Color.fromRGBO(237, 255, 213, 50),
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      decoration: TextDecoration.underline)),
                            ),
                            const VerticalDivider(),
                            TextButton(
                              onPressed: () {},
                              child: const Text("Confirmar presença",
                                  style: TextStyle(
                                      color: Color.fromRGBO(237, 255, 213, 50),
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      decoration: TextDecoration.underline)),
                            ),
                            const VerticalDivider(),
                            TextButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, MyRoutes.messageRoute);
                              },
                              child: const Text("Enviar mensagem",
                                  style: TextStyle(
                                      color: Color.fromRGBO(237, 255, 213, 50),
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      decoration: TextDecoration.underline)),
                            ),
                            const VerticalDivider(),
                          ],
                        )
                      ],
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      alignment: Alignment.center,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width / 4,
                        height: 800,
                        child: const FittedBox(
                            fit: BoxFit.fitWidth,
                            child: Text(
                              'GABI & VINI',
                              style: TextStyle(
                                  color: Color.fromRGBO(237, 255, 213, 10)),
                            )),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 800,
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 50),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: const [
                            Text("09 DE JUNHO DE 2023",
                                style: TextStyle(
                                    color: Color.fromRGBO(237, 255, 213, 50),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 22)),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                const Divider(height: 100),
                CountdownTimer(
                  endTime: endTime,
                  widgetBuilder: (_, CurrentRemainingTime? time) {
                    if (time == null) {
                      return const Text("O dia chegou!!",
                          style: TextStyle(color: Colors.red));
                    } else {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              Text('${time.days}',
                                  style: const TextStyle(
                                      color: Color.fromRGBO(85, 107, 47, 50),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 40)),
                              const Text('DIAS',
                                  style: TextStyle(
                                      color: Color.fromRGBO(85, 107, 47, 50),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 20))
                            ],
                          ),
                          const VerticalDivider(width: 30),
                          Column(
                            children: [
                              Text('${time.hours}',
                                  style: const TextStyle(
                                      color: Color.fromRGBO(85, 107, 47, 50),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 40)),
                              const Text('HORAS',
                                  style: TextStyle(
                                      color: Color.fromRGBO(85, 107, 47, 50),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 20))
                            ],
                          ),
                          const VerticalDivider(width: 30),
                          Column(
                            children: [
                              Text('${time.min}',
                                  style: const TextStyle(
                                      color: Color.fromRGBO(85, 107, 47, 50),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 40)),
                              const Text('MINUTOS',
                                  style: TextStyle(
                                      color: Color.fromRGBO(85, 107, 47, 50),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 20))
                            ],
                          )
                        ],
                      );
                      // return Text('days: ${time?.days}, hours: ${time?.hours}, min: ${time?.min}', style: const TextStyle(color: Colors.red));
                    }
                  },
                ),
                const Divider(height: 100),
                Container(
                  color: const Color.fromRGBO(85, 107, 47, 210),
                  height: 300,
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      OutlinedButton(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                              padding:
                                  const EdgeInsets.fromLTRB(20, 22, 20, 22),
                              foregroundColor: Colors.white,
                              backgroundColor:
                                  const Color.fromRGBO(85, 107, 47, 50),
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5))),
                              shadowColor:
                                  const Color.fromRGBO(85, 107, 47, 150),
                              elevation: 10),
                          child: const Text("Confirmar presença")),
                      const VerticalDivider(
                          width: 70, color: Colors.transparent),
                      OutlinedButton(
                          onPressed: () {
                            Navigator.pushNamed(
                                context, MyRoutes.giftCatalogRoute);
                          },
                          style: OutlinedButton.styleFrom(
                              padding:
                                  const EdgeInsets.fromLTRB(20, 22, 20, 22),
                              foregroundColor: Colors.white,
                              backgroundColor:
                                  const Color.fromRGBO(85, 107, 47, 50),
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5))),
                              shadowColor:
                                  const Color.fromRGBO(85, 107, 47, 150),
                              elevation: 10),
                          child: const Text("Lista de presentes")),
                      const VerticalDivider(
                          width: 70, color: Colors.transparent),
                      OutlinedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, MyRoutes.messageRoute);
                          },
                          style: OutlinedButton.styleFrom(
                              padding:
                                  const EdgeInsets.fromLTRB(20, 22, 20, 22),
                              foregroundColor: Colors.white,
                              backgroundColor:
                                  const Color.fromRGBO(85, 107, 47, 50),
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5))),
                              shadowColor:
                                  const Color.fromRGBO(85, 107, 47, 150),
                              elevation: 10),
                          child: const Text("Enviar mensagem")),
                    ],
                  ),
                ),
                const Divider(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Material(
                          child: InkWell(
                            onTap: () {
                              js.context.callMethod('open',
                                  ["https://goo.gl/maps/PzmGShH3PAVQfS1XA"]);
                            },
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: Image.asset(
                                  "assets/images/maps.jpeg",
                                  width: MediaQuery.of(context).size.width / 3,
                                )),
                          ),
                        ),
                        const Text("Clique no mapa",
                            style: TextStyle(
                                color: Color.fromRGBO(85, 107, 47, 50),
                                fontWeight: FontWeight.bold,
                                fontSize: 12)),
                      ],
                    ),
                    const VerticalDivider(
                      width: 100,
                    ),
                    Column(
                      children: [
                        const Text("09 DE JUNHO DE 2023 - 17h15",
                            style: TextStyle(
                                color: Color.fromRGBO(85, 107, 47, 50),
                                fontWeight: FontWeight.bold,
                                fontSize: 18)),
                        const Divider(
                          height: 30,
                        ),
                        const Text("Espaço Villa Borghese",
                            style: TextStyle(
                                color: Color.fromRGBO(85, 107, 47, 50),
                                fontWeight: FontWeight.w400,
                                fontSize: 18)),
                        const Divider(
                          height: 5,
                        ),
                        const Text("AV. Cel Sezefredo Fagundes, 7505",
                            style: TextStyle(
                                color: Color.fromRGBO(85, 107, 47, 50),
                                fontWeight: FontWeight.bold,
                                fontSize: 18)),
                        const Text(
                            "Jardim das Pedras, São Paulo - SP, 02367-075",
                            style: TextStyle(
                                color: Color.fromRGBO(85, 107, 47, 50),
                                fontWeight: FontWeight.bold,
                                fontSize: 18)),
                        const Divider(
                          height: 30,
                        ),
                        ElevatedButton.icon(
                            onPressed: () {
                              js.context.callMethod('open', [
                                "https://calendar.google.com/calendar/event?action=TEMPLATE&tmeid=NTFma3B2ODlwcWdzZDE0MWUzcm1kYWNxZDMgZ3VpcmFyZGVsaWFyYWtha2lAbQ&tmsrc=guirardeliarakaki%40gmail.com"
                              ]);
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                side: const BorderSide(
                                  color: Color.fromRGBO(85, 107, 47, 50),
                                ),
                                elevation: 0,
                                padding:
                                    const EdgeInsets.fromLTRB(10, 15, 10, 15)),
                            icon: const Icon(
                              Icons.calendar_month,
                              color: Color.fromRGBO(85, 107, 47, 80),
                            ),
                            label: const Text("Adicionar à agenda",
                                style: TextStyle(
                                    color: Color.fromRGBO(85, 107, 47, 50),
                                    fontWeight: FontWeight.bold)))
                      ],
                    )
                  ],
                ),
                const Divider(height: 50),
              ],
            )))
        : Scaffold(
            key: _scaffoldKey,
            backgroundColor: const Color.fromRGBO(237, 255, 213, 100),
            extendBodyBehindAppBar: true,
            appBar: AppBar(
                backgroundColor: Colors.transparent,
                leading: IconButton(
                  icon: const Icon(Icons.menu,
                      size: 40,
                      color: Color.fromRGBO(
                          184, 211, 137, 1.0)), // change this size and style
                  onPressed: () => _scaffoldKey.currentState?.openDrawer(),
                )),
            drawer: Drawer(
              backgroundColor: const Color.fromRGBO(237, 255, 213, 1),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("Inicio",
                            style: TextStyle(
                                color: Color.fromRGBO(85, 107, 47, 1),
                                fontSize: 18,
                                fontWeight: FontWeight.w500))),
                    const Divider(),
                    TextButton(
                        onPressed: () {
                          Navigator.pushNamed(
                              context, MyRoutes.giftCatalogRoute);
                        },
                        child: const Text("Lista de presentes",
                            style: TextStyle(
                                color: Color.fromRGBO(85, 107, 47, 1),
                                fontSize: 18,
                                fontWeight: FontWeight.w500))),
                    const Divider(),
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("Confirmar presença",
                            style: TextStyle(
                                color: Color.fromRGBO(85, 107, 47, 1),
                                fontSize: 18,
                                fontWeight: FontWeight.w500))),
                    const Divider(),
                    TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, MyRoutes.messageRoute);
                        },
                        child: const Text("Enviar mensagem",
                            style: TextStyle(
                                color: Color.fromRGBO(85, 107, 47, 1),
                                fontSize: 18,
                                fontWeight: FontWeight.w500)))
                  ]),
            ),
            body: SingleChildScrollView(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    MediaQuery.of(context).size.width > 600
                        ? SizedBox(
                            width: MediaQuery.of(context).size.width / 1,
                            height: MediaQuery.of(context).size.height / 2,
                            child: Image.asset(
                              "assets/images/capa2.png",
                              fit: BoxFit.fitWidth,
                            ),
                          )
                        : SizedBox(
                            width: MediaQuery.of(context).size.width / 1,
                            height: MediaQuery.of(context).size.height / 1.6,
                            child: Image.asset(
                              "assets/images/capa2.png",
                              fit: BoxFit.fitHeight,
                            ),
                          ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      alignment: Alignment.center,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width / 4,
                        height: MediaQuery.of(context).size.height / 2,
                        child: const FittedBox(
                            fit: BoxFit.fitWidth,
                            child: Text(
                              'GABI & VINI',
                              style: TextStyle(
                                  color: Color.fromRGBO(237, 255, 213, 10)),
                            )),
                      ),
                    ),
                    Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height / 2,
                        alignment: Alignment.bottomCenter,
                        child: const Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 50),
                          child: FittedBox(
                            fit: BoxFit.fitWidth,
                            child: Text(
                              "09 DE JUNHO DE 2023",
                              style: TextStyle(
                                  color: Color.fromRGBO(237, 255, 213, 10)),
                            ),
                          ),
                        ))
                  ],
                ),
                const Divider(height: 50),
                CountdownTimer(
                  endTime: endTime,
                  widgetBuilder: (_, CurrentRemainingTime? time) {
                    if (time == null) {
                      return const Text("O dia chegou!!",
                          style: TextStyle(color: Colors.red));
                    } else {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              Text('${time.days}',
                                  style: const TextStyle(
                                      color: Color.fromRGBO(85, 107, 47, 50),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 40)),
                              const Text('DIAS',
                                  style: TextStyle(
                                      color: Color.fromRGBO(85, 107, 47, 50),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 20))
                            ],
                          ),
                          const VerticalDivider(width: 30),
                          Column(
                            children: [
                              Text('${time.hours}',
                                  style: const TextStyle(
                                      color: Color.fromRGBO(85, 107, 47, 50),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 40)),
                              const Text('HORAS',
                                  style: TextStyle(
                                      color: Color.fromRGBO(85, 107, 47, 50),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 20))
                            ],
                          ),
                          const VerticalDivider(width: 30),
                          Column(
                            children: [
                              Text('${time.min}',
                                  style: const TextStyle(
                                      color: Color.fromRGBO(85, 107, 47, 50),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 40)),
                              const Text('MINUTOS',
                                  style: TextStyle(
                                      color: Color.fromRGBO(85, 107, 47, 50),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 20))
                            ],
                          )
                        ],
                      );
                      // return Text('days: ${time?.days}, hours: ${time?.hours}, min: ${time?.min}', style: const TextStyle(color: Colors.red));
                    }
                  },
                ),
                const Divider(height: 50),
                Container(
                  color: const Color.fromRGBO(85, 107, 47, 210),
                  height: 300,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      OutlinedButton(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                              padding:
                                  const EdgeInsets.fromLTRB(20, 22, 20, 22),
                              foregroundColor: Colors.white,
                              backgroundColor:
                                  const Color.fromRGBO(85, 107, 47, 50),
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5))),
                              shadowColor:
                                  const Color.fromRGBO(85, 107, 47, 150),
                              elevation: 10),
                          child: const Text("Confirmar presença")),
                      const Divider(height: 30, color: Colors.transparent),
                      OutlinedButton(
                          onPressed: () {
                            Navigator.pushNamed(
                                context, MyRoutes.giftCatalogRoute);
                          },
                          style: OutlinedButton.styleFrom(
                              padding:
                                  const EdgeInsets.fromLTRB(28, 22, 28, 22),
                              foregroundColor: Colors.white,
                              backgroundColor:
                                  const Color.fromRGBO(85, 107, 47, 50),
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5))),
                              shadowColor:
                                  const Color.fromRGBO(85, 107, 47, 150),
                              elevation: 10),
                          child: const Text("Lista de presentes")),
                      const Divider(height: 30, color: Colors.transparent),
                      OutlinedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, MyRoutes.messageRoute);
                          },
                          style: OutlinedButton.styleFrom(
                              padding:
                                  const EdgeInsets.fromLTRB(28, 22, 28, 22),
                              foregroundColor: Colors.white,
                              backgroundColor:
                                  const Color.fromRGBO(85, 107, 47, 50),
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5))),
                              shadowColor:
                                  const Color.fromRGBO(85, 107, 47, 150),
                              elevation: 10),
                          child: const Text("Enviar mensagem")),
                    ],
                  ),
                ),
                const Divider(height: 50),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Material(
                      child: InkWell(
                        onTap: () {
                          js.context.callMethod('open',
                              ["https://goo.gl/maps/PzmGShH3PAVQfS1XA"]);
                        },
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.asset(
                              "assets/images/maps.jpeg",
                              width: MediaQuery.of(context).size.width / 1.1,
                            )),
                      ),
                    ),
                    const Text("Clique no mapa",
                        style: TextStyle(
                            color: Color.fromRGBO(85, 107, 47, 50),
                            fontWeight: FontWeight.bold,
                            fontSize: 12)),
                    const Divider(
                      height: 50,
                    ),
                    const Text("09 DE JUNHO DE 2023 - 17h15",
                        style: TextStyle(
                            color: Color.fromRGBO(85, 107, 47, 50),
                            fontWeight: FontWeight.bold,
                            fontSize: 18)),
                    const Divider(
                      height: 30,
                    ),
                    const Text("Espaço Villa Borghese",
                        style: TextStyle(
                            color: Color.fromRGBO(85, 107, 47, 50),
                            fontWeight: FontWeight.bold,
                            fontSize: 18)),
                    const Divider(
                      height: 5,
                    ),
                    const Text("AV. Cel Sezefredo Fagundes, 7505",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Color.fromRGBO(85, 107, 47, 50),
                            fontWeight: FontWeight.w500,
                            fontSize: 18)),
                    const FittedBox(
                        fit: BoxFit.fitWidth,
                        child: Text(
                            "Jardim das Pedras, São Paulo - SP, 02367-075",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Color.fromRGBO(85, 107, 47, 50),
                                fontWeight: FontWeight.w500))),
                    const Divider(
                      height: 30,
                    ),
                    ElevatedButton.icon(
                        onPressed: () {
                          js.context.callMethod('open', [
                            "https://calendar.google.com/calendar/event?action=TEMPLATE&tmeid=NTFma3B2ODlwcWdzZDE0MWUzcm1kYWNxZDMgZ3VpcmFyZGVsaWFyYWtha2lAbQ&tmsrc=guirardeliarakaki%40gmail.com"
                          ]);
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            side: const BorderSide(
                              color: Color.fromRGBO(85, 107, 47, 50),
                            ),
                            elevation: 0,
                            padding: const EdgeInsets.fromLTRB(10, 15, 10, 15)),
                        icon: const Icon(
                          Icons.calendar_month,
                          color: Color.fromRGBO(85, 107, 47, 80),
                        ),
                        label: const Text("Adicionar à agenda",
                            style: TextStyle(
                                color: Color.fromRGBO(85, 107, 47, 50),
                                fontWeight: FontWeight.bold)))
                  ],
                ),
                const Divider(height: 50)
              ],
            )));
  }
}
