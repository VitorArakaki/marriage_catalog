import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:marriage_catalog/models/cart.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:http/http.dart' as http;
import 'dart:js' as js;

import '../core/store.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(237, 255, 213, 100),
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Color.fromRGBO(85, 107, 47, 50),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: const Text("Carrinho", style: TextStyle(color: Color.fromRGBO(85, 107, 47, 50), fontSize: 20, fontWeight: FontWeight.bold),)
      ),
      body: Column(
        children: [
          _CartList().p32().expand(),
          const Divider(),
          _CartTotal(),
        ],
      ),
    );
  }
}

class _CartTotal extends StatelessWidget {

  final nameController = TextEditingController();

  Future<void> sendBuy (totalItems) async {
    final result = await http.post(
      Uri.parse('https://api.mercadopago.com/checkout/preferences?access_token=APP_USR-5082705237955275-121923-e15eadd369f3c9743b390f5c06201a2f-210301256'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        "external_reference": "lista-casamento",
        "payer": {
          "name": nameController.text
        },
        "items": totalItems
      }),
    );

    js.context.callMethod('open', [jsonDecode(result.body)['init_point']]);
  }

  @override
  Widget build(BuildContext context) {
    final CartModel cart = (VxState.store as MyStore).cart;
    return cart.items.isNotEmpty ?
    SizedBox(
      height: 200,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          VxConsumer(
            notifications: const {},
            mutations: const {RemoveMutation},
            builder: (context, _, __) {
              return Text("R\$${cart.totalPrice}", style: const TextStyle(color: Color.fromRGBO(85, 107, 47, 50), fontSize: 30));
            },
          ),
          30.widthBox,
          ElevatedButton(
            onPressed: () {
              List totalItems = [];
              for(var i = 0; i < cart.items.length; i++){
                totalItems.add({
                  "title": cart.items[i].name,
                  "quantity": 1,
                  "currency_id": "BRL",
                  "unit_price": cart.items[i].price,
                  "picture_url": cart.items[i].image
                });
              }
              show(context, totalItems);
            },
            style: ElevatedButton.styleFrom(
              minimumSize: MediaQuery.of(context).size.width <= 500 ?
              Size(MediaQuery.of(context).size.width / 2, MediaQuery.of(context).size.height / 11) :
              Size(MediaQuery.of(context).size.width / 3, MediaQuery.of(context).size.height / 14) ,
              backgroundColor: const Color.fromRGBO(85, 107, 47, 50),
            ),
            child: "Comprar".text.white.make(),
          ),
        ],
      ),
    ) :
    const SizedBox();
  }

  void show(BuildContext context, totalItems) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 250,
          color:  const Color.fromRGBO(237, 255, 180, 100),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(
                  width: 600,
                  child: TextField(
                    controller: nameController,
                    style: const TextStyle(color: Color.fromRGBO(100, 107, 76, 1), fontWeight: FontWeight.bold),
                    decoration: const InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color.fromRGBO(100, 107, 76, 1))
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 2, color: Color.fromRGBO(100, 107, 76, 1)
                            )
                        ),
                        hintText: "Insira seu nome e sobrenome",
                        labelText: "Nome Sobrenome",
                        labelStyle: TextStyle(color: Color.fromRGBO(100, 107, 76, 1), fontWeight: FontWeight.normal)
                    ),
                  ),
                ),
                const Divider(height: 25,),
                ElevatedButton(
                  onPressed: () async {
                    if(nameController.text.isNotBlank) {
                      sendBuy(totalItems);
                    } else {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          backgroundColor: Color.fromRGBO(85, 107, 47, 50),
                          content: Text("Por favor, insira seu nome para continuar.", style: TextStyle(color: Colors.white, fontSize: 20)),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: MediaQuery.of(context).size.width <= 500 ?
                    Size(MediaQuery.of(context).size.width / 3, MediaQuery.of(context).size.height / 20) :
                    Size(MediaQuery.of(context).size.width / 4, MediaQuery.of(context).size.height / 20) ,
                    backgroundColor: const Color.fromRGBO(85, 107, 47, 50),
                  ),
                  child: "Continuar".text.white.make(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _CartList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    VxState.watch(context, on: [RemoveMutation]);
    final CartModel cart = (VxState.store as MyStore).cart;
    return cart.items.isEmpty
        ? const Text("Nada no carrinho", style: TextStyle(color: Color.fromRGBO(85, 107, 47, 50), fontSize: 25),)
        : ListView.builder(
      itemCount: cart.items.length,
      itemBuilder: (context, index) => Column(
        children: [
          ListTile(
            leading: Image.network(cart.items[index].image),
            trailing: IconButton(
              icon: const Icon(Icons.remove_circle_outline, color: Color.fromRGBO(85, 107, 47, 50)),
              onPressed: () {
                RemoveMutation(cart.items[index]);
                //setState(() {});
              },
            ),
            title: Text(cart.items[index].name, style: const TextStyle(color: Color.fromRGBO(85, 107, 47, 50), fontSize: 20)),
          ),
          const Divider()
        ],
      ),
    );
  }
}