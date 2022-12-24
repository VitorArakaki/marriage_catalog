import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:marriage_catalog/core/store.dart';
import 'package:marriage_catalog/models/cart.dart';
import 'package:marriage_catalog/models/catalog.dart';
import 'package:marriage_catalog/utils/routes.dart';
import 'package:velocity_x/velocity_x.dart';
import '../widgets/home_widgets/catalog_header.dart';
import '../widgets/home_widgets/catalog_list.dart';
import 'package:marriage_catalog/globals.dart' as globals;

class GiftCatalogPage extends StatefulWidget {
  const GiftCatalogPage({super.key});

  @override
  State<GiftCatalogPage> createState() => _GiftCatalogPageState();
}

class _GiftCatalogPageState extends State<GiftCatalogPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool loadedData = false;

  loadData() async {
    await Future.delayed(const Duration(seconds: 2));
    await FirebaseFirestore.instance
        .collection('products')
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        bool cont = false;

        for (var item in globals.content){
          if(item["id"] == doc["id"]) {
            setState(() {
              cont = true;
            });
          }
        }
        if(cont == false) {
          globals.content.add({
            "id": doc["id"],
            "name": doc["name"],
            "desc": doc["desc"],
            "price": doc["price"],
            "image": doc["image"]
          });
        }
      }
    });

    var catalogList = globals.content;
    var catalogJson = json.encode({"products": catalogList});
    var decodeData = jsonDecode(catalogJson);
    var productsData = decodeData['products'];
    CatalogModel.items =
        List.from(productsData).map((item) => Item.fromMap(item)).toList();

    setState(() {});

  }

  @override
  Widget build(BuildContext context) {
    final cart = (VxState.store as MyStore).cart;
    return MediaQuery.of(context).size.width > 1000 ?
    MediaQuery.of(context).size.width > 1433 ?
      Scaffold(
        backgroundColor: const Color.fromRGBO(237, 255, 213, 100),
        floatingActionButton: VxBuilder(
            mutations: const {AddMutation, RemoveMutation},
            builder: (context, _, __) => FloatingActionButton(
              onPressed: () =>
                  Navigator.pushNamed(context, MyRoutes.cartRoute),
              backgroundColor: const Color.fromRGBO(85, 107, 47, 50),
              child: const Icon(
                CupertinoIcons.cart,
                color: Colors.white,
              ),
            ).badge(
              size: 22,
              count: cart.items.length,
              textStyle: const TextStyle(
                color: Vx.black,
                fontWeight: FontWeight.bold,
              ),
            )),
        body: SafeArea(
          child: Container(
              padding: Vx.m32,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CatalogHeader(),
                if (CatalogModel.items.isNotEmpty)
                  const CatalogList().py16().expand()
                else
                  const CircularProgressIndicator(color: Color.fromRGBO(85, 107, 47, 50),).centered().expand(),
              ],
            ),
          ),
        )) :
      Scaffold(
        key: _scaffoldKey,
        backgroundColor: const Color.fromRGBO(237, 255, 213, 100),
        extendBodyBehindAppBar: true,
        appBar: AppBar(
            backgroundColor: Colors.transparent,
            leading: IconButton(
              icon: const Icon(Icons.menu, size: 55, color: Color.fromRGBO(
                  184, 211, 137, 1.0)), // change this size and style
              onPressed: () => _scaffoldKey.currentState?.openDrawer(),
            )
        ),
        drawer: Drawer(
        backgroundColor: const Color.fromRGBO(237, 255, 213, 1),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, MyRoutes.giftCatalogRoute);
                    },
                  child: const Text("Inicio",
                      style: TextStyle(
                          color: Color.fromRGBO(85, 107, 47, 1),
                          fontSize: 18,
                          fontWeight: FontWeight.w500))
              ),
              const Divider(),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Lista de presentes",
                      style: TextStyle(
                          color: Color.fromRGBO(85, 107, 47, 1),
                          fontSize: 18,
                          fontWeight: FontWeight.w500))
              ),
              const Divider(),
              TextButton(
                  onPressed: () {Navigator.pop(context);},
                  child: const Text("Confirmar presença",
                      style: TextStyle(
                          color: Color.fromRGBO(85, 107, 47, 1),
                          fontSize: 18,
                          fontWeight: FontWeight.w500))
              ),
              const Divider(),
              TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, MyRoutes.messageRoute);
                  },
                  child: const Text("Enviar mensagem",
                      style: TextStyle(
                          color: Color.fromRGBO(85, 107, 47, 1),
                          fontSize: 18,
                          fontWeight: FontWeight.w500))
              )
            ]
        ),
      ),
      floatingActionButton: VxBuilder(
            mutations: const {AddMutation, RemoveMutation},
            builder: (context, _, __) => FloatingActionButton(
              onPressed: () =>
                  Navigator.pushNamed(context, MyRoutes.cartRoute),
              backgroundColor: const Color.fromRGBO(85, 107, 47, 50),
              child: const Icon(
                CupertinoIcons.cart,
                color: Colors.white,
              ),
            ).badge(
              size: 22,
              count: cart.items.length,
              textStyle: const TextStyle(
                color: Vx.black,
                fontWeight: FontWeight.bold,
              ),
            )),
      body: SafeArea(
          child: Container(
            padding: Vx.m32,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Lista de presentes", style: TextStyle(color: const Color.fromRGBO(85, 107, 47, 50), fontSize: MediaQuery.of(context).size.width / 15, fontWeight: FontWeight.bold),),
                    Text("GABI & VINI", style: TextStyle(color: const Color.fromRGBO(85, 107, 47, 50), fontSize: MediaQuery.of(context).size.width / 18,))
                  ],
                ),
                if (CatalogModel.items.isNotEmpty)
                  const CatalogList().py16().expand()
                else
                  const CircularProgressIndicator(color: Color.fromRGBO(85, 107, 47, 50),).centered().expand(),
              ],
            ),
          ),
        )) :
      Scaffold(
        key: _scaffoldKey,
        backgroundColor: const Color.fromRGBO(237, 255, 213, 100),
        extendBodyBehindAppBar: true,
        appBar: AppBar(
            backgroundColor: Colors.transparent,
            leading: IconButton(
              icon: const Icon(Icons.menu, size: 40, color: Color.fromRGBO(
                  184, 211, 137, 1.0)), // change this size and style
              onPressed: () => _scaffoldKey.currentState?.openDrawer(),
            )
        ),
        drawer: Drawer(
            backgroundColor: const Color.fromRGBO(237, 255, 213, 1),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, MyRoutes.initialRoute);
                        },
                      child: const Text("Inicio",
                          style: TextStyle(
                              color: Color.fromRGBO(85, 107, 47, 1),
                              fontSize: 18,
                              fontWeight: FontWeight.w500))
                  ),
                  const Divider(),
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("Lista de presentes",
                          style: TextStyle(
                              color: Color.fromRGBO(85, 107, 47, 1),
                              fontSize: 18,
                              fontWeight: FontWeight.w500))
                  ),
                  const Divider(),
                  TextButton(
                      onPressed: () {Navigator.pop(context);},
                      child: const Text("Confirmar presença",
                          style: TextStyle(
                              color: Color.fromRGBO(85, 107, 47, 1),
                              fontSize: 18,
                              fontWeight: FontWeight.w500))
                  ),
                  const Divider(),
                  TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, MyRoutes.messageRoute);
                      },
                      child: const Text("Enviar mensagem",
                          style: TextStyle(
                              color: Color.fromRGBO(85, 107, 47, 1),
                              fontSize: 18,
                              fontWeight: FontWeight.w500))
                  )
                ]
            ),
          ),
        floatingActionButton: VxBuilder(
            mutations: const {AddMutation, RemoveMutation},
            builder: (context, _, __) => FloatingActionButton(
              onPressed: () =>
                  Navigator.pushNamed(context, MyRoutes.cartRoute),
              backgroundColor: const Color.fromRGBO(85, 107, 47, 50),
              child: const Icon(
                CupertinoIcons.cart,
                color: Colors.white,
              ),
            ).badge(
              size: 22,
              count: cart.items.length,
              textStyle: const TextStyle(
                color: Vx.black,
                fontWeight: FontWeight.bold,
              ),
            )),
        body: SafeArea(
          child: Container(
            padding: Vx.m32,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Lista de presentes", style: TextStyle(color: const Color.fromRGBO(85, 107, 47, 50), fontSize: MediaQuery.of(context).size.width / 15, fontWeight: FontWeight.bold),),
                    Text("GABI & VINI", style: TextStyle(color: const Color.fromRGBO(85, 107, 47, 50), fontSize: MediaQuery.of(context).size.width / 18,))
                  ],
                ),
                if (CatalogModel.items.isNotEmpty)
                  const CatalogList().py16().expand()
                else
                  const CircularProgressIndicator(color: Color.fromRGBO(85, 107, 47, 50),).centered().expand(),
              ],
            ),
          ),
        ));
  }
}