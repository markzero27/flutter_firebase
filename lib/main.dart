import 'package:flutter/material.dart';
import 'package:flutter_firebase/providers/product_provider.dart';
import 'package:flutter_firebase/screens/product.dart';
import 'package:flutter_firebase/services/firestore_services.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final firestore = FireStoreService();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ProductProvider()),
        StreamProvider(
          create: (context) => firestore.getProducts(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Products(),
      ),
    );
  }
}
