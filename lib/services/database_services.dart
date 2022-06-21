
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/category.dart';
import '../models/cuisine.dart';

class DatabaseServices{
  late CollectionReference categoryCollection;
  late CollectionReference cuisineCollection;
  DatabaseServices(){
    categoryCollection = FirebaseFirestore.instance.collection('Categories');
    cuisineCollection = FirebaseFirestore.instance.collection('Cuisines');
  }

  Stream<List<Category>> getCategories(){
    return categoryCollection.snapshots().map((snap) => snap.docs.map((e) => Category.fromDatabase(e)).toList());
  }

  Stream<List<Cuisine>> getCuisines(){
    return cuisineCollection.snapshots().map((snap) => snap.docs.map((e) => Cuisine.fromDatabase(e)).toList());
  }
}