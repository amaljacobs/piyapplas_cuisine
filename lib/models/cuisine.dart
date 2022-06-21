import 'package:cloud_firestore/cloud_firestore.dart';

import 'category.dart';

class Cuisine{
  String name;
  Category category;
  double price;
  Cuisine({required this.name,required this.category,required this.price});

  static Cuisine fromDatabase(DocumentSnapshot doc){
    Cuisine cuisine = Cuisine(name: doc['name'], category: Category.fromMap(doc['category']), price: (doc['price'] as double));
    return cuisine;
  }
}