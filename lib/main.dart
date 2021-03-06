import 'package:flutter/material.dart';
import 'package:restaurant_order/screens/admin.dart';
import 'package:restaurant_order/screens/customer/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:restaurant_order/screens/kitchen.dart';
import 'package:restaurant_order/screens/portal_selection.dart';
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
      initialRoute: '/',
      routes: {
        '/':(context)=>const PortalSelect(),
        '/orders':(context)=>const CustomerHome(title: ''),
        '/kitchen':(context)=>const Kitchen(),
        '/admin':(context)=>const Admin()
      },
      debugShowCheckedModeBanner: false,
      title: 'Piyaplas Cuisine Orders',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
    );
  }
}
