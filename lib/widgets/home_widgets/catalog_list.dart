import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../models/catalog.dart';

import '../../pages/gift_detail_page.dart';
import 'add_to_cart.dart';
import 'catalog_image.dart';

class CatalogList extends StatelessWidget {
  const CatalogList({super.key});

  @override
  Widget build(BuildContext context) {
    return MediaQuery.of(context).size.width > 1000 ?
    GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4 , crossAxisSpacing: 20, mainAxisSpacing: 20),
        itemCount: CatalogModel.items.length,
        itemBuilder: (context, index) {
        final catalog = CatalogModel.items[index];
        return InkWell(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => GiftDetailPage(catalog: catalog),
              ),
            ),
            child: CatalogItem(catalog: catalog));
      },
    ) :
    GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2 , crossAxisSpacing: 20, mainAxisSpacing: 20),
        itemCount: CatalogModel.items.length,
        itemBuilder: (context, index) {
        final catalog = CatalogModel.items[index];
        return InkWell(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => GiftDetailPage(catalog: catalog),
              ),
            ),
            child: CatalogItem(catalog: catalog));
      },
    );
  }
}

class CatalogItem extends StatelessWidget {
  final Item catalog;

  const CatalogItem({Key? key, required this.catalog})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MediaQuery.of(context).size.width > 1000 ?
      VxBox(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              // const SizedBox(height: 10,),
              Hero(
                tag: Key(catalog.id.toString()),
                child: CatalogImage(image: catalog.image),
              ),
              Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(catalog.name, style: TextStyle(color: const Color.fromRGBO(85, 107, 47, 50), fontSize: MediaQuery.of(context).size.width / 55, fontWeight: FontWeight.bold)),
                      Text(catalog.desc, maxLines: 1, style: TextStyle(color: const Color.fromRGBO(85, 107, 47, 105), fontSize: MediaQuery.of(context).size.width / 65, fontWeight: FontWeight.bold)),
                      10.heightBox,
                      ButtonBar(
                        alignment: MainAxisAlignment.spaceBetween,
                        buttonPadding: EdgeInsets.zero,
                        children: [
                          Text("R\$${catalog.price}", style: TextStyle(color: const Color.fromRGBO(85, 107, 47, 50), fontSize: MediaQuery.of(context).size.width / 55, fontWeight: FontWeight.bold)),
                          AddToCart(
                            catalog: catalog,
                          )
                        ],
                      ).pOnly(right: 8)
                    ],
                  ))
            ],
          ),
          )).color(const Color.fromRGBO(85, 107, 47, 220)).rounded.square(10).make() :
      VxBox(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              Hero(
                tag: Key(catalog.id.toString()),
                child: CatalogImage(image: catalog.image),
              ),
              Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(catalog.name, style: TextStyle(color: const Color.fromRGBO(85, 107, 47, 50), fontSize: MediaQuery.of(context).size.width / 25, fontWeight: FontWeight.bold)),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text("R\$${catalog.price}", style: TextStyle(color: const Color.fromRGBO(85, 107, 47, 50), fontSize: MediaQuery.of(context).size.width / 30, fontWeight: FontWeight.bold)),
                      )
                      ],
                  )),
            ],
          ),
          )).color(const Color.fromRGBO(85, 107, 47, 220)).rounded.square(10).make();
  }
}