import 'package:flutter/material.dart';
import 'package:marriage_catalog/core/store.dart';
import 'package:marriage_catalog/pages/cart_page.dart';
import 'package:marriage_catalog/pages/gift_catalog_page.dart';
import 'package:marriage_catalog/pages/initial_page.dart';
import 'package:marriage_catalog/pages/message_page.dart';
import 'package:marriage_catalog/utils/routes.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(VxState(store: MyStore(), child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  /// The createState() function returns a State object
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Casamento Gabi e Vini",
        debugShowCheckedModeBanner: false,
        initialRoute: MyRoutes.initialRoute,
        routes: {
          "/": (context) => const GiftCatalogPage(),
          MyRoutes.giftCatalogRoute: (context) => const GiftCatalogPage(),
          MyRoutes.messageRoute: (context) => const MassagePage(),
          MyRoutes.cartRoute: (context) => const CartPage(),
          MyRoutes.initialRoute: (context) => const InitialPage(),
        });
  }
}