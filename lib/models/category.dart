import 'package:cloud_firestore/cloud_firestore.dart';

class Category{
  String category;
  bool veg;
  Category({required this.category,required this.veg});

  static Category fromDatabase(DocumentSnapshot doc){
    return Category(category: doc['category'], veg: doc['veg'] as bool);
  }
  static Category fromMap(Map<String,dynamic> doc){
    Category category = Category(category: doc['category'].toString(), veg: (doc['veg'] as bool));
    return category;
  }

  static Map<String,dynamic> toMap(Category category){
    return {
      'category' : category.category,
      'veg' : category.veg
    };
  }
}