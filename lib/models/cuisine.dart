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

  static Map<String,dynamic> toMap(Cuisine cuisine){
    return {
      'name' : cuisine.name,
      'price' : cuisine.price,
      'category' : Category.toMap(cuisine.category)
    };
  }
}