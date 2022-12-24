import 'package:flutter/material.dart';
import 'package:marriage_catalog/utils/routes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MassagePage extends StatefulWidget {
  const MassagePage({super.key});

  @override
  State<MassagePage> createState() => _MassagePageState();
}

class _MassagePageState extends State<MassagePage> {
  String name = "";
  bool changeButton = false;
  bool sendErrorMessage = false;
  bool sendMessageOk = false;

  CollectionReference messages = FirebaseFirestore.instance.collection('messages');

  final nameController = TextEditingController();
  final messageController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  moveToCheckout(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        changeButton = true;
      });
      await Future.delayed(const Duration(seconds: 1));
      await Navigator.pushNamed(context, MyRoutes.giftCatalogRoute);
      setState(() {
        changeButton = false;
      });
    }
  }

  void addMessage() async{
    if (_formKey.currentState!.validate()) {
      messages.add({
        'name': nameController.text.toString(),
        'message': messageController.text.toString()
      }).then((value) =>
          setState(() {
        changeButton = true;
        sendErrorMessage = false;
        sendMessageOk = true;
          })
      ).catchError((error) =>
          setState(() {
            changeButton = false;
            sendErrorMessage = true;
            sendMessageOk = false;
          })
      );
      await Future.delayed(const Duration(seconds: 1));

      setState(() {
        changeButton = false;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return MediaQuery.of(context).size.width > 1000 ?
    Scaffold(
        backgroundColor: const Color.fromRGBO(237, 255, 213, 100),
        body: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const Divider(),
                  Row(
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
                          Navigator.pushNamed(context, MyRoutes.giftCatalogRoute);
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
                  Image.asset(
                    "assets/images/visual_identity.png",
                    fit: BoxFit.cover,
                    height: 450 ,
                  ),
                  Text(
                    "Bem vindo(a) $name",
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(85, 107, 47, 50)
                    ),
                  ),
                  const Text(
                    "Envie uma mensagem de carinho para os noivos, para que eles leiam após a festa",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(85, 107, 47, 50)
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          SizedBox(
                            width: 600,
                            child: TextFormField(
                              controller: nameController,
                              style: const TextStyle(color: Color.fromRGBO(85, 107, 47, 50), fontWeight: FontWeight.bold),
                              decoration: const InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Color.fromRGBO(85, 107, 47, 50))
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 2, color: Color.fromRGBO(85, 107, 47, 50)
                                      )
                                  ),
                                  hintText: "Insira seu nome e sobrenome",
                                  labelText: "Nome Sobrenome",
                                  labelStyle: TextStyle(color: Color.fromRGBO(85, 107, 47, 50), fontWeight: FontWeight.normal)
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "O nome não pode estar vazio para que os noivos saibam está enviando o presente";
                                }
                                return null;
                              },
                              onChanged: (value) {
                                name = value;
                                setState(() {});
                              },
                            ),
                          ),
                          const SizedBox(height: 30,),
                          SizedBox(
                            width: 600,
                            child: TextFormField(
                              controller: messageController,
                              maxLines: null,
                              style: const TextStyle(color: Color.fromRGBO(85, 107, 47, 50), fontWeight: FontWeight.bold),
                              cursorColor: const Color.fromRGBO(85, 107, 47, 50),
                              decoration: const InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Color.fromRGBO(85, 107, 47, 50))
                                ),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 2, color: Color.fromRGBO(85, 107, 47, 50)
                                      )
                                  ),
                                  labelText: "Mensagem para os noivos",
                                  hintText: "Insira uma mensagem para os noivos",
                                  labelStyle: TextStyle(color: Color.fromRGBO(85, 107, 47, 50), fontWeight: FontWeight.normal)
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "A mensagem para os noivos nao pode estar vazia";
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          sendErrorMessage ? const Text("Erro ao enviar mensagem, tente novamente por favor!", style: TextStyle(color: Colors.red)) : const SizedBox(),
                          sendErrorMessage ? const Divider() : const SizedBox(),
                          sendMessageOk ? const Text("Muito Obrigado, sua mensagem foi enviada!", style: TextStyle(color: Colors.green)) : const SizedBox(),
                          sendMessageOk ? const Divider() : const SizedBox(),
                          Material(
                            color: const Color.fromRGBO(85, 107, 47, 50),
                            borderRadius:
                            BorderRadius.circular(changeButton ? 50 : 8),
                            child: InkWell(
                              onTap: () => {
                                addMessage()
                              },
                              child: AnimatedContainer(
                                duration: const Duration(seconds: 1),
                                height: 50,
                                width: changeButton ? 50 : 150,
                                alignment: Alignment.center,
                                child: changeButton
                                    ? const Icon(
                                  Icons.done,
                                  color: Colors.white,
                                )
                                    : const Text(
                                  "Enviar",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ))
                ],
              ),
            ))) :
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
                      Navigator.pushNamed(context, MyRoutes.giftCatalogRoute);
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
                    onPressed: () {Navigator.pop(context);},
                    child: const Text("Enviar mensagem",
                        style: TextStyle(
                            color: Color.fromRGBO(85, 107, 47, 1),
                            fontSize: 18,
                            fontWeight: FontWeight.w500))
                )
              ]
          ),
        ),
        body: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const Divider(),
                  Image.asset(
                    "assets/images/visual_identity.png",
                    fit: BoxFit.cover,
                    height: MediaQuery.of(context).size.width / 1.5 ,
                  ),
                  Text(
                    "Bem vindo(a) $name",
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width / 20,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromRGBO(85, 107, 47, 50)
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                    child: Text(
                      "Envie uma mensagem de carinho para os noivos, para que eles leiam após a festa",
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width / 35,
                          fontWeight: FontWeight.bold,
                          color: const Color.fromRGBO(85, 107, 47, 50)
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          SizedBox(
                            width: 600,
                            child: TextFormField(
                              controller: nameController,
                              style: const TextStyle(color: Color.fromRGBO(85, 107, 47, 50), fontWeight: FontWeight.bold),
                              decoration: const InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Color.fromRGBO(85, 107, 47, 50))
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 2, color: Color.fromRGBO(85, 107, 47, 50)
                                      )
                                  ),
                                  hintText: "Insira seu nome e sobrenome",
                                  labelText: "Nome Sobrenome",
                                  labelStyle: TextStyle(color: Color.fromRGBO(85, 107, 47, 50), fontWeight: FontWeight.normal)
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "O nome não pode estar vazio para que os noivos saibam está enviando o presente";
                                }
                                return null;
                              },
                              onChanged: (value) {
                                name = value;
                                setState(() {});
                              },
                            ),
                          ),
                          const SizedBox(height: 30,),
                          SizedBox(
                            width: 600,
                            child: TextFormField(
                              controller: messageController,
                              maxLines: null,
                              style: const TextStyle(color: Color.fromRGBO(85, 107, 47, 50), fontWeight: FontWeight.bold),
                              cursorColor: const Color.fromRGBO(85, 107, 47, 50),
                              decoration: const InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Color.fromRGBO(85, 107, 47, 50))
                                ),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 2, color: Color.fromRGBO(85, 107, 47, 50)
                                      )
                                  ),
                                  labelText: "Mensagem para os noivos",
                                  hintText: "Insira uma mensagem para os noivos",
                                  labelStyle: TextStyle(color: Color.fromRGBO(85, 107, 47, 50), fontWeight: FontWeight.normal)
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "A mensagem para os noivos nao pode estar vazia";
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          sendErrorMessage ? const Text("Erro ao enviar mensagem, tente novamente por favor!", style: TextStyle(color: Colors.red)) : const SizedBox(),
                          sendErrorMessage ? const Divider() : const SizedBox(),
                          sendMessageOk ? const Text("Muito Obrigado, sua mensagem foi enviada!", style: TextStyle(color: Colors.green)) : const SizedBox(),
                          sendMessageOk ? const Divider() : const SizedBox(),
                          Material(
                            color: const Color.fromRGBO(85, 107, 47, 50),
                            borderRadius:
                            BorderRadius.circular(changeButton ? 50 : 8),
                            child: InkWell(
                              onTap: () => {
                                addMessage()
                              },
                              child: AnimatedContainer(
                                duration: const Duration(seconds: 1),
                                height: 50,
                                width: changeButton ? 50 : 150,
                                alignment: Alignment.center,
                                child: changeButton
                                    ? const Icon(
                                  Icons.done,
                                  color: Colors.white,
                                )
                                    : const Text(
                                  "Enviar",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ))
                ],
              ),
            )));
  }

}