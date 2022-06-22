import 'cuisine.dart';
import 'package:collection/collection.dart';
class Order{
  List<Cuisine> cuisines;
  DateTime orderTime;
  late double total;
  Order({required this.cuisines,required this.orderTime}){
    total = cuisines.map((e) => e.price).sum;
  }

  static Map<String,dynamic> toMap(Order order){
    List<Map<String,dynamic>> cuisineList=[];
    order.cuisines.forEach((element) {
      cuisineList.add(Cuisine.toMap(element));
    });
    return {
      'cuisines' : cuisineList,
      'orderTime' : order.orderTime,
      'total' : order.total
    };
  }
}