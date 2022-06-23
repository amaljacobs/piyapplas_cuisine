import 'package:cloud_firestore/cloud_firestore.dart';

import 'cuisine.dart';
import 'package:collection/collection.dart';
class Order{
  int orderNum;
  List<Cuisine> cuisines;
  DateTime orderTime;
  String status;
  late double total;
  Order({required this.cuisines,required this.orderTime,required this.status, required this.orderNum}){
    total = cuisines.map((e) => e.price).sum;
  }

  static Map<String,dynamic> toMap(Order order){
    List<Map<String,dynamic>> cuisineList=[];
    order.cuisines.forEach((element) {
      cuisineList.add(Cuisine.toMap(element));
    });
    return {
      'orderNum' : order.orderNum,
      'cuisines' : cuisineList,
      'orderTime' : order.orderTime,
      'total' : order.total,
      'status' : order.status
    };
  }

  static Order fromDatabase(DocumentSnapshot doc){
    Order order = Order(orderNum:doc['orderNum'],cuisines: (doc['cuisines'] as List).map((e) => Cuisine.fromMap(e)).toList(), orderTime: (doc['orderTime'] as Timestamp).toDate(), status: doc['status'].toString());
    return order;
  }
}