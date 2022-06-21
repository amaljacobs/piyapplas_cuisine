import 'package:cloud_firestore/cloud_firestore.dart';

class Category{
  String category;
  bool veg;
  Category({required this.category,required this.veg});

  static Category fromDatabase(DocumentSnapshot doc){
    return Category(category: doc['category'], veg: doc['veg'] as bool);
  }
}