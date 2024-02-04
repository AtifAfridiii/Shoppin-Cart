import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping/screens/cart_provider.dart';
import 'package:shopping/screens/productlist.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (_) => CartProvider(),
    child: Builder(
      builder: (BuildContext context) {
      return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        
        useMaterial3: true,
      ),
      home:Product_list(),
    );
    }));
    
  }
}

