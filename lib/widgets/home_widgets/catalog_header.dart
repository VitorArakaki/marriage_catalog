import 'package:flutter/material.dart';

import '../../utils/routes.dart';

class CatalogHeader extends StatelessWidget {
  const CatalogHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text("Lista de presentes", style: TextStyle(color: Color.fromRGBO(85, 107, 47, 50), fontSize: 50),),
            Text("GABI & VINI", style: TextStyle(color: Color.fromRGBO(85, 107, 47, 50), fontSize: 25,))
          ],
        )),
        Expanded(
          flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, MyRoutes.initialRoute);
                  },
                  child: const Text("Inicio",
                      style: TextStyle(
                          color: Color.fromRGBO(85, 107, 47, 50),
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          decoration: TextDecoration.underline)),
                ),
                const VerticalDivider(),
                TextButton(
                  onPressed: () {

                  },
                  child: const Text("Lista de presentes",
                      style: TextStyle(
                          color: Color.fromRGBO(85, 107, 47, 50),
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          decoration: TextDecoration.underline)),
                ),
                const VerticalDivider(),
                TextButton(
                  onPressed: () {},
                  child: const Text("Confirmar presença",
                      style: TextStyle(
                          color: Color.fromRGBO(85, 107, 47, 50),
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          decoration: TextDecoration.underline)),
                ),
                const VerticalDivider(),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, MyRoutes.messageRoute);
                  },
                  child: const Text("Enviar mensagem",
                      style: TextStyle(
                          color: Color.fromRGBO(85, 107, 47, 50),
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          decoration: TextDecoration.underline)),
                ),
                const VerticalDivider(),
              ],
            ),
        )
      ],
    );
  }
}