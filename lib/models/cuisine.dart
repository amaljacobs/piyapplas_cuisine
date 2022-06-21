import 'package:cloud_firestore/cloud_firestore.dart';

import 'category.dart';

class Cuisine{
  String name;
  Category category;
  double price;
  Cuisine({required this.name,required this.category,required this.price});

  static Cuisine fromDatabase(DocumentSnapshot doc){
    return Cuisine(name: doc['name'], category: Category.fromDatabase(doc['category']), price: doc['price']);
  }
}