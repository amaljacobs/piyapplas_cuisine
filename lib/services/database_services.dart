
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/category.dart';
import '../models/cuisine.dart';
import '../models/order.dart';

class DatabaseServices{
  late CollectionReference categoryCollection;
  late CollectionReference cuisineCollection;
  late CollectionReference ordersCollection;
  late CollectionReference indexCollection;
  DatabaseServices(){
    categoryCollection = FirebaseFirestore.instance.collection('Categories');
    cuisineCollection = FirebaseFirestore.instance.collection('Cuisines');
    ordersCollection = FirebaseFirestore.instance.collection('Orders');
    indexCollection = FirebaseFirestore.instance.collection('Index');

  }

  Stream<List<Category>> getCategories(){
    return categoryCollection.snapshots().map((snap) => snap.docs.map((e) => Category.fromDatabase(e)).toList());
  }

  Stream<List<Cuisine>> getCuisines(){
    return cuisineCollection.snapshots().map((snap) => snap.docs.map((e) => Cuisine.fromDatabase(e)).toList());
  }

  Future<void> placeOrders(Order order)async {
    int orderNumber=0;
    DocumentSnapshot indexDoc = await indexCollection.doc('ordersIndex').get();
    if(indexDoc.exists){
      orderNumber = indexDoc.get('orderNum');
      orderNumber++;
      order.orderNum = orderNumber;
      indexCollection.doc('ordersIndex').update({'orderNum' : orderNumber});
    }
    else{
      indexCollection.doc('ordersIndex').set({'orderNum' : orderNumber});
    }
    return ordersCollection.doc(order.orderNum.toString()).set(Order.toMap(order));
  }
  
  Stream<List<Order>> getOrders(){
    Stream<List<Order>> orders = ordersCollection.snapshots().map((snap) => snap.docs.map((e) => Order.fromDatabase(e)).toList());
    return (orders);
  }

  Future<void> updateOrderStatus(Order order) async{
    print(order.status);
    if(order.status.compareTo('placed')==0)
      order.status='processing';
    else
      order.status='completed';
    return await ordersCollection.doc(order.orderNum.toString()).set(Order.toMap(order));
  }
}