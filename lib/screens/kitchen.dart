import 'package:flutter/material.dart';
import 'package:restaurant_order/services/database_services.dart';

import '../models/order.dart';

class Kitchen extends StatefulWidget {
  const Kitchen({Key? key}) : super(key: key);

  @override
  State<Kitchen> createState() => _KitchenState();
}

class _KitchenState extends State<Kitchen> {
  List<Order> orders = [];
  List<Order> selectedOrders = [];
  static List<Widget> _widgetOptions = <Widget>[];
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    _widgetOptions = [placedOrders(), processingOrders(), completedOrders()];
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.new_releases_rounded), label: 'Placed'),
            BottomNavigationBarItem(icon: Icon(Icons.access_time_filled_rounded), label: 'Processing'),
            BottomNavigationBarItem(icon: Icon(Icons.done_outline_rounded), label: 'Completed'),
          ],
          currentIndex: _selectedIndex,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
        ),
        body: _widgetOptions[_selectedIndex]);
  }

  Widget placedOrders() {
    return StreamBuilder<List<Order>>(
        stream: DatabaseServices().getOrders(),
        builder: (context, orderSnap) {
          if (orderSnap.hasData) {
            orders = orderSnap.data!;
            selectedOrders = orders.where((element) => element.status == 'placed').toList();
            selectedOrders.sort((a,b)=>(b.orderTime.compareTo(a.orderTime)));
          }
          print('Selected Order $selectedOrders');
          return Container(
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: selectedOrders.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  child: ExpansionTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(selectedOrders[index].orderNum.toString()),
                        TextButton(onPressed: ()async{
                          DatabaseServices().updateOrderStatus(selectedOrders[index]);
                        }, child: Text('Process'))
                      ],
                    ),
                    children: [
                      ListView(
                        shrinkWrap: true,
                        children: selectedOrders[index].cuisines.map((e){
                          return ListTile(
                            title: Text(e.name),
                            subtitle: Text('₹${e.price.toString()}'),
                          );
                        }).toList(),
                      )
                    ],
                  ),
                );
              },
            ),
          );
        });
  }

  Widget processingOrders() {
    return StreamBuilder<List<Order>>(
        stream: DatabaseServices().getOrders(),
        builder: (context, orderSnap) {
          if (orderSnap.hasData) {
            orders = orderSnap.data!;
            selectedOrders = orders.where((element) => element.status == 'processing').toList();
          }
          print(selectedOrders);
          return Container(
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: selectedOrders.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  child: ExpansionTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(selectedOrders[index].orderNum.toString()),
                        TextButton(onPressed: ()async{
                          DatabaseServices().updateOrderStatus(selectedOrders[index]);
                        }, child: Text('Complete'))
                      ],
                    ),
                    children: [
                      ListView(
                        shrinkWrap: true,
                        children: selectedOrders[index].cuisines.map((e){
                          return ListTile(
                            title: Text(e.name),
                            subtitle: Text('₹${e.price.toString()}'),
                          );
                        }).toList(),
                      )
                    ],
                  ),
                );
              },
            ),
          );
        });
  }

  Widget completedOrders() {
    return StreamBuilder<List<Order>>(
        stream: DatabaseServices().getOrders(),
        builder: (context, orderSnap) {
          if (orderSnap.hasData) {
            orders = orderSnap.data!;
            selectedOrders = orders.where((element) => element.status == 'completed').toList();
          }
          print(selectedOrders);
          return Container(
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: selectedOrders.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  child: ExpansionTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(selectedOrders[index].orderNum.toString()),
                        // TextButton(onPressed: ()async{
                        //   DatabaseServices().updateOrderStatus(selectedOrders[index]);
                        // }, child: Text('Bill'))
                      ],
                    ),
                    children: [
                      ListView(
                        shrinkWrap: true,
                        children: selectedOrders[index].cuisines.map((e){
                          return ListTile(
                            title: Text(e.name),
                            subtitle: Text('₹${e.price.toString()}'),
                          );
                        }).toList(),
                      )
                    ],
                  ),
                );
              },
            ),
          );
        });
  }
}
