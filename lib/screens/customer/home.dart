import 'package:flutter/material.dart';
import 'package:restaurant_order/services/database_services.dart';

class CustomerHome extends StatefulWidget {
  const CustomerHome({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<CustomerHome> createState() => _CustomerHomeState();
}

class _CustomerHomeState extends State<CustomerHome> {
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Piyaplas Cuisine'),
      ),
      body: Container(
        margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
        child: Column(
          children: [
            Text('Search'),
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Column(
                    children: [Text('Categories')],
                  ),
                ),
                Expanded(flex: 7, child: Column(
                  children: [
                    Text('Items')
                  ],
                ))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
