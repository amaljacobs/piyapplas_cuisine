import 'package:flutter/material.dart';
import 'package:restaurant_order/screens/customer/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Piyaplas Cuisine Orders',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: const CustomerHome(title: 'Flutter Demo Home Page'),
    );
  }
}
