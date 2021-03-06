import 'package:cloud_firestore/cloud_firestore.dart';

import 'category.dart';

class Cuisine{
  String name;
  Category category;
  double price;
  bool visibility;
  Cuisine({required this.name,required this.category,required this.price,required this.visibility});

  static Cuisine fromDatabase(DocumentSnapshot doc){
    Cuisine cuisine = Cuisine(name: doc['name'].toString(), category: Category.fromMap(doc['category']), price: (double.parse(doc['price'].toString())),visibility: (doc['visibility'] as bool));
    return cuisine;
  }
  static Cuisine fromMap(Map<String,dynamic> doc){
    Cuisine cuisine = Cuisine(name: doc['name'].toString(), category: Category.fromMap(doc['category']), price: (double.parse(doc['price'].toString())),visibility: (doc['visibility'] as bool));
    return cuisine;
  }

  static Map<String,dynamic> toMap(Cuisine cuisine){
    return {
      'name' : cuisine.name,
      'price' : cuisine.price,
      'category' : Category.toMap(cuisine.category),
      'visibility' : cuisine.visibility
    };
  }
}