import 'package:flutter/material.dart';
import 'package:restaurant_order/screens/customer/home.dart';
class PortalSelect extends StatefulWidget {
  const PortalSelect({Key? key}) : super(key: key);

  @override
  State<PortalSelect> createState() => _PortalSelectState();
}

class _PortalSelectState extends State<PortalSelect> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(

              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("Orders"),
              ),
              onPressed: (){
                Navigator.pushNamed(context, '/orders');
              },
            ),
            ElevatedButton(
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("Kitchen"),
              ),
              onPressed: (){
                Navigator.pushNamed(context, '/kitchen');
              },
            ),
            ElevatedButton(
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("Admin"),
              ),
              onPressed: (){
                Navigator.pushNamed(context, '/admin');
              },
            )
          ],
        ),
      ),
    );
  }
}
