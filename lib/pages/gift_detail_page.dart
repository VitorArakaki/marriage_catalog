import 'package:flutter/material.dart';
import 'package:marriage_catalog/widgets/home_widgets/add_to_cart.dart';
import 'package:velocity_x/velocity_x.dart';

import '../models/catalog.dart';

class GiftDetailPage extends StatelessWidget {
  final Item catalog;

  const GiftDetailPage({Key? key, required this.catalog})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Color.fromRGBO(85, 107, 47, 50),
        ),
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: const Color.fromRGBO(237, 255, 213, 100),
      bottomNavigationBar: Container(
        color: const Color.fromRGBO(85, 107, 47, 200),
        child: ButtonBar(
          alignment: MainAxisAlignment.spaceBetween,
          buttonPadding: EdgeInsets.zero,
          children: [
            Text("R\$${catalog.price}", style: const TextStyle(color: Color.fromRGBO(85, 107, 47, 50), fontWeight: FontWeight.bold, fontSize: 35)),
            AddToCart(
              catalog: catalog,
            ).wh(130, 50)
          ],
        ).p16(),
      ),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Hero(
              tag: Key(catalog.id.toString()),
              child: Image.network(catalog.image,
              width: MediaQuery.of(context).size.height / 1.1,),
            ),
            Expanded(
                child: VxArc(
                  height: 10,
                  arcType: VxArcType.CONVEY,
                  edge: VxEdge.TOP,
                  child: Container(
                    color: Colors.transparent,
                    width: context.screenWidth,
                    child: Column(
                      children: [
                        Text(catalog.name, style: const TextStyle(color: Color.fromRGBO(85, 107, 47, 50), fontWeight: FontWeight.bold, fontSize: 30)),
                        Text(catalog.desc, style: const TextStyle(color: Color.fromRGBO(85, 107, 47, 100), fontWeight: FontWeight.bold, fontSize: 15)),
                        10.heightBox
                      ],
                    ).py(32),
                  ),
                ))
          ],
        ).p16(),
      ),
    );
  }
}